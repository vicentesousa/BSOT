%##########################################################################
% INSTITUTION: Federal University of Rio Grande do Norte
% AUTHOR(S): J. Marcos Leal B. Filho
% TITLE: calculateCondensedParam
% LAST UPDATE: 2020-04-07 at 20:00h
%##########################################################################
% PURPOSE: Calculate Channel Functions.
%
% USAGE: [PDP,DopPDS,DDSF,SF, TCF, FCF]=calculateFunctions(IDSF, ...
%                                           nDelays, nSamples) 
%
% INPUTS:      IDSF = Input Delay Spread Function;
%          nSamples = Number of time samples;
%           nDelays = length of dalay axis.
%
% OUTPUTS:   PDP = Average Power Delay Profile;
%         DopPDS = Average Doppler Power Density Spectrum;
%           DDSF = Delay Doppler Spread Function;
%             SF = Scattering Function;
%            TCF = Time Correlation Function;
%            FCF = Frequecy Correlation Function.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [PDP,DopPDS,DDSF,SF, TCF, FCF]=calculateFunctions(IDSF,nDelays,...
                                                           nSamples)   
                                                                                                                          
% Delay Doppler Spread Function (DDSF) - From IDSF 
DDSF=zeros(nSamples,nDelays);
for jj=1:nDelays          
    DDSF(:,jj) = fftshift((fft(IDSF(:,jj))));
end

% Scattering Function (SF) - From DDSF
SF = abs(DDSF).^2; 

% Average Power Delay Profile (PDP) - From SF
PDP= sum(SF)./(nSamples)./(nSamples);

% Average Doppler Power Spectral Density (DopPDS) - From SF
DopPDS = sum(SF,2)./(nDelays).*(nDelays);  %avDopPDS from SF  

% Time Correlation Function (TCF) - From DopPDS
TCF = fftshift(ifft(DopPDS))./(nSamples); 

% Frequency Correlation Function (FCF) - From PDP
FCF = fftshift(fft(PDP));

end