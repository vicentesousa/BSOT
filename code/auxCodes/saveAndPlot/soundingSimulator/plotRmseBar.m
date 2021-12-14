function plotRmseBar(savePlot, language, modelNsamples, repMontCarlo, lenTxSignal, plotSignalName, simulOutputName)
%% Load RMS Error
inputName=strcat("meanData_",num2str(lenTxSignal),"len_",num2str(modelNsamples),"samp_",num2str(repMontCarlo),"rep");
load(strcat("../results/", simulOutputName,"/outputData/",inputName,".mat"));
nSamples=meanData(1).meanRMSE(1).nSamples;
nSignals=length(meanData);

for i=1:nSignals
signalNames(i)=meanData(i).signalName;
if plotSignalName == meanData(i).signalName
    iSignal=i;
end
end
sNames=legendNames(signalNames, nSignals, language);


sColorDly=[0.5 0 0.1;    0.3 0.5 0;     0.7 0.6 0;  0 0.3 0.5; ...
          0.8 0.4 0;    0.6, 0, 0.6;   0 0.4 0.5;  0.5 0.4 0.7];
      
sColorDop=[0.8 0.2 0.2;   0 0.5 0.4;     0.9 0.7 0.3;   0 0.3 0.8; ...
          0.9 0.5 0.1;   0.8, 0, 0.8;   0 0.5 0.7;     0.4 0.5 0.9];

sColorIDSF=[0.7 0.1 0.1;  0 0.3 0.2;     0.9 0.7 0.3;  0 0.4 0.8; ...
           0.9 0.4 0.1;  0.6, 0, 0.5;   0 0.45 0.6;     0.5 0.5 0.8];    

colorDly=sColorDly(iSignal,:);
colorDop=sColorDop(iSignal,:);
colorIDSF=sColorIDSF(iSignal,:);
      
line=["*-", "-.", ":", "--"];

meanDlyEr=meanData(iSignal).meanRMSE(1).meanErrorDly(3,:);
meanDopEr=meanData(iSignal).meanRMSE(1).meanErrorDop(3,:);
meanIDSFEr=meanData(iSignal).meanRmseIDSF(1).meanErrorIDSF(3,:);

stdDlyEr=std(meanData(iSignal).rmsError(1).rmsDlyError);
stdDopEr=std(meanData(iSignal).rmsError(1).rmsDopError);
stdIDSFEr=std(meanData(iSignal).rmsError(1).rmseIDSF);     

[idsfDlyCI] = calculateCI(meanDlyEr, stdDlyEr, repMontCarlo);
[idsfDopCI] = calculateCI(meanDopEr, stdDopEr, repMontCarlo);
[idsfCI] = calculateCI(meanIDSFEr, stdIDSFEr, repMontCarlo);


%% Plot RMSE x Eb/No e Pe Teórica - for RMS Delay/Doppler Spread
if savePlot=="plot" || savePlot=="all" ploting="on"; 
else ploting="off"; end
%% Delay Spread - Different Signals
fig(1).results=figure('visible',ploting);

errorbar(meanData(1).snrValues, meanData(iSignal).meanRMSE(1).meanErrorDly(3,:),idsfDlyCI, line(1),'Color',colorDly(1,:),'linewidth',2)
legend (sNames(iSignal));
xlabel('SNR (dB)')
ylabel('RSME')
if language=="por"
title(strcat("RMSE da Média dos Espalhamentos do Atraso RMS Médios - ", num2str(nSamples),...
    " Amostras / ", num2str(repMontCarlo)," Repetições"))
else
title(strcat("RMSE of Mean Average RMS Delay Spread - ", num2str(nSamples),...
    " Samples / ", num2str(repMontCarlo)," Repetitions"))
end
grid on
hold off;

%% Doppler Spread - Different Signals
fig(2).results=figure('visible',ploting);

errorbar(meanData(1).snrValues, meanData(iSignal).meanRMSE(1).meanErrorDop(3,:),idsfDopCI, line(1),'Color',colorDop(1,:),'linewidth',2)
legend (sNames(iSignal));
xlabel('SNR (dB)')
ylabel('RSME')
if language=="por"
title(strcat("RMSE da Média dos Espalhamentos Doppler RMS Médios - ", num2str(nSamples),...
    " Amostras / ", num2str(repMontCarlo)," Repetições"))
else
title(strcat("RMSE of Mean Average RMS Doppler Spread - ", num2str(nSamples),...
    " Samples / ", num2str(repMontCarlo)," Repetitions"))
end
grid on
hold off;

%% IDSF - Different Signals
fig(3).results=figure('visible',ploting);
hAy=axes;
hAy.YScale='log';
%xlim([minDecade maxDecade])
hold all
errorbar(meanData(1).snrValues, meanData(iSignal).meanRmseIDSF(1).meanErrorIDSF(3,:),idsfCI, line(1),'Color',colorIDSF(1,:),'linewidth',2)
legend (sNames(iSignal));
xlabel('SNR (dB)')
ylabel('RSME')
if language=="por"
title(strcat("RMSE da Média das IDSF - ", num2str(nSamples),...
    " Amostras / ", num2str(repMontCarlo)," Repetições"))
else
title(strcat("RMSE of Mean IDSF - ", num2str(nSamples),...
    " Samples / ", num2str(repMontCarlo)," Repetitions"))
end
grid on
hold off;

%% Save Figures
names=["Dly","Dop","IDSF"];
if savePlot == "save" || savePlot=="all"        
    for i=1:3
        print(fig(i).results, strcat("../results/",simulOutputName,"/figures/errorBar/barRMSE_",names(i),...
        "_",meanData(iSignal).signalName,"_",num2str(lenTxSignal),...
        "len_", num2str(nSamples),"samp_", num2str(repMontCarlo),"rep"),...
        '-dpng');
        
        saveas(fig(i).results, strcat("../results/",simulOutputName,"/figures/errorBar/barRMSE_",names(i),...
        "_",meanData(iSignal).signalName,"_",num2str(lenTxSignal),...
        "len_", num2str(nSamples),"samp_", num2str(repMontCarlo),"rep",...
        ".fig"));    
    end
    if savePlot == "save" close; close; close; end
end
end
