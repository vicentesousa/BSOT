
function [filterIR]=clarkeJakesFilter(freqStep, fs, fm)

freqAxis=[freqStep/2:freqStep:round(fs/2)];

amp=[];
for ii=1:length(freqAxis)
    if abs(freqAxis(ii))< fm-2
        auxAmp=1/sqrt(1-(freqAxis(ii)/fm).^2);
        amp=[amp; auxAmp];
    else
        amp=[amp; 0]; 
    end
end

% Filter Frequency Response
amp = [flip(amp); (amp)];

% Filter Impulse Response
filterIR=real(fftshift(ifft(fftshift(amp)))); 
filterIR=filterIR/sqrt(sum(abs(filterIR).^2));  % Normalizing Energy 
end
