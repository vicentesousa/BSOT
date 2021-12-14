%##########################################################################
% INSTITUTION: Federal University of Rio Grande do Norte
% AUTHOR(S): J. Marcos Leal B. Filho
% TITLE: campaign
% LAST UPDATE: 2020-03-10 at 20:00h
%##########################################################################
% PURPOSE: Campaign for Simulate a wideband channel sounding using
% different sequences as sounding signal.
%
% USAGE: Run main Function 
%
% INPUTS: inputParameters = Simulation Parameters.
%
% OUTPUTS:  Sounding IDSF = Sounding Estimated Channel Impulse Response;
%               Mean Data = Average RMSE Results for IDSF, Delay Spread ...
%                           and Doppler Spread.
%
% main USAGE: main("simulOutputName", "inputParameters", "genCirModel", ...
%       "sounding", "genTxSignals", "processing", "savePlot", "choosePlot")
%
% main INPUTS: "simulation" = Simulation output name;
%    "inputParameters" = Simulation input parameters; 
%        "genCirModel" = Generate / load CIR model ("on"/"off");
%           "sounding" = Turn on / off sounding simulation ("on"/"off");
%       "genTxSignals" = Generate / load Tx Signals ("on"/"off");
%         "processing" = Turn on / off processing simulation ("on"/"off");
%           "savePlot" = Save/Plot/Save&Plot results ("save"/"plot"/"all");
%         "choosePlot" = Choose type of Plot ("rmseBar"/"rep"/"len"/...
%                                            "samp"/"rmse"/"dlydop"/"all");
%              
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
clear all; clc; close all;   

%% Simulation with all Sequences - 500 Samples - 100 repetitions
% main("simulation0", "inputParameters0", "off", "off", "off", "off",...
%      "plot", "rmseBar"); 

%% Simulation with Golay Sequence - 500 Samples - 4 repetitions
% main("simulation1", "inputParameters1", "off", "on", "on", "on",...
%      "plot", "all"); 

%% Simulation with Golay Sequence - 500 Samples - 10 repetitions
main("simulation1", "inputParameters1", "on", "on", "on", "on",...
     "plot", "all"); 
 
%% Simulation with PN Sequence - 500 Samples - 4 repetitions
% main("simulation3", "inputParameters3", "off", "off", "off", "off",...
%      "plot", "len");  

