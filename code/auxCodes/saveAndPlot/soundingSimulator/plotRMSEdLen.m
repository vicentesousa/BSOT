function plotRMSEdLen(savePlot, language, modelNsamples, repMontCarlo, lenTxSignal, plotSignalName, simulOutputName)
%% Load RMS Error

for ii=1:length(lenTxSignal)
inputName=strcat("meanData_",num2str(lenTxSignal(ii)),"len_",num2str(modelNsamples),"samp_",num2str(repMontCarlo),"rep");
load(strcat("../results/", simulOutputName,"/outputData/",inputName,".mat"));
nSignals=length(meanData);
%nSignals=max(nSig);
nSamples=meanData(1).meanRMSE(1).nSamples;


for i=1:nSignals
signalNames(i)=meanData(i).signalName;
if plotSignalName == meanData(i).signalName
    iSignal=i;
end
end

meanRSMEdly(ii,:)=meanData(iSignal).meanRMSE(1).meanErrorDly(3,:);
meanRSMEdop(ii,:)=meanData(iSignal).meanRMSE(1).meanErrorDop(3,:);
meanRsmeIDSF(ii,:)=meanData(iSignal).meanRmseIDSF(1).meanErrorIDSF(3,:); 

end
sNames=legendNames(signalNames, nSignals, language);
       
sColorDly=[0.5 0 0.1;    0.3 0.5 0;     0.7 0.6 0;  0 0.3 0.5; ...
          0.8 0.4 0;    0.6, 0, 0.6;   0 0.4 0.5;  0.5 0.4 0.7];
      
sColorDop=[0.8 0.2 0.2;   0 0.5 0.4;     0.9 0.7 0.3;   0 0.3 0.8; ...
          0.9 0.5 0.1;   0.8, 0, 0.8;   0 0.5 0.7;     0.4 0.5 0.9];

sColorIDSF=[0.7 0.1 0.1;  0 0.3 0.2;     0.9 0.7 0.3;  0 0.4 0.8; ...
           0.9 0.4 0.1;  0.6, 0, 0.5;   0 0.45 0.6;     0.5 0.5 0.8];    

colorDly=[0.1, 0.4, 0.6; 0.4, 0.3, 0.7; 0.6, 0.6, 0.1];
colorDop=[0.1, 0.4, 0.8; 0.4, 0.5, 0.9; 0.9, 0.9, 0.3];
colorIDSF=[0, 0.3, 0.7; 0.3, 0.4, 0.8; 0.6, 0.3, 0.1];

colorDly=[sColorDly(iSignal,:); colorDly];
colorDop=[sColorDop(iSignal,:); colorDop];
colorIDSF=[sColorIDSF(iSignal,:); colorIDSF];

line=["*-", "-.", ":", "--"];

% colorDly12=[0 0 0.7]; colorDly22=[0 0.5 0.3];
% colorDop12=[0.2, 0.0, 0.5]; colorDop22=[0 0.5 0.3];
 
if savePlot=="plot" || savePlot=="all" ploting="on"; 
else ploting="off"; end
%% Plot RMSE x Eb/No e Pe Teórica - for RMS Delay/Doppler Spread
%% Delay Spread - Different Tx Signal Lengths
fig(1).results=figure('visible',ploting);
for i=1:length(lenTxSignal)
semilogy(meanData(1).snrValues, meanRSMEdly(i,:),line(i),'Color',colorDly(i,:),'linewidth',2)
hold on 
    if language=="por"
        legendInput(i)=strcat(sNames(iSignal), " - N=", num2str(lenTxSignal(i)));  
    else
        legendInput(i)=strcat(sNames(iSignal), " - N=", num2str(lenTxSignal(i)));  
    end
end    
legend (legendInput);
xlabel('SNR (dB)')
ylabel('RMSE')
if language=="por"
title(strcat("RMSE da Média dos Espalhamentos do Atraso RMS Médios - ", num2str(nSamples),...
    " Amostras / ", num2str(repMontCarlo)," Repetições"))
else
title(strcat("RMSE of Mean Average RMS Delay Spread - ", num2str(nSamples),...
    " Samples / ", num2str(repMontCarlo)," Repetitions"))
end
grid on
hold off;

%% Doppler Spread - Different Tx Signal Lengths
fig(2).results=figure('visible',ploting);
for i=1:length(lenTxSignal)
semilogy(meanData(1).snrValues, meanRSMEdop(i,:),line(i),'Color',colorDop(i,:),'linewidth',2)
hold on    
    if language=="por"
        legendInput(i)=strcat(sNames(iSignal), " - N=", num2str(lenTxSignal(i)));  
    else
        legendInput(i)=strcat(sNames(iSignal), " - N=", num2str(lenTxSignal(i)));  
    end
end    
legend (legendInput);
xlabel('SNR (dB)')
ylabel('RMSE')
if language=="por"
title(strcat("RMSE da Média dos Espalhamentos Doppler RMS Médios - ", num2str(nSamples),...
    " Amostras / ", num2str(repMontCarlo)," Repetições"))
else
title(strcat("RMSE of Mean Average RMS Doppler Spread - ", num2str(nSamples),...
    " Samples / ", num2str(repMontCarlo)," Repetitions"))
end
grid on
hold off;

%% IDSF - Different Lengths
fig(3).results=figure('visible',ploting);

for i=1:length(lenTxSignal)
semilogy(meanData(1).snrValues, meanRsmeIDSF(i,:),line(i),'Color',colorIDSF(i,:),'linewidth',2)
hold on
    if language=="por"
        legendInput(i)=strcat(sNames(iSignal), " - N=", num2str(lenTxSignal(i)));  
    else
        legendInput(i)=strcat(sNames(iSignal), " - N=", num2str(lenTxSignal(i)));  
    end
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
names=["Dly","Dop","IDSF"];
if savePlot == "save" || savePlot=="all"        
        for i=1:3
        print(fig(i).results, strcat("../results/",simulOutputName,"/figures/difLength/RMSE_",names(i),...
        "_dLEN_",meanData(iSignal).signalName,"_",num2str(lenTxSignal(1)),...
        "len_", num2str(nSamples),"samp_", num2str(repMontCarlo),"rep"),...
        '-dpng');
        
        saveas(fig(i).results, strcat("../results/",simulOutputName,"/figures/difLength/RMSE_",names(i),...
        "_dLEN_",meanData(iSignal).signalName,"_",num2str(lenTxSignal(1)),...
        "len_", num2str(nSamples),"samp_", num2str(repMontCarlo),"rep",...
        ".fig")); 
        end
        if savePlot == "save" close; close; close; end
end
end