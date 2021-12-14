function channelSounding(genTxSignals, simulOutputName, signalNames, nSamples, nDelays,...
    repMontCarlo, lenTxSignals, channelModel, snrMin, snrStep, snrMax)
fprintf(' Sounding Simulation...')

nSignals=length(signalNames); %Quantity of signals
soundingNorm=zeros(1,nSignals);
%% Monte Carlo Simulation for Different Sounding Signals
for ss=1:length(lenTxSignals) %different signal sizes

%% Define Transmitting Signal
txSignal=zeros(nSignals,lenTxSignals(ss));
Ga=0; Gb=0;
for kk=1:nSignals
% Generate
if genTxSignals=="on"
generateTxSignals(lenTxSignals(ss), signalNames, simulOutputName);    
end
% Load Tx Signals 
txI=dlmread(strcat("../results/",simulOutputName,"/inputData/txSignals/",...
    signalNames(kk),"_I_",num2str(lenTxSignals(ss)),".txt"))';
txQ=dlmread(strcat("../results/",simulOutputName,"/inputData/txSignals/",...
    signalNames(kk),"_Q_",num2str(lenTxSignals(ss)),".txt"))';
txSignal(kk,:)=txI + j*txQ;  
   
% Assembling Sounding Normalizing Array
soundingNorm(kk)=lenTxSignals(ss);

% Store Signal Names
IDSFs(kk).signalName=signalNames(kk);


%% Simulate Signal Propagation Through Channel 
rxSignal=[]; IDSFaux=[]; CIRaux1=[]; CIRaux2=[];

for montC=1:repMontCarlo % Monte Carlo Repetitions
for snrdB = snrMin:snrStep:snrMax % Varying Different SNR values in dB   
for ii=1:nSamples(1) % Varying Different Time Samples

% Convolution of Transmitted Signal with Channel Model Impulse Response
if signalNames(kk)=="SEQN-Ga" || signalNames(kk)=="SEQN-Gb" 
rxSignal1 = conv(txSignal(kk,:), channelModel(montC).cirModelMontC(ii,:)); 
rxSignalAwgn1 = rxSignal1;%addAwgn(txSignal(kk,:), rxSignal1, snrdB);
else
rxSignal2 = conv(txSignal(kk,1:end-1), channelModel(montC).cirModelMontC(ii,:)); 
rxSignalAwgn2 = addAwgn(txSignal(kk,1:end-1), rxSignal2, snrdB);
end

%% Estimate Time-variant Channel Impulse Response - IDSF
% Cross-correlation Between transmitted and received signals
if signalNames(kk)=="SEQN-Ga" || signalNames(kk)=="SEQN-Gb" 
CIRaux1(ii,:)=cconv(rxSignalAwgn1, flip(conj(txSignal(kk,:))),lenTxSignals(ss)-1); 
else
CIRaux2(ii,:)=cconv(rxSignalAwgn2, flip(conj(txSignal(kk,1:end-1))),lenTxSignals(ss)-1); 
CIRaux2(ii,:)=circshift(CIRaux2(ii,:),1);
end

end

% Vector Ajustments and Sounding Normalization
if signalNames(kk)=="SEQN-Ga" || signalNames(kk)=="SEQN-Gb" 
IDSFs(kk).signals(montC).monteCarlo((snrdB-snrMin)/snrStep+1).snrs=...
CIRaux1(:,1:nDelays)./soundingNorm(kk);
else
IDSFs(kk).signals(montC).monteCarlo((snrdB-snrMin)/snrStep+1).snrs=...
CIRaux2(:,1:nDelays)./(soundingNorm(kk)-1);
end

end
end

% Store IDSF sounding signals
signalIDSF=IDSFs(kk).signals; 

% Store Auxiliar Data
signalIDSF(1).snrMin=snrMin;   signalIDSF(1).snrStep=snrStep; 
signalIDSF(1).snrMax=snrMax;   signalIDSF(1).nSamples=nSamples; 

% Save Estimated IDSF Data
outputName=strcat("IDSF_",signalNames(kk),"_",num2str(lenTxSignals(ss)),...
        "len_",num2str(nSamples(1)),"samp_",num2str(repMontCarlo),"rep");
save(strcat("../results/", simulOutputName,"/soundingIDSF/",...
    outputName,".mat"),'signalIDSF');

if signalNames(kk) == "SEQN-Ga"; Ga=kk; end
if signalNames(kk) == "SEQN-Gb"; Gb=kk; end
end

% Estimate Golay IDSF
if Ga~=0 && Gb~=0
for montC=1:repMontCarlo % Monte Carlo Repetitions
for snrdB = snrMin:snrStep:snrMax % % Varying Different Eb/N0 in dB 
signalIDSF(montC).monteCarlo((snrdB-snrMin)/snrStep+1).snrs=...
    (IDSFs(Ga).signals(montC).monteCarlo((snrdB-snrMin)/snrStep+1).snrs+...
    IDSFs(Gb).signals(montC).monteCarlo((snrdB-snrMin)/snrStep+1).snrs)/2;
end
end
% Save Golay IDSF 
auxName=char(signalNames(Gb)); auxName(7)='y';
outputName=strcat("IDSF_",auxName,"_",num2str(lenTxSignals(ss)),"len_",...
           num2str(nSamples(1)),"samp_",num2str(repMontCarlo),"rep");
save(strcat("../results/", simulOutputName,"/soundingIDSF/",...
    outputName,".mat"),'signalIDSF');
end
end
fprintf(' Completed! \n')
end