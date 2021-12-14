function plotSeqAutoCorr(savePlot, language, simulOutputName, ...
    signalNames, sNames, lenTxSignal, aCorr)

if savePlot=="plot" || savePlot=="all"; ploting="on"; 
else ploting="off"; end

color=[0, 0.6, 0.6; 0.5 0.5 0.5; 1 0 0; 0.6, 0, 0.5;]; line=["--"];
nSignals=length(signalNames);

%% Autocorrelation of all Sequences
for kk=1:nSignals

minYaxis=-abs(min(aCorr(kk,:)))-0.1;

fig(kk).results=figure('visible',ploting);

if signalNames(kk)=="SEQN-ZC" 
plot(abs(aCorr(kk,:)),'linewidth',1.5,'Color',color(1,:))
else
plot((aCorr(kk,:)),'linewidth',1.5,'Color',color(4,:))
end
if language=="por"
title(strcat(sNames(kk),' - Autocorrelação',...
    " - Tamanho da Sequência: ", num2str(lenTxSignal))) 
xlabel('Amostras')
ylabel('Amplitude Normalizada (1/N)') 
else
title(strcat(sNames(kk),' - Autocorrelation',...
    " - Sequence Length: ", num2str(lenTxSignal))) 
xlabel('Samples')
ylabel('Normalized Amplitude (1/N)') 
end
hold on
%plot(zeros(1,lenTxSignal),'r--')
legend('Sequência Golay B - N=1024')
axis([-inf inf  minYaxis 1.1])

end

%% Save Figures
if savePlot == "save" || savePlot=="all"        

    for i=1:nSignals
    print(fig(i).results, strcat("../../../results/",simulOutputName,...
    "/figures/signalAnalysis/autocorrelation/",...
    signalNames(i),"_AutoCorr_",num2str(lenTxSignal),...
    "len"),'-dpng');

    saveas(fig(i).results, strcat("../../../results/",simulOutputName,...
    "/figures/signalAnalysis/autocorrelation/",...
    signalNames(i),"_AutoCorr_",num2str(lenTxSignal),...
    "len",".fig"));
    end
    
    if savePlot == "save"; close; close; end
end
end