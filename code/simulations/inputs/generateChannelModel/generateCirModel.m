%##########################################################################
% INSTITUTION: Federal University of Rio Grande do Norte
% AUTHOR(S): J. Marcos Leal B. Filho
% TITLE: generateCirModel
% LAST UPDATE: 2020-04-07 at 20:00h
%##########################################################################
% PURPOSE: Generate Channel Impulse Response Model using COST 207 Model  
%          through Taped Delay Line with Bad Urban parameters. 
%
% USAGE: [channelModel]=generateCirModel(genCirModel, simulOutputName, ...
%           repMontCarlo, nSamples, fm, fs, ts, nMPC, delayAxis, delays,...
%           tapPower, dopFreqStep, gaussFilterMag, gaussFilterFreq)
%
% INPUTS: "genCirModel" = Generate / load CIR model ("on"/"off");
%     "simulOutputName" = Simulation output name; 
%        "repMontCarlo" = Number of Monte Carlo Repetitions;
%              nSamples = Number of route samples;
%                    fm = Maximum Doppler Shift (Hz);
%                    fs = Vector of Different Sample Frequencies (Hz);       
%                    ts = Sample time (s);
%                  nMPC = Number of Multipath Components (MPC);
%             delayAxis = Delay axis;
%                delays = Delays of each received MPC (us);
%              tapPower = Power of each received MPC (dB);
%           dopFreqStep = Frequency step in defining Doppler filters;
%        gaussFilterMag = Magnitudes for Gaussian Filter (dB);
%       gaussFilterFreq = Frequencies for Gaussian Filter (Hz).
%
% OUTPUTS: channelModel = Channel impulse response model.
%              
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function channelModel=generateCirModel(genCirModel, simulOutputName, ...
            repMontCarlo, nSamples, fm, fs, ts, nMPC, delayAxis, delays,...
            tapPower, dopFreqStep, gaussFilterMag, gaussFilterFreq)
fprintf(' Creating/Loading Channel Model...')
if genCirModel=="on"
    
for montC=1:repMontCarlo
% Generate CIR Model
channelModel(montC).cirModelMontC=channelTDL(fm, ts, delayAxis, ...
 nSamples(1),dopFreqStep,delays,tapPower,gaussFilterMag,gaussFilterFreq);  

% Calculate Channel Model Condensed Parameters
[channelModel(montC).rmsDelay,channelModel(montC).rmsDoppler]=...
    calculateDelayDoppler(channelModel(montC).cirModelMontC, ...
    delayAxis, nMPC, fm, fs(1), nSamples(1));
end
% Store Simulation parameters
channelModel(1).delayAxis=delayAxis;   
channelModel(1).fs=fs; channelModel(1).fm=fm; 
channelModel(1).nMPC=nMPC;

% Save CIR Model
makeFolders(simulOutputName) % Creating simulation folders
outputName=strcat("CIR_Model_",num2str(nSamples(1)),"samp_",...
    num2str(repMontCarlo),"rep");
save(strcat("../results/",simulOutputName,"/inputData/cirModel/",...
    outputName,".mat"),'channelModel');
else
% Load CIR Model 
inputName=strcat("CIR_Model_",num2str(nSamples(1)),"samp_",...
    num2str(repMontCarlo),"rep");
load(strcat("../results/",simulOutputName,"/inputData/cirModel/",...
    inputName,".mat"));
end
fprintf(' Completed! \n')
end