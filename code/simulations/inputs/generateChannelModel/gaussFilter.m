function [filterIR]=gaussFilter(freqStep,fs,fm, ...
    gaussFilterFreq, gaussFilterMag)

fr11=gaussFilterFreq(1,1)*fm; fr12=gaussFilterFreq(2,1)*fm; 
fr21=gaussFilterFreq(3,1)*fm; fr22=gaussFilterFreq(4,1)*fm;

% Time Axis
timeAxis=([0:ceil(fs/freqStep)-1]-round(((fs)/freqStep)/2))*(1/fs);

% Filter Inpulse Response 
filterIR=sqrt(2*pi)*fr12*exp(-2*(pi*fr12*timeAxis).^2).*...
    exp(j*2*pi*fr11.*timeAxis)+(10^(0.2*gaussFilterMag))*sqrt(2*pi)*fr22...
    *exp(-2*(pi*fr22*timeAxis).^2).*exp(j*2*pi*fr21.*timeAxis);

filterIR=filterIR'/sqrt(sum(abs(filterIR).^2)); % Normalizing Energy 
end

