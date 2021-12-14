function plotRMSEdSamp(savePlot, language, modelNsamples, repMontCarlo, lenTxSignal, plotSignalName, simulOutputName)
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
nSamp=length(meanData(iSignal).meanRMSE);


sColorDly=[0.5 0 0.1;    0.3 0.5 0;     0.7 0.6 0;  0 0.3 0.6; ...
          0.8 0.4 0;    0.6, 0, 0.6;   0 0.4 0.5;  0.5 0.4 0.7];
      
sColorDop=[0.8 0.2 0.2;   0 0.5 0.4;     0.9 0.7 0.3;   0 0.3 0.8; ...
          0.9 0.5 0.1;   0.8, 0, 0.8;   0 0.5 0.7;     0.4 0.5 0.9];     

colorDly=[0.1, 0.4, 0.6; 0.4, 0.3, 0.7; 0.4, 0.6, 0.1];
colorDop=[0.1, 0.4, 0.8; 0.4, 0.5, 0.9; 0.6, 0.9, 0.3];

colorDly=[sColorDly(iSignal,:); colorDly];
colorDop=[sColorDop(iSignal,:); colorDop];

line=["*-", "-.", ":", "--"];

% colorDly12=[0 0 0.7]; colorDly22=[0 0.5 0.3];
% colorDop12=[0.2, 0.0, 0.5]; colorDop22=[0 0.5 0.3];
 
if savePlot=="plot" || savePlot=="all" ploting="on"; 
else ploting="off"; end
%% Plot RMSE x Eb/No e Pe Teórica - for RMS Delay/Doppler Spread
%% Delay Spread - Different Number of Samples
fig(1).results=figure('visible',ploting);
for i=1:nSamp
semilogy(meanData(1).snrValues, meanData(iSignal).meanRMSE(i).meanErrorDly(3,:),line(i),'Color',colorDly(i,:),'linewidth',2)
hold on 
    if language=="por"
        legendInput(i)=strcat(sNames(iSignal), " - ", num2str(meanData(iSignal).meanRMSE(i).nSamples)," Amostras");  
    else
        legendInput(i)=strcat(sNames(iSignal), " - ", num2str(meanData(iSignal).meanRMSE(i).nSamples)," Samples");  
    end
end    
legend (legendInput);
xlabel('SNR (dB)')
ylabel('RMSE')
if language=="por"
title(strcat("RMSE da Média dos Espalhamentos do Atraso RMS Médios - ",...
    num2str(repMontCarlo)," Repetitions"))
else
title(strcat("RMSE of Mean Average RMS Delay Spread - ",...
    num2str(repMontCarlo)," Repetições"))
end
grid on
hold off;

%% Doppler Spread - Different Number of Samples
fig(2).results=figure('visible',ploting);
for i=1:nSamp
semilogy(meanData(1).snrValues, meanData(iSignal).meanRMSE(i).meanErrorDop(3,:),line(i),'Color',colorDop(i,:),'linewidth',2)
hold on    
    if language=="por"
        legendInput(i)=strcat(sNames(iSignal), " - ", num2str(meanData(iSignal).meanRMSE(i).nSamples)," Amostras");  
    else
        legendInput(i)=strcat(sNames(iSignal), " - ", num2str(meanData(iSignal).meanRMSE(i).nSamples)," Samples");  
    end
end
legend (legendInput);
xlabel('SNR (dB)')
ylabel('RMSE')
if language=="por"
title(strcat("RMSE da Média dos Espalhamentos Doppler RMS Médios - ",...
    num2str(repMontCarlo)," Repetições"))
else
title(strcat("RMSE of Mean Average RMS Doppler Spread - ",...
    num2str(repMontCarlo)," Repetitions"))
end
grid on
hold off;

%% Save Figures
names=["Dly","Dop"];
if savePlot == "save" || savePlot=="all"        
    for i=1:2
        print(fig(i).results, strcat("../results/",simulOutputName,"/figures/difSamples/RMSE_",names(i),...
        "_dSAMP_",meanData(iSignal).signalName,"_",num2str(lenTxSignal(1)),...
        "len_", num2str(nSamples),"samp_", num2str(repMontCarlo),"rep"),...
        '-dpng');
        
        saveas(fig(i).results, strcat("../results/",simulOutputName,"/figures/difSamples/RMSE_",names(i),...
        "_dSAMP_",meanData(iSignal).signalName,"_",num2str(lenTxSignal(1)),...
        "len_", num2str(nSamples),"samp_", num2str(repMontCarlo),"rep",...
        ".fig"));
    end
    if savePlot == "save" close; close; end
end
end