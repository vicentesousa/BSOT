function plotSystemFunc(savePlot, language, simulOutputName, ...
    signalName, lenTxSignal, IDSF, DDSF, channelModel,...
    delayAxis, nSamples, modelNsamples, fs, fm, ts, snrDB)

% Doppler / Time Axes (MHz)
dopplerAxis = ((-nSamples+1)/2:(nSamples-1)/2)*(fs/(nSamples-1));
modelTimeAxis = ts.*[0:modelNsamples(1)-1];
timeAxis = (1/fs).*[0:nSamples(1)-1];

if savePlot=="plot" || savePlot=="all"; ploting="on"; 
else ploting="off"; end 

%% IDSF Model 
fig(1).results=figure('visible',ploting);
surf(delayAxis,modelTimeAxis,abs(channelModel))
shading interp 

if language=="por"
title(strcat("Modelo - Input Delay Spread Function (IDSF)",...
    " - Amostras: ", num2str(modelNsamples))) 
xlabel('Atraso em Excesso (\mus)')
ylabel('Tempo (s)')
zlabel('Amplitude (linear)')
else
title(strcat("Model - Input Delay Spread Function (IDSF)",...
    " - Samples: ", num2str(modelNsamples))) 
xlabel('Excess Delay (\mus)')
ylabel('Time (s)')
zlabel('Amplitude (lin. unit)')  
end

%% Sounding IDSF
fig(2).results=figure('visible',ploting);
surf(delayAxis,timeAxis,abs(IDSF))
shading interp 

if language=="por"
title(strcat("Input Delay Spread Function (IDSF) - SNR: ",...
    num2str(snrDB)," dB"," - Tamanho do Sinal: ",num2str(lenTxSignal),...
    " - Amostras: ", num2str(nSamples)," -  Repetições: 1")) 
xlabel('Atraso em Excesso (\mus)')
ylabel('Tempo (s)')
zlabel('Amplitude (linear)')
else
title(strcat("Input Delay Spread Function (IDSF) - SNR: ",...
    num2str(snrDB)," dB"," - Signal Length: ",num2str(lenTxSignal),...
    " - Samples: ", num2str(nSamples)," - Repetitions: 1")) 
xlabel('Excess Delay (\mus)')
ylabel('Time (s)')
zlabel('Amplitude (lin. unit)')  
end

%% Sounding DDSF
fig(3).results=figure('visible',ploting);
surf(delayAxis,dopplerAxis,abs(DDSF))
shading interp 
axis([ -inf inf -2*fm 2*fm -inf inf])
if language=="por"
title(strcat("Delay Doppler Spread Function (DDSF) - SNR: ",...
    num2str(snrDB)," dB"," - Tamanho do Sinal: ",num2str(lenTxSignal),...
    " - Amostras: ", num2str(nSamples)," -  Repetições: 1")) 
xlabel('Atraso em Excesso (\mus)')
ylabel('Desvio Doppler (Hz)')
zlabel('Amplitude (linear)')
else
title(strcat("Delay Doppler Spread Function (DDSF) - SNR: ",...
    num2str(snrDB)," dB"," - Signal Length: ",num2str(lenTxSignal),...
    " - Samples: ", num2str(nSamples)," - Repetitions: 1")) 
xlabel('Excess Delay (\mus)')
ylabel('Doppler Shift (Hz)')
zlabel('Amplitude (lin. unit)')   
end

%% Save Figures
names=["IDSFmodel","IDSF","DDSF"]; 
if savePlot == "save" || savePlot=="all"        
    
    print(fig(1).results, strcat("../../../results/",simulOutputName,...
    "/figures/functionsAnalysis/systemFunctions/",...
    signalName,"_",names(1),"_",num2str(modelNsamples),"samp"),'-dpng');

    saveas(fig(1).results, strcat("../../../results/",simulOutputName,...
    "/figures/functionsAnalysis/systemFunctions/",...
    signalName,"_",names(1),"_",num2str(modelNsamples),"samp",".fig"));
    
    for i=2:3
    print(fig(i).results, strcat("../../../results/",simulOutputName,...
    "/figures/functionsAnalysis/systemFunctions/",...
    "/",signalName,"_",names(i),"_",num2str(lenTxSignal),...
    "len_", num2str(nSamples),"samp_", num2str(1),"rep_SNR-",...
    num2str(snrDB),"dB"),'-dpng');

    saveas(fig(i).results, strcat("../../../results/",simulOutputName,...
    "/figures/functionsAnalysis/systemFunctions/",...
    "/",signalName,"_",names(i),"_",num2str(lenTxSignal),...
    "len_", num2str(nSamples),"samp_", num2str(1),"rep_SNR-",...
    num2str(snrDB),"dB",".fig"));
    end
    
    if savePlot == "save"; close; close; end
end
end