function plotSignalsAnalysis(savePlot, choosePlot, language, simulOutputName, ...
    signalNames, lenTxSignal, txSignal, aCorr, nDelays)

nSignals=length(signalNames);
sNames=legendNames(signalNames, nSignals, language);  % Legend Names

% Sequences
if choosePlot=="seq" || choosePlot=="all"
plotSequences(savePlot, language, simulOutputName, ...
    signalNames, sNames, lenTxSignal, txSignal, aCorr)
end

% Sequence Autocorrelation
if choosePlot=="acorr" || choosePlot=="all"
plotSeqAutoCorr(savePlot, language, simulOutputName, ...
    signalNames, sNames, lenTxSignal, aCorr)
end

% Sequence Autocorrelation Zoom
if choosePlot=="acZoom" || choosePlot=="all"
plotSeqAcZoom(savePlot, language, simulOutputName, ...
    signalNames, sNames, lenTxSignal, aCorr, nDelays)
end

% Sequence Autocorrelation Zoom Conjugated
if choosePlot=="acZoomConj" || choosePlot=="all"
plotSeqAcConj(savePlot, language, simulOutputName, ...
    signalNames, sNames, lenTxSignal, aCorr, nDelays)
end

end