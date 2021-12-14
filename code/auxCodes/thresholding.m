%##########################################################################
% INSTITUTION: Federal University of Rio Grande do Norte
% AUTHOR(S): J. Marcos Leal B. Filho
% TITLE: thresholding
% LAST UPDATE: 2020-04-07 at 20:00h
%##########################################################################
% PURPOSE: Thresholding for PDP and DopPDS. 
%
% USAGE: [validPDP, validDlyAxis, validDopPDS, validDopAxis, ...
%      thresholdDly, thresholdDop, sigmaDly, sigmaDop]=thresholding(PDP,...
%      DopPDS, delayAxis, nSamples, nMPC, fs, fm)
%
% INPUTS:        PDP = Average Power Delay Profile;
%             DopPDS = Average Doppler Power Density Spectrum;
%             delayAxis = Delay axis;
%              nSamples = Number of route samples;
%                  nMPC = Number of Multipath Components (MPC);
%                    fs = Vector of Different Sample Frequencies (Hz);
%                    fm = Maximum Doppler Shift (Hz);
%
% OUTPUTS:    validPDP = Valid Samples of Average Power Delay Profile;
%         validDlyAxis = Valid Samples of delay axis;
%          validDopPDS = Valid Samp. of Average Doppler Power Density Spec;
%         validDopAxis = Valid Samples of Doppler axis;
%         thresholdDly = PDP threshold;
%         thresholdDop = DopPDS threshold;
%             sigmaDly = PDP Standard Deviation;
%             sigmaDop = DopPDS Standard Deviation.
%              
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [validPDP, validDlyAxis, validDopPDS, validDopAxis, ...
    thresholdDly, thresholdDop, sigmaDly, sigmaDop]=thresholding(PDP,...
    DopPDS, delayAxis, nSamples, nMPC, fs, fm)

nDelays=length(delayAxis);  
% Doppler Axis (MHz)
dopplerAxis = ((-nSamples+1)/2:(nSamples-1)/2)*(fs/(nSamples-1));

% Threshold Delay
medianDly = median(PDP);
P=0.5*(1-nMPC/nDelays);
sigmaDly=medianDly/sqrt(log(1/(P^2)));
thresholdDly = medianDly + (medianDly - sigmaDly); % treshold

% Define valid Delay Samples
k=0; validPDP=zeros(1,nDelays); validDlyAxis=zeros(1,nDelays);
for ii=1:nDelays
   if PDP(ii) > thresholdDly % treshold
       k=k+1;
       validPDP(k)=PDP(ii);
       validDlyAxis(k)=delayAxis(ii);       
   end
end

% Threshold Doppler
medianDop = median(DopPDS);
P=0.5;
sigmaDop=medianDop/sqrt(log(1/(P^2)));

% The Doppler Threshold is based on Delay Threshold because there are to
% many Doppler sample components relating to noise samples. So it's not 
% to calculate its threshold based on the Doppler spectrum noise.
thresholdDop=10^((10*log10(thresholdDly*nDelays*nSamples))/10);

% Limiting Vector to maximum Doppler Shift
limitedDopPDS=DopPDS(abs(dopplerAxis)<=fm)';
limitedDopAxis=dopplerAxis(abs(dopplerAxis)<=fm);     
nLimitedSamples=length(limitedDopPDS);

% Define valid Doppler Samples
k=0; validDopPDS=zeros(1,nLimitedSamples); validDopAxis=zeros(1,...
                                                          nLimitedSamples);
for ii=1:nLimitedSamples
   if limitedDopPDS(ii) > thresholdDop % treshold
       k=k+1;
       validDopPDS(k)=limitedDopPDS(ii);
       validDopAxis(k)=limitedDopAxis(ii);       
   end
end

end