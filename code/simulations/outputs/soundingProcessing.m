function soundingProcessing(simulOutputName, proSignalNames, nSamples, ...
    repMontCarlo, lenTxSignals, channelModel)
fprintf('\n #Sounding Processing...')

for ss=1:length(lenTxSignals)
meanData=[]; dlyDop=[]; rmsError=[];

nSignals=length(proSignalNames);

for kk=1:nSignals % Varying Different Signals
% Load Estimated IDSF Data
inputName=strcat("IDSF_",proSignalNames(kk),"_",num2str(lenTxSignals(ss)),...
        "len_",num2str(nSamples(1)),"samp_",num2str(repMontCarlo),"rep");
load(strcat("../results/", simulOutputName,"/soundingIDSF/",inputName,".mat"));

% Read Parameters
nSamps=length(nSamples); % Quantity of Time Samples
downSamp=round(nSamples(1)./nSamples); % Downsample rate
snrMin = signalIDSF(1).snrMin;
snrMax = signalIDSF(1).snrMax;
snrStep = signalIDSF(1).snrStep;
nMPC=channelModel(1).nMPC;
fs=channelModel(1).fs; 
fm=channelModel(1).fm;

% Calculate Condensed Parameters and RMSE data
for montC=1:repMontCarlo % Monte Carlo Repetitions
for snrdB =snrMin:snrStep:snrMax
for iSamp=1:nSamps  % Different Quantity of Time Samples
IDSF=[];  
IDSF=downsample(signalIDSF(montC).monteCarlo((snrdB-snrMin)/snrStep+1)...
     .snrs,downSamp(iSamp));  

% Calculate Condensed Parameters (Average rmsDelay / Average rmsDoppler)
[rmsDelay,rmsDoppler]=calculateDelayDoppler(IDSF, ...
    channelModel(1).delayAxis, nMPC, fm, fs(iSamp), nSamples(iSamp));
                  
% Store Condensed Parameters
dlyDop(iSamp).rmsDelay(montC,(snrdB-snrMin)/snrStep+1)=rmsDelay; 
                                                                  
dlyDop(iSamp).rmsDoppler(montC,(snrdB-snrMin)/snrStep+1)=rmsDoppler; 
                                                                
                  
% Calculate Root Mean Square Error (RMSE) - Delay / Doppler
rmsError(iSamp).rmsDlyError(montC,(snrdB-snrMin)/signalIDSF(1).snrStep+ ... 
        1)=sqrt(mean(abs((channelModel(montC).rmsDelay-rmsDelay).^2)));
rmsError(iSamp).rmsDopError(montC,(snrdB-snrMin)/signalIDSF(1).snrStep+ ... 
        1)=sqrt(mean(abs((channelModel(montC).rmsDoppler-rmsDoppler).^2)));

if iSamp==1
% Calculate Root Mean Square Error (RMSE) - IDSF
rmsError(iSamp).rmseIDSF(montC,(snrdB-snrMin)/signalIDSF(1).snrStep+1)=...
    sqrt(mean(mean(abs((channelModel(montC).cirModelMontC-IDSF).^2))));
end
end
end
end

% Calculate Mean of Average RMS Delay/Doppler over Monte Carlo Repetitions
meanData(kk).dlyDop=...
    calculateMeanDelayDoppler(dlyDop, nSamps,repMontCarlo);

% Calculate Mean of RMSE (for Delay/Doppler) over Monte Carlo Repetitions 
meanData(kk).meanRMSE=calculateMeanError(rmsError, nSamps,repMontCarlo);

% Calculate Mean of RMSE (for IDSF) over Monte Carlo Repetitions 
meanData(kk).meanRmseIDSF=calculateMeanErrorIDSF(rmsError, repMontCarlo);

% Store extra information to meanData Structure
meanData(kk).signalName=proSignalNames(kk); % Add signal label
meanData(kk).rmsError=rmsError;
for iSamp=1:nSamps % Store the quantities of Time Samples 
meanData(kk).dlyDop(iSamp).nSamples=signalIDSF(1).nSamples(iSamp);
meanData(kk).meanRMSE(iSamp).nSamples=signalIDSF(1).nSamples(iSamp);
end
end
% Store SNR values
meanData(1).snrValues=... 
    [signalIDSF(1).snrMin:signalIDSF(1).snrStep:signalIDSF(1).snrMax];

% Save Mean RMSE data
for n=1:nSignals
outputName=char(strcat("meanData_",num2str(lenTxSignals(ss)),"len_",...
    num2str(nSamples(1)),"samp_",num2str(repMontCarlo),"rep"));
save(strcat("../results/", simulOutputName,"/outputData/",...
    outputName,".mat"),'meanData');
end
end
fprintf(' Completed! \n')
end