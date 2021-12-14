function makeFoldersAux(simulOutputName)
if ~exist(strcat("../../../results/",simulOutputName,"/figures"), 'dir')
mkdir(char(strcat("../../../results/",simulOutputName,"/figures/functionsAnalysis/specialFunctions/PDP")))
mkdir(char(strcat("../../../results/",simulOutputName,"/figures/functionsAnalysis/specialFunctions/DopPDS")))
mkdir(char(strcat("../../../results/",simulOutputName,"/figures/functionsAnalysis/systemFunctions")))
mkdir(char(strcat("../../../results/",simulOutputName,"/figures/functionsAnalysis/correlationFunctions")))
mkdir(char(strcat("../../../results/",simulOutputName,"/figures/functionsAnalysis/dlyDopRMSE")))
mkdir(char(strcat("../../../results/",simulOutputName,"/figures/signalAnalysis/sequences")))
mkdir(char(strcat("../../../results/",simulOutputName,"/figures/signalAnalysis/autocorrelation")))
mkdir(char(strcat("../../../results/",simulOutputName,"/figures/timeInvSounding")))
end
end