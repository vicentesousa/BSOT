function rxNoiseSignal=addAwgn(txSignal, rxSignal, snrdB)

lenRxSig = length(rxSignal);
sPower = (rxSignal*rxSignal')/lenRxSig; 
snr = 10^(snrdB/10); % dB to linear scale

if sum(imag(txSignal))==0
sigma=sqrt(sPower/(snr));
noise = randn(1, lenRxSig);
else
sigma=sqrt(sPower/(2*snr));
noise = randn(1, lenRxSig) + j*randn(1,lenRxSig);
end
rxNoiseSignal=rxSignal+sigma*noise;
end