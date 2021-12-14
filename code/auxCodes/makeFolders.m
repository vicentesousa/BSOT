%##########################################################################
% INSTITUTION: Federal University of Rio Grande do Norte
% AUTHOR(S): J. Marcos Leal B. Filho
% TITLE: makeFolders
% LAST UPDATE: 2020-04-07 at 20:00h
%##########################################################################
% PURPOSE: Create sounding simulation folders.
%
% USAGE: makeFolders(simulOutputName)
%
% INPUTS: "simulOutputName" = Simulation output name.
%
% OUTPUTS: sounding simulation folders.
%              
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function makeFolders(simulOutputName)
if ~exist(strcat("../results/", simulOutputName,"/inputData"), 'dir') 
mkdir(char(strcat("../results/",simulOutputName,"/inputData/cirModel")));
mkdir(char(strcat("../results/",simulOutputName,"/inputData/txSignals")));  
end
if ~exist(strcat("../results/", simulOutputName,"/outputData"), 'dir') 
mkdir(char(strcat("../results/", simulOutputName,"/outputData")));
end
if ~exist(strcat("../results/",simulOutputName,"/soundingIDSF"), 'dir') 
mkdir(char(strcat("../results/",simulOutputName,"/soundingIDSF")));
end
if ~exist(strcat("../results/",simulOutputName,"/figures"), 'dir')
mkdir(char(strcat("../results/",simulOutputName,"/figures/errorBar")));
mkdir(char(strcat("../results/",simulOutputName,"/figures/difSamples")));
mkdir(char(strcat("../results/",simulOutputName,"/figures/difRepet")));
mkdir(char(strcat("../results/",simulOutputName,"/figures/difLength")));
mkdir(char(strcat("../results/",simulOutputName,"/figures/dlyDop")))
mkdir(char(strcat("../results/",simulOutputName,"/figures/iDSF")))
end
end