function plotCorrelationFunc(savePlot, language, simulOutputName, ...
    signalName, lenTxSignal, SF, delayAxis, nSamples, fs, fm, snrDB)

% Doppler / Time Axes (MHz)
dopplerAxis = ((-nSamples+1)/2:(nSamples-1)/2)*(fs/(nSamples-1));

if savePlot=="plot" || savePlot=="all"; ploting="on"; 
else ploting="off"; end 

%% Sounding SF
fig(1).results=figure('visible',ploting);
surf(delayAxis,dopplerAxis,10*log10(abs(SF)./max(max(SF))))
shading interp 
axis([ -inf inf -2*fm 2*fm -inf inf])
if language=="por"
title(strcat("Scattering Function (SF) - SNR: ",...
    num2str(snrDB)," dB"," - Tamanho do Sinal: ",num2str(lenTxSignal),...
    " - Amostras: ", num2str(nSamples)," -  Repetições: 1")) 
xlabel('Atraso em Excesso (\mus)')
ylabel('Desvio Doppler (Hz)')
zlabel('Densidade de Potência (dB)')
else
title(strcat("Scattering Function (SF) - SNR: ",...
    num2str(snrDB)," dB"," - Signal Length: ",num2str(lenTxSignal),...
    " - Samples: ", num2str(nSamples)," - Repetitions: 1")) 
xlabel('Excess Delay (\mus)')
ylabel('Doppler Shift (Hz)')
zlabel('Power Density (dB)')  

end

%% Save Figures
names=["SF"]; 
if savePlot == "save" || savePlot=="all"        

    for i=1:1
    print(fig(i).results, strcat("../../../results/",simulOutputName,...
    "/figures/functionsAnalysis/correlationFunctions/",...
    "/",signalName,"_",names(i),"_",num2str(lenTxSignal),...
    "len_", num2str(nSamples),"samp_", num2str(1),"rep_SNR-",...
    num2str(snrDB),"dB"),'-dpng');

    saveas(fig(i).results, strcat("../../../results/",simulOutputName,...
    "/figures/functionsAnalysis/correlationFunctions/",...
    "/",signalName,"_",names(i),"_",num2str(lenTxSignal),...
    "len_", num2str(nSamples),"samp_", num2str(1),"rep_SNR-",...
    num2str(snrDB),"dB",".fig"));
    end
    
    if savePlot == "save"; close; close; end
end
end