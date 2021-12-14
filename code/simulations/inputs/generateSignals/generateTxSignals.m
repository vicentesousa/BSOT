function [txSignal,xMod]=generateTxSignals(N, signalNames, simulOutputName, varargin)
nSignals=length(signalNames);

defaultSimulName=' ';

inputs = inputParser;
addRequired(inputs, 'N');
addRequired(inputs, 'signalNames');
addOptional(inputs, 'simulOutputName', defaultSimulName);

parse(inputs, N, signalNames, varargin{:});

%% Generate Sequence
sequences=generateSequences(N, signalNames);

%% BPSK Modulation
for kk=1:nSignals
if signalNames(kk)~="SEQN-ZC"
xMod(kk,:) = qammod(sequences(kk,:),2);

% I/Q components
txSignal(kk,:) = xMod(kk,:); % real signals
else
txSignal(kk,:) = sequences(kk,:); % sequence FZC is not modulated
end
end 


%% Output Signals
if (nargin > 2)
for kk=1:nSignals
  tx_I=real(txSignal(kk,:));
  tx_Q=imag(txSignal(kk,:));
  dlmwrite(strcat("../results/",simulOutputName,"/inputData/txSignals/",...
        signalNames(kk),'_I_',num2str(N),'.txt'),tx_I');
  dlmwrite(strcat("../results/",simulOutputName,"/inputData/txSignals/",...
        signalNames(kk),'_Q_',num2str(N),'.txt'),tx_Q');
end
end

end