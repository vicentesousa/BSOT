function plotSequences(savePlot, language, simulOutputName, ...
    signalNames, sNames, lenTxSignal, txSignal, aCorr)

if savePlot=="plot" || savePlot=="all"; ploting="on"; 
else ploting="off"; end

nSignals=length(txSignal(:,1));
color=[0, 0.6, 0.6];

%% All Sequences
Ga=0; Gb=0; GaGb=0;
for kk=1:nSignals
fig(kk).results=figure('visible',ploting);
subplot(4,1,1)
plot(real(txSignal(kk,:)),'Color',color(1,:))
if language=="por"
title(strcat("Sequ�ncia ", sNames(kk),' - In-phase',...
    " - Tamanho da Sequ�ncia: ", num2str(lenTxSignal))) 
xlabel('Amostras')
ylabel('Amplitude')
else
title(strcat(sNames(kk),' Sequence - In-phase',...
    " - Sequence Length: ", num2str(lenTxSignal))) 
xlabel('Samples')
ylabel('Amplitude') 
end
axis([-inf inf  -1.5 1.5])

subplot(4,1,2)
plot(imag(txSignal(kk,:)),'Color',color(1,:))
if language=="por"
title(strcat("Sequ�ncia ", sNames(kk),' - Quadratura',...
    " - Tamanho da Sequ�ncia: ", num2str(lenTxSignal))) 
xlabel('Amostras')
ylabel('Amplitude')
else
title(strcat(sNames(kk),' Sequence - Quadrature',...
    " - Sequence Length: ", num2str(lenTxSignal))) 
xlabel('Samples')
ylabel('Relative') 
end
axis([-inf inf  -1.5 1.5])

subplot(4,1,3)
plot(10*log10(abs(fftshift(fft(txSignal(kk,:))))),'Color',color(1,:))
if language=="por"
title(strcat("Sequ�ncia ", sNames(kk),' - Spectro de Frequ�ncia',...
    " - Tamanho da Sequ�ncia: ", num2str(lenTxSignal))) 
xlabel('Amostras')
ylabel('Magnitude (dB)')
else
title(strcat(sNames(kk),' Sequence - Frequency Spectrum',...
    " - Sequence Length: ", num2str(lenTxSignal))) 
xlabel('Samples')
ylabel('Magnitude (dB)') 
end
axis([-inf inf  -60 30])

subplot(4,1,4)
if signalNames(kk)=="SEQN-ZC" 
plot(abs(aCorr(kk,:)),'Color',color(1,:))
else
plot((aCorr(kk,:)),'Color',color(1,:))
end
if language=="por"
title(strcat("Sequ�ncia ", sNames(kk),' - Autocorrela��o',...
    " - Tamanho da Sequ�ncia: ", num2str(lenTxSignal))) 
xlabel('Amostras')
ylabel('Amplitude Relativa')
else
title(strcat(sNames(kk),' Sequence - Autocorrelation',...
    " - Sequence Length: ", num2str(lenTxSignal))) 
xlabel('Samples')
ylabel('Relative Amplitude') 
end
axis([-inf inf  -0.1 1.1])

if signalNames(kk)=="SEQN-Ga" Ga=kk; end
if signalNames(kk)=="SEQN-Gb" Gb=kk; end
end

if Ga~=0 && Gb~=0
%% Golay Sequence A and B
fig(kk+1).results=figure('visible',ploting);
subplot(4,2,1)
plot(real(txSignal(Ga,:)),'Color',color(1,:))
if language=="por"
title('Sequ�ncia Golay A - In-phase') 
xlabel('Amostras')
ylabel('Amplitude')
else
title('Sequ�ncia Golay A - In-phase')
xlabel('Samples')
ylabel('Amplitude') 
end
axis([-inf inf  -1.5 1.5])

subplot(4,2,2)
plot(real(txSignal(Gb,:)),'Color',color(1,:))
if language=="por"
title('Sequ�ncia Golay B - In-phase') 
xlabel('Amostras')
ylabel('Amplitude')
else
title('Sequ�ncia Golay B - In-phase')
xlabel('Samples')
ylabel('Amplitude') 
end
axis([-inf inf  -1.5 1.5])

subplot(4,2,3)
plot(10*log10(abs(fftshift(fft(txSignal(Ga,:))))),'Color',color(1,:))
if language=="por"
title('Sequ�ncia Golay A - Spectro de Frequ�ncia')
xlabel('Amostras')
ylabel('Magnitude (dB)')
else
title('Golay Sequence A - Frequency Spectrum')
xlabel('Samples')
ylabel('Magnitude (dB)') 
end
axis([-inf inf  -60 30])

subplot(4,2,4)
plot(10*log10(abs(fftshift(fft(txSignal(Gb,:))))),'Color',color(1,:))
if language=="por"
title('Sequ�ncia Golay B - Spectro de Frequ�ncia')
xlabel('Amostras')
ylabel('Magnitude (dB)')
else
title('Golay Sequence B - Frequency Spectrum') 
xlabel('Samples')
ylabel('Magnitude (dB)') 
end
axis([-inf inf  -60 30])

subplot(4,2,5)
plot(abs(aCorr(Ga,:)),'Color',color(1,:))
if language=="por"
title('Sequ�ncia Golay A - Autocorrela��o')
xlabel('Amostras')
ylabel('Amplitude Relativa')
else
title('Sequ�ncia Golay A - Autocorrelation')
xlabel('Samples')
ylabel('Relative Amplitude') 
end
axis([-inf inf  -0.1 1.1])

subplot(4,2,6)
plot(abs(aCorr(Gb,:)),'Color',color(1,:))
if language=="por"
title('Sequ�ncia Golay B - Autocorrela��o')
xlabel('Amostras')
ylabel('Amplitude Relativa')
else
title('Sequ�ncia Golay B - Autocorrelation')
xlabel('Samples')
ylabel('Relative Amplitude') 
end
axis([-inf inf  -0.1 1.1])

subplot(4,2,[7,8])
plot(abs(aCorr(Ga,:)+aCorr(Gb,:))/2,'Color',color(1,:))
if language=="por"
title('Autocorrela��o da Seq. A + Autocorrela��o da Seq. B')
xlabel('Amostras')
ylabel('Amplitude Relativa')
else
title('Autocorrelation of Seq. A + Autocorrelation of Seq. B')
xlabel('Samples')
ylabel('Relative Amplitude') 
end
axis([-inf inf  -0.1 1.1])

GaGb=1;
end

%% Save Figures
if savePlot == "save" || savePlot=="all"        

    for i=1:nSignals+GaGb
    print(fig(i).results, strcat("../../../results/",simulOutputName,...
    "/figures/signalAnalysis/sequences/",...
    signalNames(i),"_",num2str(lenTxSignal),...
    "len"),'-dpng');

    saveas(fig(i).results, strcat("../../../results/",simulOutputName,...
    "/figures/signalAnalysis/sequences/",...
    signalNames(i),"_",num2str(lenTxSignal),...
    "len",".fig"));
    end
    
    if savePlot == "save"; close; close; end
end
end