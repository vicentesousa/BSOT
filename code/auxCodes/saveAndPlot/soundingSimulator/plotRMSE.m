function plotRMSE(savePlot, language, modelNsamples, repMontCarlo, lenTxSignal, simulOutputName)
%% Load RMS Error
inputName=strcat("meanData_",num2str(lenTxSignal),"len_",num2str(modelNsamples),"samp_",num2str(repMontCarlo),"rep");
load(strcat("../results/", simulOutputName,"/outputData/",inputName,".mat"));
nSamples=meanData(1).meanRMSE(1).nSamples;
nSignals=length(meanData);

for ii=1:nSignals
signalNames(ii)=meanData(ii).signalName;
end
sNames=legendNames(signalNames, nSignals, language);


colorDly=[0.5 0 0.1;    0.3 0.5 0;     0.7 0.6 0;  0 0.3 0.5; ...
          0.8 0.4 0;    0.6, 0, 0.6;   0 0.4 0.5;  0.5 0.4 0.7];
      
colorDop=[0.8 0.2 0.2;   0 0.5 0.4;     0.9 0.7 0.3;   0 0.3 0.8; ...
          0.9 0.5 0.1;   0.8, 0, 0.8;   0 0.5 0.7;     0.4 0.5 0.9];

colorIDSF=[0.7 0.1 0.1;  0 0.3 0.2;     0.9 0.7 0.3;  0 0.4 0.8; ...
           0.9 0.4 0.1;  0.6, 0, 0.5;   0 0.45 0.6;     0.5 0.5 0.8];
      
line=["o-", "x-.", "+-.", "-.", "--", "*-", "-", "-"];


%% Plot RMSE x Eb/No e Pe Teórica - for RMS Delay/Doppler Spread
if savePlot=="plot" || savePlot=="all" ploting="on"; 
else ploting="off"; end
%% Delay Spread - Different Signals
fig(1).results=figure('visible',ploting);

for i=1:nSignals
semilogy(meanData(1).snrValues, meanData(i).meanRMSE(1).meanErrorDly(3,:),line(i),'Color',colorDly(i,:),'linewidth',2)
hold on
legendInput(i)=sNames(i);
end
legend (legendInput);
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
for i=1:nSignals
semilogy(meanData(1).snrValues, meanData(i).meanRMSE(1).meanErrorDop(3,:),line(i),'Color',colorDop(i,:),'linewidth',2)
hold on
legendInput(i)=sNames(i);
end
legend (legendInput);
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

for i=1:nSignals
semilogy(meanData(1).snrValues, meanData(i).meanRmseIDSF(1).meanErrorIDSF(3,:),line(i),'Color',colorIDSF(i,:),'linewidth',2)
hold on
legendInput(i)=sNames(i);
end
legend (legendInput);
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
names=["Dly","Dop","IDSF"]; folderName=["dlyDop","dlyDop","iDSF"];
if savePlot == "save" || savePlot=="all"        
    for i=1:3
        print(fig(i).results, strcat("../results/",simulOutputName,"/figures/",folderName(i),"/RMSE_",...
        names(i),"_",num2str(lenTxSignal(1)),"len_", num2str(nSamples),...
        "samp_", num2str(repMontCarlo),"rep"),'-dpng');

        saveas(fig(i).results, strcat("../results/",simulOutputName,"/figures/",folderName(i),"/RMSE_",...
        names(i),"_",num2str(lenTxSignal(1)),"len_", num2str(nSamples),...
        "samp_", num2str(repMontCarlo),"rep",".fig"));
    end
    if savePlot == "save" close; close; close; end
end
end
