function plotSeqAcZoom(savePlot, language, simulOutputName, ...
    signalNames, sNames, lenTxSignal, aCorr, nDelays)

if savePlot=="plot" || savePlot=="all"; ploting="on"; 
else ploting="off"; end

color=[0, 0.6, 0.6; 0.5 0.5 0.5; 1 0 0]; line=["--"];
nSignals=length(signalNames);

if lenTxSignal<nDelays; nDelays=lenTxSignal; end % in this case: no zoom

%% Autocorrelation of all Sequences
for kk=1:nSignals
maxAcorrAux=sort(aCorr(kk,(lenTxSignal/2)-floor((nDelays+1)/2)+1:(lenTxSignal/2)+floor((nDelays+1)/2)),'descend');
maxAcorr=abs(maxAcorrAux(2));
minAcorr=min(aCorr(kk,(lenTxSignal/2)-floor((nDelays+1)/2)+1:(lenTxSignal/2)+floor((nDelays+1)/2)));
fig(kk).results=figure('visible',ploting);

if signalNames(kk)=="SEQN-ZC" 
plot(abs(aCorr(kk,:)),'linewidth',1.2,'Color',color(1,:))
else
plot((aCorr(kk,:)),'linewidth',1.2,'Color',color(1,:))
end
if language=="por"
title(strcat(sNames(kk),' - Autocorrelação',...
    " - Tamanho da Sequência: ", num2str(lenTxSignal))) 
xlabel('Amostras')
ylabel('Amplitude Relativa')
else
title(strcat(sNames(kk),' - Autocorrelation',...
    " - Sequence Length: ", num2str(lenTxSignal))) 
xlabel('Samples')
ylabel('Relative Amplitude') 
end
hold on
plot(zeros(1,lenTxSignal),line(1),'linewidth',1.1,'Color',color(3,:))
hold on
plot(ones(1,lenTxSignal)*minAcorr,line(1),'linewidth',1,'Color',color(2,:))
hold on
plot(ones(1,lenTxSignal)*maxAcorr,line(1),'linewidth',1,'Color',color(2,:))
axis([ (lenTxSignal+2)/2-(nDelays+1)/2 (lenTxSignal+2)/2+(nDelays+1)/2  (-abs(minAcorr)-0.1) 2.2])

end

%% Save Figures
if savePlot == "save" || savePlot=="all"        

    for i=1:nSignals
    print(fig(i).results, strcat("../../../results/",simulOutputName,...
    "/figures/signalAnalysis/autocorrelation/",...
    signalNames(i),"_AcZoom_",num2str(lenTxSignal),...
    "len"),'-dpng');

    saveas(fig(i).results, strcat("../../../results/",simulOutputName,...
    "/figures/signalAnalysis/autocorrelation/",...
    signalNames(i),"_AcZoom_",num2str(lenTxSignal),...
    "len",".fig"));
    end
    
    if savePlot == "save"; close; close; end
end
end