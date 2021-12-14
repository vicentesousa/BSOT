function plotSpecialFunc(savePlot, language, simulOutputName, ...
    signalName, sizeTxSignal, modelPDP, modelDopPDS, PDP, DopPDS, ...
    TCF, FCF, thresholdDly, thresholdDop, sigmaDly, sigmaDop, modelNsamples, ...
    nSamples, delayAxis, fs, fm, snrDB, corrFunc)

color=[0.6 0.6 0.6; 0 0.3 0.7; 1 0 0; 1 0.9 0; 0.2, 0.6, 0.5; 1 0.9 0; 0.5, 0.3, 0.9;...
       1, 0, 1;  1, 0, 1; 1 0.5 0; 0.3, 0.3, 0.3; 0.1, 0.9, 0.1];

if savePlot=="plot" || savePlot=="all"; ploting="on"; 
else ploting="off"; end   
%% Delay Spread
nDelays=length(delayAxis); 

fig(1).results=figure('visible',ploting);
plot(delayAxis,10*log10(modelPDP./max(modelPDP)),'Color',color(1,:),'linewidth',1)
hold on
plot(delayAxis,10*log10(PDP./max(PDP)),'Color',color(2,:),'linewidth',1.5)
plot(delayAxis,10*log10(ones(1,nDelays)*thresholdDly./max(PDP)),'--','Color',color(3,:),'linewidth',1.2)
%plot(delayAxis,10*log10(ones(1,nDelays)*median(PDP)./max(PDP)),'--','Color',color(4,:),'linewidth',1.2)
%plot(delayAxis,10*log10(ones(1,nDelays)*sigmaDly./max(PDP)),'--','Color',color(5,:),'linewidth',1.2)
axis([ -inf inf  10*log10(thresholdDly./max(PDP))-10 5])
if language=="por"
legend ('Modelo de Canal','PDP Médio','Limiar de Detecção');%,'Mediana','Desvio Padrão');
title(strcat("PDP Médio, SNR = ",num2str(snrDB)," dB"," - Tamanho do Sinal: ",num2str(sizeTxSignal)," - Amostras: ", num2str(nSamples)," -  Repetições: 1")) 
ylabel('Densidade de Potência Normalizada (dB)')
xlabel('Atraso em Excesso (\mus)')
else
legend ('Channel Model','Average PDP','Threshold');%,'Median','Standard Deviation');
title(strcat("Average PDP, SNR = ",num2str(snrDB)," dB"," - Signal Length: ",num2str(sizeTxSignal)," - Samples: ", num2str(nSamples)," - Repetitions: 1")) 
ylabel('Normalized Power Density (dB)')
xlabel('Excess Delay (\mus)')
end

%% Doppler Spread
plotDopPDS=[zeros(ceil((length(modelDopPDS)-length(DopPDS))/2),1); DopPDS; zeros(floor((length(modelDopPDS)-length(DopPDS))/2),1)];
dopplerAxis = ((-modelNsamples+1)/2:(modelNsamples-1)/2)*(fs/(modelNsamples-1));

fig(2).results=figure('visible',ploting);
plot(dopplerAxis,10*log10(modelDopPDS./max(modelDopPDS)),'Color',color(1,:),'linewidth',1)
hold on
plot(dopplerAxis,10*log10(plotDopPDS./max(DopPDS)),'Color',color(2,:),'linewidth',1.5)
plot(dopplerAxis,10*log10(ones(1,modelNsamples)*thresholdDop./max(DopPDS)),'--','Color',color(3,:),'linewidth',1.2)
%plot(dopplerAxis,10*log10(ones(1,modelNsamples)*median(DopPDS)./max(DopPDS)),'--','Color',color(4,:),'linewidth',1.2)
%plot(dopplerAxis,10*log10(ones(1,modelNsamples)*sigmaDop./max(DopPDS)),'--','Color',color(5,:),'linewidth',1.2)
axis([ -2*fm 2*fm  10*log10(thresholdDop./max(DopPDS))-15 5])
if language=="por"
legend ('Modelo de Canal','Sondagem Seq. Golay','Limiar de Detecção');%,'Mediana','Desvio Padrão');
title(strcat("Doppler PDS Médio, SNR = ",num2str(snrDB)," dB"," - Tamanho do Sinal: ",num2str(sizeTxSignal)," - Amostras: ", num2str(nSamples)," -  Repetições: 1")) 
xlabel('Desvio Doppler (Hz)')
ylabel('Densidade de Potência Normalizada (dB)')
else
legend ('Channel Model','Average Doppler PDS','Threshold');%,'Median','Standard Deviation');
title(strcat("Average Doppler PDS, SNR = ",num2str(snrDB)," dB"," - Signal Length: ",num2str(sizeTxSignal)," - Samples: ", num2str(nSamples)," - Repetitions: 1")) 
xlabel('Doppler Shift (Hz)')
ylabel('Normalized Power Density (dB)')
end

if corrFunc == "on"
freqStep = 1/max(delayAxis); %frequency step (MHz)
nDelay=length(delayAxis);
fcorrAxis = ((-nDelay+1)/2:(nDelay-1)/2)*freqStep;%freq. correlation axis
                                                  %(MHz)
%centering
tcorrAxis =((-nSamples)/2:(nSamples)/2)*(1/fs); %Time correlation axis(s)
TCF=[TCF; TCF(end)];
    
%% TCF    
fig(3).results=figure('visible',ploting);
plot(tcorrAxis,abs(TCF./max(TCF)),'Color',color(1,:),'linewidth',1)
if language=="por"
title(strcat("Função de Correlação no Tempo (TCF) - SNR: ",num2str(snrDB)," dB"," - Tamanho do Sinal: ",num2str(sizeTxSignal)," - Amostras: ", num2str(nSamples)," -  Repetições: 1")) 
ylabel('Correlação')
xlabel('Espaçamento no Tempo (s)')
else
title(strcat("Time Correlation Function (TCF) - SNR: ",num2str(snrDB)," dB"," - Signal Length: ",num2str(sizeTxSignal)," - Samples: ", num2str(nSamples)," - Repetitions: 1")) 
ylabel('Correlation')
xlabel('Espaced Time (s)')   
end

%% FCF
fig(4).results=figure('visible',ploting);
plot(fcorrAxis,abs(FCF./max(FCF)),'Color',color(1,:),'linewidth',1)
if language=="por"
title(strcat("Função de Correlação na Frequência (FCF) - SNR: ",num2str(snrDB)," dB"," - Tamanho do Sinal: ",num2str(sizeTxSignal)," - Amostras: ", num2str(nSamples)," -  Repetições: 1")) 
ylabel('Correlação')
xlabel('Espaçamento na Frequência (MHz)')
else
title(strcat("Frequency Correlation Function (FCF) - SNR: ",num2str(snrDB)," dB"," - Signal Length: ",num2str(sizeTxSignal)," - Samples: ", num2str(nSamples)," - Repetitions: 1")) 
ylabel('Correlation')
xlabel('Espaced Frequency (MHz)')  
end 

end

%% Save Figures
names=["Dly","Dop"]; folderName=["PDP","DopPDS"];
if savePlot == "save" || savePlot=="all"        
        for i=1:2
        print(fig(i).results, strcat("../../../results/",simulOutputName,"/figures/functionsAnalysis/specialFunctions/",...
        folderName(i),"/",signalName,"_",names(i),"_",num2str(sizeTxSignal),"len_", num2str(nSamples),...
        "samp_", num2str(1),"rep_SNR-",num2str(snrDB),"dB"),'-dpng');

        saveas(fig(i).results, strcat("../../../results/",simulOutputName,"/figures/functionsAnalysis/specialFunctions/",...
        folderName(i),"/",signalName,"_",names(i),"_",num2str(sizeTxSignal),"len_", num2str(nSamples),...
        "samp_", num2str(1),"rep_SNR-",num2str(snrDB),"dB",".fig"));
        end
        if savePlot == "save"; close; close; end
end
end