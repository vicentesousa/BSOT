function plotRMSEdRep(savePlot, language, modelNsamples, repMontCarlo, lenTxSignal, plotSignalName, simulOutputName)
%% Load RMS Error
inputName=strcat("meanData_",num2str(lenTxSignal),"len_",num2str(modelNsamples),"samp_",num2str(repMontCarlo),"rep");
load(strcat("../results/", simulOutputName,"/outputData/",inputName,".mat"));

nSamples=meanData(1).meanRMSE(1).nSamples;
rep=[ceil(repMontCarlo/10) ceil(repMontCarlo/2) repMontCarlo];
nRep=length(rep);
nSignals=length(meanData);

for i=1:nSignals
signalNames(i)=meanData(i).signalName;
if plotSignalName == meanData(i).signalName
    iSignal=i;
end
end
sNames=legendNames(signalNames, nSignals, language);

sColorDly=[0.5 0 0.1;    0.3 0.5 0;     0.7 0.6 0;  0 0.3 0.6; ...
          0.8 0.4 0;    0.6, 0, 0.6;   0 0.4 0.5;  0.5 0.4 0.7];
      
sColorDop=[0.8 0.2 0.2;   0 0.5 0.4;     0.9 0.7 0.3;   0 0.3 0.8; ...
          0.9 0.5 0.1;   0.8, 0, 0.8;   0 0.5 0.7;     0.4 0.5 0.9];

colorDly=[0 0.6 0.5; 0 0 0.7];
colorDop=[0.7, 0.6, 1; 0, 0.2, 0.7];

colorDly=[colorDly; sColorDly(iSignal,:)];
colorDop=[colorDop; sColorDop(iSignal,:)];

line=[ ":", "--", "*-"]; 

if savePlot=="plot" || savePlot=="all" ploting="on"; 
else ploting="off"; end
%% Plot RMSE x Eb/No e Pe Teórica - for RMS Delay/Doppler Spread
%% Delay Spread - Different Monte Carlo Repetitions
fig(1).results=figure('visible',ploting);
for i=nRep:-1:1
semilogy(meanData(1).snrValues, meanData(iSignal).meanRMSE(1).meanErrorDly(i,:),line(i),'Color',colorDly(i,:),'linewidth',2)
hold on   
    if language=="por"
        legendInput(nRep-i+1)=strcat(sNames(iSignal), " - ", num2str(rep(i))," Repetições");
    else
        legendInput(nRep-i+1)=strcat(sNames(iSignal), " - ", num2str(rep(i))," Repetitions");
    end
end
legend (legendInput);
xlabel('SNR (dB)')
ylabel('RSME')
if language=="por"
title(strcat("RMSE da Média dos Espalhamentos do Atraso RMS Médios - ", ...
    num2str(nSamples)," Amostras"))
else
title(strcat("RMSE of Mean Average RMS Delay Spread - ", ...
    num2str(nSamples)," Samples"))
end
grid on
hold off;

%% Doppler Spread - Different Monte Carlo Repetitions

fig(2).results=figure('visible',ploting);
for i=nRep:-1:1
semilogy(meanData(1).snrValues, meanData(iSignal).meanRMSE(1).meanErrorDop(i,:),line(i),'Color',colorDop(i,:),'linewidth',2)
hold on   
    if language=="por"
        legendInput(nRep-i+1)=strcat(sNames(iSignal), " - ", num2str(rep(i))," Repetições");
    else
        legendInput(nRep-i+1)=strcat(sNames(iSignal), " - ", num2str(rep(i))," Repetitions");
    end
end   
legend (legendInput);
xlabel('SNR (dB)')
ylabel('RSME')
if language=="por"
title(strcat("RMSE da Média dos Espalhamentos Doppler RMS Médios - ", ...
    num2str(nSamples)," Amostras"))
else
title(strcat("RMSE of Mean Average RMS Doppler Spread - ", ...
    num2str(nSamples)," Samples"))
end
grid on
hold off;

%% Save Figures
names=["Dly","Dop"];
if savePlot == "save" || savePlot=="all"        
    for i=1:2
        print(fig(i).results, strcat("../results/",simulOutputName,"/figures/difRepet/RMSE_",names(i),...
        "_dREP_",meanData(iSignal).signalName,"_",num2str(lenTxSignal(1)),...
        "len_", num2str(nSamples),"samp_", num2str(repMontCarlo),"rep"),...
        '-dpng');
        
        saveas(fig(i).results, strcat("../results/",simulOutputName,"/figures/difRepet/RMSE_",names(i),...
        "_dREP_",meanData(iSignal).signalName,"_",num2str(lenTxSignal(1)),...
        "len_", num2str(nSamples),"samp_", num2str(repMontCarlo),"rep",...
        ".fig"));    
    end
    if savePlot == "save" close; close; end
end
end
