function plotDlyDopRMSE(savePlot, language, simulOutputName, ...
    signalName, lenTxSignal, errorDly, errorDop, rmsDelay, rmsDoppler,...
    rmsDelayModel, rmsDopplerModel, nSamples, snrs)

if savePlot=="plot" || savePlot=="all"; ploting="on"; 
else ploting="off"; end 

colorDly=[0.3 0.5 0];
colorDop=[0 0.5 0.4];

%% Delay Spread RMSE
fig(1).results=figure('visible',ploting);
semilogy(snrs,errorDly,'Color',colorDly(1,:),'linewidth',2)

if language=="por"
title(strcat("RMSE do Espalhamento do Atraso RMS Médio",...
    " - Tamanho do Sinal: ",num2str(lenTxSignal),...
    " - Amostras: ", num2str(nSamples)," -  Repetições: 1")) 
else
title(strcat("RMSE of Average RMS Delay Spread",...
    " - Signal Length: ",num2str(lenTxSignal),...
    " - Samples: ", num2str(nSamples)," - Repetitions: 1")) 
end
xlabel('SNR (dB)')
ylabel('RSME')
grid on

%% Doppler Spread RMSE
fig(2).results=figure('visible',ploting);
semilogy(snrs,errorDop,'Color',colorDop(1,:),'linewidth',2)

if language=="por"
title(strcat("RMSE do Espalhamento Doppler RMS Médio",...
    " - Tamanho do Sinal: ",num2str(lenTxSignal),...
    " - Amostras: ", num2str(nSamples)," -  Repetições: 1")) 
else
title(strcat("RMSE of Average RMS Doppler Spread",...
    " - Signal Length: ",num2str(lenTxSignal),...
    " - Samples: ", num2str(nSamples)," - Repetitions: 1")) 
end
xlabel('SNR (dB)')
ylabel('RSME')
grid on

%% Delay Spread
fig(3).results=figure('visible',ploting);
semilogy(snrs,ones(1,length(snrs))*rmsDelayModel,'go','linewidth',2)
hold on
semilogy(snrs,rmsDelay,'Color',colorDly(1,:),'linewidth',2)
if language=="por"
title(strcat("Espalhamento do Atraso RMS Médio",...
    " - Tamanho do Sinal: ",num2str(lenTxSignal),...
    " - Amostras: ", num2str(nSamples)," -  Repetições: 1")) 
legend ('Modelo de Canal','Sondagem de Canal');
ylabel('Espalhamento do Atraso RMS (\mus)')
else
title(strcat("Average RMS Delay Spread",...
    " - Signal Length: ",num2str(lenTxSignal),...
    " - Samples: ", num2str(nSamples)," - Repetitions: 1")) 
legend ('Channel Model','Channel Sounding');
ylabel('RMS Delay Spread (\mus)')
end
xlabel('SNR (dB)')
grid on

%% Doppler Spread
fig(4).results=figure('visible',ploting);
semilogy(snrs,ones(1,length(snrs))*rmsDopplerModel,'go','linewidth',2)
hold on
semilogy(snrs,rmsDoppler,'Color',colorDop(1,:),'linewidth',2)
if language=="por"
title(strcat("Espalhamento Doppler RMS Médio",...
    " - Tamanho do Sinal: ",num2str(lenTxSignal),...
    " - Amostras: ", num2str(nSamples)," -  Repetições: 1")) 
legend ('Modelo de Canal','Sondagem de Canal');
ylabel('Espalhemento Doppler RMS (Hz)')
else
title(strcat("Average RMS Doppler Spread",...
    " - Signal Length: ",num2str(lenTxSignal),...
    " - Samples: ", num2str(nSamples)," - Repetitions: 1")) 
legend ('Channel Model','Channel Sounding');
ylabel('RMS Doppler Spread (Hz)')
end
xlabel('SNR (dB)')
grid on

%% Save Figures
names=["RMSEdly","RMSEdop","Dly","Dop"]; 
if savePlot == "save" || savePlot=="all"        
    
    for i=1:4
    print(fig(i).results, strcat("../../../results/",simulOutputName,...
    "/figures/functionsAnalysis/dlyDopRMSE/",...
    "/",signalName,"_",names(i),"_",num2str(lenTxSignal),...
    "len_", num2str(nSamples),"samp_", num2str(1),"rep"),'-dpng');

    saveas(fig(i).results, strcat("../../../results/",simulOutputName,...
    "/figures/functionsAnalysis/dlyDopRMSE/",...
    "/",signalName,"_",names(i),"_",num2str(lenTxSignal),...
    "len_", num2str(nSamples),"samp_", num2str(1),"rep",".fig"));
    end
    
    if savePlot == "save"; close; close; end
end
end