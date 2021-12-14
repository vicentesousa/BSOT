function plotTimeInvAnalysis(savePlot, language, simulOutputName, ...
    signalNames, lenTxSignal, cirModel, CIR, rmsError, delayAxis, snrAxis)

color=[0.7 0.1 0.1;  0 0.3 0.2;     0.9 0.7 0.3;  0 0.4 0.8; ...
           0.9 0.4 0.1;  0.6, 0, 0.5;   0 0.45 0.6;     0.5 0.5 0.8];
line=[ "-", "--"]; 

lineRMSE=["o-", "x-.", "+-.", "-.", "--", "*-", "-", "-"];

nSignals=length(signalNames);
sNames=legendNames(signalNames, nSignals, language);  % Legend Names

if savePlot=="plot" || savePlot=="all"; plotting="on"; 
else plotting="off"; end

% Best Sequence Signals
fig(1).results=figure('visible',plotting);
plot(delayAxis,20*log10(abs(cirModel./max(cirModel))),'k-','linewidth',4)
hold on
plot(delayAxis,20*log10(abs(CIR(4,:)./max(CIR(4,:)))),line(1),'Color',color(4,:),'linewidth',2)
plot(delayAxis,20*log10(abs(CIR(5,:)./max(CIR(5,:)))),line(1),'Color',color(5,:),'linewidth',2)
plot(delayAxis,20*log10(abs(CIR(nSignals,:)./max(CIR(nSignals,:)))),line(2),'Color',color(6,:),'linewidth',2)
legend ('CIR Model',sNames(4),sNames(5),sNames(nSignals))
axis([0 inf -inf 10])
    if language=="por"
        title(strcat('Resposta ao Impulso do Canal Invariante no Tempo',...
            " - Tamanho da Sequência: ", num2str(lenTxSignal))) 
        xlabel('Atraso (\mus)')
        ylabel('Amplitude (linear)') 
    else
        title(strcat('Time-Invariant Channel Impulse Response',...
            " - Sequence Length: ", num2str(lenTxSignal))) 
        xlabel('Delay (\mus)')
        ylabel('Amplitude (linear)') 
    end

% Some Sequence Signals
fig(2).results=figure('visible',plotting);
plot(delayAxis,20*log10(abs(cirModel./max(cirModel))),'k-','linewidth',4)
hold on
plot(delayAxis,20*log10(abs(CIR(1,:)./max(CIR(1,:)))),line(1),'Color',color(1,:),'linewidth',2)
plot(delayAxis,20*log10(abs(CIR(2,:)./max(CIR(2,:)))),line(1),'Color',color(2,:),'linewidth',2)
plot(delayAxis,20*log10(abs(CIR(3,:)./max(CIR(3,:)))),line(1),'Color',color(3,:),'linewidth',2)
plot(delayAxis,20*log10(abs(CIR(4,:)./max(CIR(4,:)))),'Color',color(4,:),'linewidth',2)
legend ('CIR Model',sNames(1),sNames(2),sNames(3),sNames(4))

    if language=="por"
        title(strcat('Resposta ao Impulso do Canal Invariante no Tempo',...
            " - Tamanho da Sequência: ", num2str(lenTxSignal))) 
        xlabel('Atraso (\mus)')
        ylabel('Amplitude (linear)') 
    else
        title(strcat('Time-Invariant Channel Impulse Response',...
            " - Sequence Length: ", num2str(lenTxSignal))) 
        xlabel('Delay (\mus)')
        ylabel('Amplitude (linear)') 
    end

%All Sequence Signals
fig(3).results=figure('visible',plotting);
plot(delayAxis,abs(cirModel),'k-','linewidth',4)
hold on
plot(delayAxis,abs(CIR(1,:)),line(1),'Color',color(1,:),'linewidth',2)
plot(delayAxis,abs(CIR(2,:)),line(1),'Color',color(2,:),'linewidth',2)
plot(delayAxis,abs(CIR(3,:)),line(1),'Color',color(3,:),'linewidth',2)
plot(delayAxis,abs(CIR(4,:)),line(1),'Color',color(4,:),'linewidth',2)
plot(delayAxis,abs(CIR(5,:)),line(1),'Color',color(5,:),'linewidth',2)
plot(delayAxis,abs(CIR(nSignals,:)),line(2),'Color',color(6,:),'linewidth',2)
legend ('CIR Model',sNames(1),sNames(2),sNames(3),sNames(4),sNames(5),sNames(8))

    if language=="por"
        title(strcat('Resposta ao Impulso do Canal Invariante no Tempo',...
            " - Tamanho da Sequência: ", num2str(lenTxSignal))) 
        xlabel('Atraso (\mus)')
        ylabel('Amplitude (linear)') 
    else
        title(strcat('Time-Invariant Channel Impulse Response',...
            " - Sequence Length: ", num2str(lenTxSignal))) 
        xlabel('Delay (\mus)')
        ylabel('Amplitude (linear)') 
    end

% RMSE CIR
fig(4).results=figure('visible',plotting);
semilogy(snrAxis,rmsError(1,:),lineRMSE(1),'Color',color(1,:),'linewidth',2)
hold on
semilogy(snrAxis,rmsError(2,:),lineRMSE(2),'Color',color(2,:),'linewidth',2)
semilogy(snrAxis,rmsError(3,:),lineRMSE(3),'Color',color(3,:),'linewidth',2)
semilogy(snrAxis,rmsError(4,:),lineRMSE(4),'Color',color(4,:),'linewidth',2)
semilogy(snrAxis,rmsError(5,:),lineRMSE(5),'Color',color(5,:),'linewidth',2)
semilogy(snrAxis,rmsError(nSignals,:),lineRMSE(6),'Color',color(6,:),'linewidth',2)
grid on;
legend (sNames(1),sNames(2),sNames(3),sNames(4),sNames(5),sNames(8))

title('RMSE Sounding CIR')
    if language=="por"
        title(strcat('RMSE da CIR Invariante no Tempo Estimada',...
            " - Tamanho da Sequência: ", num2str(lenTxSignal))) 
        xlabel('SNR')
        ylabel('RMSE') 
    else
        title(strcat('RMSE of Time-Invariant Estimated CIR',...
            " - Sequence Length: ", num2str(lenTxSignal))) 
        xlabel('SNR')
        ylabel('RMSE') 
    end

%% Save Figures
names=["BestSeq","SomeSeq","AllSeq","CirRMSE"];
if savePlot == "save" || savePlot=="all"        

    for i=1:4
    print(fig(i).results, strcat("../../../results/",simulOutputName,...
    "/figures/timeInvSounding/",...
    names(i),num2str(lenTxSignal),...
    "len"),'-dpng');

    saveas(fig(i).results, strcat("../../../results/",simulOutputName,...
    "/figures/timeInvSounding/",...
    names(i),num2str(lenTxSignal),...
    "len",".fig"));
    end
    
    if savePlot == "save"; close; close; close; close; end
end
end