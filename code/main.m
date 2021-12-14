%##########################################################################
% INSTITUTION: Federal University of Rio Grande do Norte
% AUTHOR(S): J. Marcos Leal B. Filho
% TITLE: main
% LAST UPDATE: 2020-04-07 at 20:00h
%##########################################################################
% PURPOSE: Main function for Channel Sounding Simulation
%
% USAGE: main("simulOutputName", "inputParameters", "genCirModel", ...
%       "sounding", "genTxSignals", "processing", "savePlot", "choosePlot")
%
% INPUTS: "simulation" = Simulation output name;
%    "inputParameters" = Simulation input parameters; 
%        "genCirModel" = Generate / load CIR model ("on"/"off");
%           "sounding" = Turn on / off sounding simulation ("on"/"off");
%       "genTxSignals" = Generate / load Tx Signals ("on"/"off");
%         "processing" = Turn on / off processing simulation ("on"/"off");
%           "savePlot" = Save/Plot/Save&Plot results ("save"/"plot"/"all");
%         "choosePlot" = Choose type of Plot ("rmseBar"/"rep"/"len"/...
%                                            "samp"/"rmse"/"dlydop"/"all").
%
% OUTPUTS:  Sounding IDSF = Sounding Estimated CIR;
%              Mean Data  = Average RMSE Results for IDSF, Delay Spread ...
%                           and Doppler Spread.
%              
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Wideband Channel Sounding Simulation
function main(simulOutputName, inputParameters, genCirModel, sounding,...
            genTxSignals, processing, savePlot, choosePlot)

addpath(genpath('simulations')); % Simulation Codes
addpath(genpath('auxCodes')); % Auxiliar Codes

%% Load Input Parameters
eval(inputParameters); 

%% Define Time-variant Channel Impulse Response Model (CIR Model)
channelModel=generateCirModel(genCirModel, simulOutputName,repMontCarlo,...
              nSamples, fm, fs, ts, nMPC, delayAxis, delays, tapPower, ...
              dopFreqStep, gaussFilterMag, gaussFilterFreq);

%% Simulate Channel Sounding 
if sounding=="on"
channelSounding(genTxSignals, simulOutputName, signalNames, nSamples, ...
              nDelays, repMontCarlo, lenTxSignals, channelModel, ...
              snrMin, snrStep, snrMax);
end

%% Sounding Processing
if processing=="on"
soundingProcessing(simulOutputName, proSignalNames, nSamples, ...
                   repMontCarlo, lenTxSignals, channelModel);
end

%% Plots
if savePlot=="all" || savePlot=="save" || savePlot=="plot"
plotGraphics(savePlot,choosePlot,language, nSamples(1),repMontCarlo,...
             lenTxSignals, plotSignalLen, plotSignalName, simulOutputName)
end

fprintf(' \n #Simulation Completed! \n')
end
