% Simulator - Delay / Doppler
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

%% Choose Input Parameters
snrMin=-20; snrMax=40; snrStep=5;   % SNR valors (dB)
snrs=snrMin:snrStep:snrMax;         % SNR vector (dB) 
downSamp=round(modelNsamples./nSamples); % Downsample rate
iSamp=1; % Choose from 1 to 4 for setting the sample rate / nº of samples
lenTx=1; % Choose from 1 to 4 for setting signal length (1028/512/256/128)   
iName=1; % Set for choosing Input Sounding Signal Name

%% Input Parameters for Loading CIR Model 
signalNames=["SEQN-RD"; "SEQN-GD"; "SEQN-KA"; "SEQN-PN"; "SEQN-ZC"; ...
             "SEQN-Ga"; "SEQN-Gb"; "SEQN-Gy"];
simulInputName="simulation1"; % set for choosing input simulation data
repMontCarlo=4; % Monte Carlo Repetitions

%% Load CIR Model 
inputName=strcat("CIR_Model_",num2str(modelNsamples),"samp_",...
    num2str(repMontCarlo),"rep");
load(strcat("../../../results/",simulInputName,"/inputData/cirModel/",...
    inputName,".mat"));
% Calculate CIR Model Condensed Parameters 
[rmsDelayModel,rmsDopplerModel,modelPDP,modelDopPDS]=...
    calculateDelayDoppler(channelModel(1).cirModelMontC, delayAxis, ...
    nMPC, fm, fs(1), modelNsamples);

%% Load Sounding Estimated CIR 
inputName=strcat("IDSF_",signalNames(iName),"_",num2str(lenTxSignals(...
lenTx)),"len_",num2str(modelNsamples),"samp_",num2str(repMontCarlo),"rep");
load(strcat("../../../results/", simulInputName,"/soundingIDSF/",...
    inputName,".mat"));

%% Sounding Processing
ii=0;  TCF=[]; FCF=[];
rmsDelay=zeros(1,length(snrs)); rmsDoppler=zeros(1,length(snrs));
errorDly=zeros(1,length(snrs)); errorDop=zeros(1,length(snrs));
for snrDB=snrs
ii=ii+1;
% Downsampling IDSF depending on the sample rate
IDSF=downsample(signalIDSF(1).monteCarlo((snrDB-snrMin)/snrStep+1).snrs,...
    downSamp(iSamp));

% Calculate Condensed Parameters Signals
[rmsDelay(ii),rmsDoppler(ii), avPDP, avDopPDS, thresholdDly, ...
    thresholdDop,sigmaDly,sigmaDop]=calculateDelayDoppler(IDSF,...
    delayAxis, nMPC, fm, fs(iSamp), nSamples(iSamp));

% Calculate Delay / Doppler RMSE
errorDly(ii)=sqrt(mean(abs(rmsDelayModel-rmsDelay(ii)).^2));
errorDop(ii)=sqrt(mean(abs(rmsDopplerModel-rmsDoppler(ii)).^2));

% Plot Average PDP and Average Doppler PDS
plotSpecialFunc(savePlot,language, simulOutputName, signalNames(iName),...
    lenTxSignals(lenTx), modelPDP, modelDopPDS, avPDP, avDopPDS, ...
    TCF, FCF, thresholdDly, thresholdDop, sigmaDly, sigmaDop,...
    modelNsamples, nSamples(iSamp), delayAxis, fs(1), fm, snrDB, "off")

disp(strcat("SNR: ",num2str(snrDB)," - RMS Delay: ",...
    num2str(rmsDelay(ii)), " us"));
disp(strcat("SNR: ",num2str(snrDB)," - RMS Doppler: ",...
    num2str(rmsDoppler(ii)), " Hz"));
end
disp(strcat("RMS Delay Model: ",num2str(rmsDelayModel), " us"));
disp(strcat("RMS Doppler Model: ",num2str(rmsDopplerModel), " Hz"));


%% Save / Plot
snrDB=-10; % Set for plotting graphics with a specifc SNR

% Calculate DDSF / SF / Average PDP / Average 
IDSF=downsample(signalIDSF(1).monteCarlo((snrDB-snrMin)/snrStep+1).snrs,...
    downSamp(iSamp));
[PDP, DopPDS, DDSF, SF, TCF, FCF]=calculateFunctions(IDSF,nDelays,...
                                      nSamples(iSamp));  

% Plot System Function
plotSystemFunc(savePlot, language, simulOutputName, ...
    signalNames(iName), lenTxSignals(lenTx), IDSF, DDSF, ...
    channelModel(1).cirModelMontC, delayAxis, nSamples(iSamp), ...
    modelNsamples, fs(iSamp), fm, ts, snrDB)

% Plot Correlation Function
plotCorrelationFunc(savePlot, language, simulOutputName, ...
    signalNames(iName), lenTxSignals(lenTx), SF, delayAxis, ...
    nSamples(iSamp), fs(iSamp), fm, snrDB)

% Plot Special Correlation Function
plotSpecialFunc(savePlot,language, simulOutputName, signalNames(iName),...
    lenTxSignals(lenTx), modelPDP, modelDopPDS, PDP, DopPDS, ...
    TCF, FCF, thresholdDly, thresholdDop, sigmaDly, sigmaDop,...
    modelNsamples, nSamples(iSamp), delayAxis, fs(1), fm, snrDB, "on")

% Plot Condensed Parameters (Delay / Doppler)
plotDlyDopRMSE(savePlot, language, simulOutputName, ...
    signalNames(iName), lenTxSignals(lenTx), errorDly, errorDop, ...
    rmsDelay, rmsDoppler, rmsDelayModel, rmsDopplerModel, ...
    nSamples(iSamp), snrs)
