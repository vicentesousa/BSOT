clc; clear all; close all;

addpath(genpath('../../simulations'));
addpath(genpath('../../auxCodes'));

% Sequences Configuration 
signalNames=["SEQN-RD"; "SEQN-KA"; "SEQN-GD"; "SEQN-PN"; "SEQN-ZC";...
             "SEQN-Ga"; "SEQN-Gb"]; % Sequences Names
nSignals=length(signalNames); % quantity of signals
lenTxSignal=1024; % sequence length: 1024 / 512 / 256
nDelays=201; % Time-invariant CIR lenght

% Plot Configurations
simulOutputName="auxSimulation0"; % set for naming output simulation data
savePlot="all"; % "save"=Just save/"plot"=Just plot/"all"=Save/Plot / "off"
language="por"; % Plot Language: "por"=Portuguese / "eng"=English
choosePlot="acorr";% "all" / "seq" / "acorr" / "acZoom" / "acZoomConj"  

% Make Folders
makeFoldersAux(simulOutputName);

%% Generate Sequences (Tx Signals)
[txSignal,xMod]=generateTxSignals(lenTxSignal, signalNames);    

%% Sequences Autocorrelations
Ga=0; Gb=0;
for kk=1:nSignals
if signalNames(kk)=="SEQN-ZC"
%aCorrAux(kk,:)=xcorr(xMod(kk,:));
aCorr(kk,:)=fftshift(ifft(fft(txSignal(kk,1:end-1)).*conj(fft(txSignal(kk,1:end-1)))))./(lenTxSignal-1);

else if signalNames(kk)=="SEQN-Ga" || signalNames(kk)=="SEQN-Gb"
aCorrAux(kk,:)=fftshift(ifft(fft(xMod(kk,:)).*conj(fft(xMod(kk,:)))))./lenTxSignal;
aCorr(kk,:)=aCorrAux(kk,2:end);
    else
        
aCorr(kk,:)=fftshift(ifft(fft(xMod(kk,1:end-1)).*conj(fft(xMod(kk,1:end-1)))))./(lenTxSignal-1);

end
end
        
if signalNames(kk)=="SEQN-Ga" Ga=kk; end
if signalNames(kk)=="SEQN-Gb" Gb=kk; end
end   
aCorr(kk+1,:)=abs(aCorr(Ga,:)+aCorr(Gb,:));

if Ga~=0 && Gb~=0
signalNames=[signalNames; "SEQN-Gy"]; % Sequences Names
end


%% Plots
if savePlot=="off"
else
plotSignalsAnalysis(savePlot, choosePlot, language, simulOutputName,...
    signalNames, lenTxSignal, txSignal, aCorr, nDelays)
end

