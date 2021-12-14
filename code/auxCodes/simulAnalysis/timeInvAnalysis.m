clc; clear all; close all;

addpath(genpath('../../simulations'));
addpath(genpath('../../auxCodes'));

%% Load Input Parameters
eval("inputParameters1"); 

%% Output Parameters
simulOutputName="auxSimulation1"; % set for naming output simulation data
savePlot="plot"; % "save"=Just save/"plot"=Just plot/"all"=Save/Plot / "off"
language="por"; % Plot Language: "por"=Portuguese / "eng"=English
makeFoldersAux(simulOutputName); % Make Folders

%% Input Parameters for Loading CIR Model 
simulInputName="simulation1"; % set for choosing input simulation data
repMontCarlo=4; % Monte Carlo Repetitions            

% Load CIR Model 
inputName=strcat("CIR_Model_",num2str(modelNsamples),"samp_",...
    num2str(repMontCarlo),"rep");
load(strcat("../../../results/",simulInputName,"/inputData/cirModel/",...
    inputName,".mat"));
cirModel=channelModel(1).cirModelMontC(90,:);

% Transmitting Singnals 
signalNames=["SEQN-RD"; "SEQN-KA"; "SEQN-GD"; "SEQN-PN"; "SEQN-ZC";...
             "SEQN-Ga"; "SEQN-Gb"]; % Sequences Names  
nSignals=length(signalNames); % quantity of signals
lenTxSignal=1024; % sequence length

% Sounding parameters
soundingNorm=lenTxSignal; % Estimated CIR normalization
snrMin=-20; snrStep=5; snrMax = 40; % snr em dB 
snrAxis=[snrMin:snrStep:snrMax]; % snr vector

%% Generate Tx Signals
txSignal=generateTxSignals(lenTxSignal, signalNames);    
%txSignal(4,:)=[zeros(1,lenTxSignal/2) 1 zeros(1,lenTxSignal/2-1)];

%% Sounding Simulator

for snrdB = snrAxis % Varying Different SNR in dB   
Ga=0; Gb=0; 
for kk=1:nSignals
% Simulate Signal Propagation Through Channel

if signalNames(kk)=="SEQN-Ga" || signalNames(kk)=="SEQN-Gb" 
rxSignal1 = conv(txSignal(kk,:), cirModel); 
rxSignalAwgn1(kk,:) = addAwgn(txSignal(kk,:), rxSignal1, snrdB);
else
rxSignal2 = conv(txSignal(kk,1:end-1), cirModel); 
rxSignalAwgn2(kk,:) = addAwgn(txSignal(kk,1:end-1), rxSignal2, snrdB);
end

% Estimating Time-invariant Channel Impulse Response (CIR)
if signalNames(kk)=="SEQN-Ga" || signalNames(kk)=="SEQN-Gb" 
CIRaux1(kk,:)=cconv(rxSignalAwgn1(kk,:), flip(conj(txSignal(kk,:))),lenTxSignal-1)/soundingNorm; 
CIR(kk,:)=CIRaux1(kk,1:nDelays);
else

CIRaux3(kk,:)=cconv(rxSignalAwgn2(kk,:), flip(conj(txSignal(kk,1:end-1))),lenTxSignal-1)/(soundingNorm-1); 
CIRaux3(kk,:)=circshift(CIRaux3(kk,:),1);
CIR(kk,:)=CIRaux3(kk,1:nDelays);

% if signalNames(kk)=="SEQN-PN" 
% [erroMinABS,index]=min(abs(CIR(kk,:)));
% [erroMaxABS,index2]=max(abs(CIR(kk,:)));
% erroMinI=real(CIR(kk,index));
% erroMinQ=imag(CIR(kk,index));
% erroMaxI=real(CIR(kk,index2));
% erroMaxQ=imag(CIR(kk,index2));
%CIR(kk,:)=CIR(kk,:)*(soundingNorm-1);
%CIR(kk,:)=CIR(kk,:)-real(CIR(kk,index)+1e-5) - imag(CIR(kk,index)+1e-5)*i;
%CIR(kk,:)=CIR(kk,:)-real((CIR(kk,index)))/lenTxSignal - imag((CIR(kk,index)))/lenTxSignal*i;
%CIR(kk,:)=CIR(kk,:)-erroMaxI/(lenTxSignal-1)/sqrt(2) - erroMaxQ/(lenTxSignal-1)*i/sqrt(2);
%CIR(kk,:)=CIR(kk,:)-erroMinABS/(lenTxSignal-1)/sqrt(2) - erroMinABS/(lenTxSignal-1)*i/sqrt(2);
% end

end

% Signaling Golay CIR
if signalNames(kk)=="SEQN-Ga" Ga=kk; end
if signalNames(kk)=="SEQN-Gb" Gb=kk; end

% Root Mean Square Error (RMSE) - CIR
rmsError(kk,(snrdB-snrMin)/snrStep+1)=...
                               sqrt((mean(abs((cirModel-CIR(kk,:)).^2))));
                           
% Estimating Golay CIR
if Ga~=0 && Gb~=0
CIR(nSignals+1,:)=(CIR(Ga,:)+CIR(Gb,:))/2;
%CIR(4,:)=(CIR(4,:)+CIR(5,:))/2;

% Root Mean Square Error (RMSE) - CIR
rmsError(nSignals+1,(snrdB-snrMin)/snrStep+1)=...
                        sqrt((mean(abs((cirModel-CIR(nSignals+1,:)).^2))));
% rmsError(4,(snrdB-snrMin)/snrStep+1)=...
%                         sqrt((mean(abs((cirModel-CIR(4,:)).^2))));
end   

end
end

if Ga~=0 && Gb~=0
signalNames=[signalNames; "SEQN-Gy"]; % Sequences Names
end

%% Plots
if savePlot=="off"
else
plotTimeInvAnalysis(savePlot, language, simulOutputName, ...
    signalNames, lenTxSignal, cirModel, CIR, rmsError, delayAxis, snrAxis)
end
