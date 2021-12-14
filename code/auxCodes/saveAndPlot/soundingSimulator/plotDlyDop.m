function plotDlyDop(savePlot, language, modelNsamples, repMontCarlo, lenTxSignal, simulOutputName)
%% Load RMS Error
inputName=strcat("meanData_",num2str(lenTxSignal),"len_",num2str(modelNsamples),"samp_",num2str(repMontCarlo),"rep");
load(strcat("../results/", simulOutputName,"/outputData/",inputName,".mat"));
%% Load Channel Model
inputName=strcat("CIR_Model_",num2str(modelNsamples),"samp_",num2str(repMontCarlo),"rep");
load(strcat("../results/",simulOutputName,"/inputData/cirModel/",inputName,".mat"));

nSamples=meanData(1).meanRMSE(1).nSamples;
nSignals=length(meanData);

for ii=1:nSignals
signalNames(ii)=meanData(ii).signalName;
end
sNames=legendNames(signalNames, nSignals, language);

% Channel Model Delay / Doppler
sumRmsDly=0; sumRmsDop=0;
for i=1:repMontCarlo
sumRmsDly=sumRmsDly+channelModel(i).rmsDelay;
sumRmsDop=sumRmsDop+channelModel(i).rmsDoppler;
end
meanRmsDly=sumRmsDly/repMontCarlo;
meanRmsDop=sumRmsDop/repMontCarlo;
lineMeanRmsDly=ones(1,length(meanData(1).snrValues))*meanRmsDly;
lineMeanRmsDop=ones(1,length(meanData(1).snrValues))*meanRmsDop;

colorDly=[0 1 0;   0.5 0 0.1;     0.3 0.5 0;     0.7 0.6 0;  0 0.3 0.6; ...
          0.8 0.4 0;    0.6, 0, 0.6;   0 0.4 0.5;      0.5 0.4 0.7];
      
colorDop=[0 1 0;  0.8 0.2 0.2;  0 0.5 0.4;   0.9 0.7 0.3;   0 0.3 0.8; ...
          0.9 0.5 0.1;   0.8, 0, 0.8;   0 0.5 0.7;         0.4 0.5 0.9];
      
line=["o","o-", "x-.", "+-.", "-.", "--", "*-", "-", "-"];

if savePlot=="plot" || savePlot=="all"; ploting="on"; 
else ploting="off"; end
%% Plot RMSE x SNR e Pe Teórica - for RMS Delay/Doppler Spread
%% Delay Spread - Different Signals
fig(1).results=figure('visible',ploting);
semilogy(meanData(1).snrValues,lineMeanRmsDly,line(1),'Color',colorDly(1,:),'linewidth',2)
legendInput(1)="CIR-Model";
for i=1:nSignals
hold on
semilogy(meanData(1).snrValues, meanData(i).dlyDop(1).meanDly(3,:),line(i+1),'Color',colorDly(i+1,:),'linewidth',2)
legendInput(i+1)=sNames(i);
end
legend (legendInput);
xlabel('SNR (dB)')

if language=="por"
title(strcat("Média dos Espalhamentos do Atraso RMS Médios - ", num2str(nSamples),...
    " Samples / ", num2str(repMontCarlo)," Repetitions"))
ylabel('Espalhamento do Retardo RMS (us)')
else
title(strcat("Mean Average RMS Delay Spread - ", num2str(nSamples),...
    " Amostras / ", num2str(repMontCarlo)," Repetições"))
ylabel('RMS Delay Spread (us)')
end
grid on
hold off;

%% Doppler Spread - Different Signals
fig(2).results=figure('visible',ploting);
semilogy(meanData(1).snrValues,lineMeanRmsDop,line(1),'Color',colorDop(1,:),'linewidth',2)
legendInput(1)="CIR-Model";
for i=1:nSignals
hold on
semilogy(meanData(1).snrValues, meanData(i).dlyDop(1).meanDop(3,:),line(i+1),'Color',colorDop(i+1,:),'linewidth',2)
legendInput(i+1)=sNames(i);
end
legend (legendInput);
xlabel('SNR (dB)')
if language=="por"
title(strcat("Média dos Espalhamentos Doppler RMS Médios - ", num2str(nSamples),...
    " Amostras / ", num2str(repMontCarlo)," Repetições"))
ylabel('Espalhamento Doppler RMS (Hz)')
else
title(strcat("Mean Average RMS Doppler Spread - ", num2str(nSamples),...
    " Samples / ", num2str(repMontCarlo)," Repetitions"))
ylabel('RMS Doppler Spread (Hz)')
end
grid on
hold off;


%% Save Figures
names=["Dly","Dop"];
if savePlot == "save" || savePlot=="all"        
        for i=1:2
        print(fig(i).results, strcat("../results/",simulOutputName,"/figures/dlyDop/",...
        names(i),"_",num2str(lenTxSignal(1)),"len_", num2str(nSamples),...
        "samp_", num2str(repMontCarlo),"rep"),'-dpng');

        saveas(fig(i).results, strcat("../results/",simulOutputName,"/figures/dlyDop/",...
        names(i),"_",num2str(lenTxSignal(1)),"len_", num2str(nSamples),...
        "samp_", num2str(repMontCarlo),"rep",".fig"));
        end
        if savePlot == "save"; close; close; end
end
end
