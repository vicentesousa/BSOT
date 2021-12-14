function plotSeqAcConj(savePlot, language, simulOutputName, ...
    signalNames, sNames, lenTxSignal, aCorr, nDelays)

if savePlot=="plot" || savePlot=="all"; ploting="on"; 
else ploting="off"; end

nSignals=length(signalNames);

% color=[1 0 0;      0 0.9 0.9;    0.8 0.7 0;         0 0 1;            0.2, 0.6, 0.5;     0.5, 0.3, 0.9;...
%        1 0.5 0;    1, 0, 1;      0.5, 0.5, 0.5;     0.1, 0.9, 0.1;    0.7, 0.6, 1;       1 0 0];
   
color=[0.7 0.1 0.1;  0 0.3 0.2;     0.9 0.7 0.3;  0 0.4 0.8; ...
       0.9 0.4 0.1;  0 0.45 0.6;     0.5 0.5 0.8;  0.6, 0, 0.5;  0.5, 0.5, 0.5];
       
line=[ "-", "--","-"]; 

if lenTxSignal<nDelays; nDelays=lenTxSignal; end % in this case: no zoom

%% Conjugated Sequence Autocorrelations
for ii=0:3:3
legName=[];
maxAcorr=[]; minAcorr=[];
m=1;
fig(ii/3+1).results=figure('visible',ploting);

for kk=1+ii:(nSignals-2)/2+ii
    
if kk==6 kk=8; end

minAcorr(m)=min(real(aCorr(kk,(lenTxSignal/2)-floor((nDelays+1)/2)+1:(lenTxSignal/2)+floor((nDelays+1)/2))));
maxAcorrAux=sort(aCorr(kk,(lenTxSignal/2)-floor((nDelays+1)/2)+1:(lenTxSignal/2)+floor((nDelays+1)/2)),'descend');
maxAcorr(m)=abs(maxAcorrAux(2)); m=m+1;

if signalNames(kk)=="SEQN-ZC" 
plot(abs(aCorr(kk,:)),line(1),'Color',color(kk,:),'linewidth',2)
else if signalNames(kk)=="SEQN-Gy" 
plot((aCorr(kk,:)),line(2),'Color',color(kk,:),'linewidth',2)
else if signalNames(kk)=="SEQN-PN" 
plot((aCorr(kk,:)),line(3),'Color',color(kk,:),'linewidth',5)
else
plot((aCorr(kk,:)),line(1),'Color',color(kk,:),'linewidth',2)
end
end
end
hold on
legName=[legName; sNames(kk)];
end

hold on
plot(zeros(1,lenTxSignal),line(2),'Color',color(9,:),'linewidth',1)
hold on
plot(ones(1,lenTxSignal)*max(minAcorr),line(2),'linewidth',1,'Color',color(9,:))
hold on
plot(ones(1,lenTxSignal)*min(maxAcorr),line(2),'linewidth',1,'Color',color(9,:))
legend(legName)
axis([ (lenTxSignal/2)-floor((49+1)/2)+1 (lenTxSignal/2)+floor((49+1)/2)  (-max(abs(minAcorr))-0.1) 1.2])
hold off

    if language=="por"
        title(strcat('Autocorrelação',...
            " - Tamanho da Sequência: ", num2str(lenTxSignal))) 
        xlabel('Amostras')
        ylabel('Amplitude Normalizada')
    else
        title(strcat('Autocorrelation',...
            " - Sequence Length: ", num2str(lenTxSignal))) 
        xlabel('Samples')
        ylabel('Normalized Amplitude') 
    end

end

%% Save Figures
names=["ConjSeq","BestSeq"];
if savePlot == "save" || savePlot=="all"        

    for i=1:2
    print(fig(i).results, strcat("../../../results/",simulOutputName,...
    "/figures/signalAnalysis/autocorrelation/",...
    names(i),"_AcConj_",num2str(lenTxSignal),...
    "len"),'-dpng');

    saveas(fig(i).results, strcat("../../../results/",simulOutputName,...
    "/figures/signalAnalysis/autocorrelation/",...
    names(i),"_AcConj_",num2str(lenTxSignal),...
    "len",".fig"));
    end
    
    if savePlot == "save"; close; close; end
end
end