%##########################################################################
% INSTITUTION: Federal University of Rio Grande do Norte
% AUTHOR(S): J. Marcos Leal B. Filho
% TITLE: channelTDL
% LAST UPDATE: 2020-04-07 at 20:00h
%##########################################################################
% PURPOSE: Generate COST207 Time-varitant Channel Impulse Response (IDSF) 
%          using Tapped Delay Line (TDL).
%
% USAGE: [channelModel]=channelTDL(fm, ts, delayAxis, nSamples, ...
%         dopFreqStep, delays, tapPower, gaussFilterMag, gaussFilterFreq)
%
% INPUTS:            fm = Maximum Doppler Shift (Hz);  
%                    ts = Sample time (s);
%             delayAxis = Delay axis;
%              nSamples = Number of route samples;
%           dopFreqStep = Frequency step in defining Doppler filters;
%                delays = Delays of each received MPC (us);
%              tapPower = Power of each received MPC (dB);
%        gaussFilterMag = Magnitudes for Gaussian Filter (dB);
%       gaussFilterFreq = Frequencies for Gaussian Filter (Hz).
%
% OUTPUTS: channelModel = Channel impulse response model.
%              
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [channelModel]=channelTDL(fm,ts,delayAxis, nSamples, ...
          dopFreqStep, delays, tapPower, gaussFilterMag, gaussFilterFreq) 

%% Define Indirect Parameters 
fs = 1/ts;                       % Sampling freq. (Hz)
nDelays=length(delayAxis);

%% Assemble Time-varitant Channel Impulse Response (IDSF)

% Adding floor 
snrDB = 100; % SNR in dB
snr = 10^(snrDB/10); % dB to linear scale
sigma=1/sqrt(2*snr);% Define noise variance, for Average Power=1.
channelModel = sigma*(ones(nSamples,nDelays)+ones(nSamples,nDelays)*j);

index=1;
for jj=1:nDelays
    
	if int64(delayAxis(jj)*1e6) == int64(delays(index)*1e6)
    
		% Defining time-series taps
		ray = sqrt(0.5)*complex(randn(1,nSamples),randn(1,nSamples));
		ray = ray*sqrt(10^(0.1*tapPower(index)));
		
		% Defining Dopppler filter
		if index==1 || index==2 || index==3
			dopFilter = clarkeJakesFilter(dopFreqStep, fs, fm);
		else
			dopFilter = gaussFilter(dopFreqStep, fs, fm, ...
				gaussFilterFreq(:,index), gaussFilterMag(index));
		end
		
		% Filtering taps with Doppler Spectra
		ray_filt = conv(ray,dopFilter); 

		% Remove extra samples after convolution
		len = length(dopFilter);  
		ray_filt = ray_filt(floor(len/2):length(ray_filt)-round(len/2));

		% Define Time-varitant Channel Impulse Response (IDSF)
		tapsIDSF(:,index) = ray_filt'; % Taps
		channelModel(:,jj) = tapsIDSF(:,index);

		index=index+1;    
    end
end

end