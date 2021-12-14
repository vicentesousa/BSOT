%##########################################################################
% INSTITUTION: Federal University of Rio Grande do Norte
% AUTHOR(S): J. Marcos Leal B. Filho
% TITLE: calculateDelayDoppler
% LAST UPDATE: 2020-04-07 at 20:00h
%##########################################################################
% PURPOSE: Calculate Channel Condensed Parameters: RMS Delay, RMS Doppler.
%
% USAGE: [rmsDelay,rmsDoppler, PDP, DopPDS, thresholdDly, ...
%         thresholdDop,sigmaDly,sigmaDop]=calculateDelayDoppler(IDSF,...
%         delayAxis, nMPC, fm, fs, nSamples)
%
% INPUTS:          IDSF = Input Delay Spread Function;
%             delayAxis = Delay axis;
%                  nMPC = Number of Multipath Components (MPC);
%                    fm = Maximum Doppler Shift (Hz);
%                    fs = Vector of Different Sample Frequencies (Hz);       
%              nSamples = Number of route samples.
%
% OUTPUTS:  rmsDelay = RMS Delay Spread;
%         rmsDoopler = RMS Doppler Spread;
%                PDP = Average Power Delay Profile;
%             DopPDS = Average Doppler Power Density Function;
%       thresholdDly = PDP threshold;
%       thresholdDop = DopPDS threshold;
%           sigmaDly = PDP Standard Deviation;
%           sigmaDop = DopPDS Standard Deviation.
%              
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [rmsDelay,rmsDoppler, PDP, DopPDS, thresholdDly, ...
    thresholdDop,sigmaDly,sigmaDop]=calculateDelayDoppler(IDSF,...
    delayAxis, nMPC, fm, fs, nSamples)

nDelays=length(delayAxis); % length of delay axis  

% Calculate Average PDP / Average DopPDS
[PDP,DopPDS]=calculateFunctions(IDSF, nDelays, nSamples);  

% Thresholding to Obtain Valid Samples
[validPDP, validDlyAxis, validDopPDS, validDopAxis, thresholdDly, ...
    thresholdDop, sigmaDly, sigmaDop]=thresholding(PDP, DopPDS, ...
    delayAxis, nSamples, nMPC, fs, fm);

% Calculate Delay Spread (us)
meanDelays = sum(validPDP.*validDlyAxis)/sum(validPDP);
rmsDelay = sqrt((sum((validDlyAxis.^2).*validPDP)/sum(validPDP))-...
           (meanDelays).^2);

% Calculate Doopler Spread (Hz) 
meanDoppler = sum(validDopPDS.*abs(validDopAxis))/sum(validDopPDS);
rmsDoppler = sqrt((sum((abs(validDopAxis).^2).*validDopPDS)/...
             sum(validDopPDS))-(meanDoppler).^2);

         
% In case of no valid Multipath Component aviable
if length(validDlyAxis) <= 1
    rmsDelay=0;
    disp(strcat(num2str(nSamples)," Samples"));
    disp(strcat("RMS Doppler: ",num2str(rmsDelay)));
    disp('Invalid RMS Delay: There is no valid PDP samples');
end                

% In case of no valid Doppler sample aviable
if length(validDopAxis) <= 1
    rmsDoppler=0;
    disp(strcat(num2str(nSamples)," Samples"));
    disp(strcat("RMS Doppler: ",num2str(rmsDoppler)));
    disp('Invalid RMS Doopler: There is no valid DopPDP samples');
end

end
