%##########################################################################
% INSTITUTION: Federal University of Rio Grande do Norte
% AUTHOR(S): J. Marcos Leal B. Filho
% TITLE: inputParameters
% LAST UPDATE: 2020-04-07 at 20:00h
%##########################################################################
% PURPOSE: Define simulation input parameters.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fprintf(' #Channel Sounding Simulator \n')
fprintf(' Loading Parameters...')

%% General Parameters
% Input Sounding Signal Names
signalNames=["SEQN-RD"];

% Sounding Processing Signal Names
proSignalNames=["SEQN-RD","SEQN-KA","SEQN-GD","SEQN-PN","SEQN-ZC","SEQN-Gy"];

% Plotting Signal Name
plotSignalName=["SEQN-Gy"];%set to choose the main signal through the plots

% Plotting Signal Length
plotSignalLen=1024; %set to choose the length of the signal through plots

% Plots language
language="por"; 

nSignals=length(signalNames); %Quantity of signals

%% Simulation parameters
repMontCarlo=100;                     % Monte Carlo Repetitions
snrMin=-20; snrMax=40; snrStep=5;   % SNR valors (dB)
snrs=snrMin:snrStep:snrMax;         % SNR vector (dB) 
lenTxSignals=[1024, 512, 256];      % Signals Lengths

%% Channel Model Parameters
modelNsamples=500;          % Number of channel model samples (even number)
fc = 700;                   % Carrier Frequency (MHz)
V = 20;                     % Mobile speed (m/s)
F = 8;                      % Sampling: Fraction of wavelength 
B = 20;                     % Bandwidth (MHz)
cc = 300;                   % Ligth Speed (10e6 m/s)

%% Resultant Parameterers
lambdac = cc/fc;           % Wavelength (m)
kc = 2*pi/lambdac;          % Wave number 
delayStep = 1/(B*1e6);      % Delay discretization setep (s)
fm = V/lambdac;             % Maximum Doppler Shift (Hz)
hopMaxDelay=10;             % Hoped Maximum Delay (mcs)
ts = (lambdac/F)/V;         % Sampling time (s)
tTotal = modelNsamples*ts;  % Total Sounding time (s)

%% Sounding Parameters
nSamples(1) = round(modelNsamples/1); % Number of channel sounding samples
nSamples(2) = round(modelNsamples/2); % Number of channel sounding samples
nSamples(3) = round(modelNsamples/4);
nSamples(4) = round(modelNsamples/8); % Number of channel sounding samples
fs = [1/ts, 1/(2*ts), 1/(4*ts), 1/(8*ts)];  % Sampling freq. (Hz)

%% COST207 Parameters
% Taps delays (mcs)
delays = [0; 0.2; 0.4; 0.8; 1.6; 2.2; 3.2; 5.0; 6.0; 7.2; 8.2; 10.0];
nMPC=length(delays); % Number of Multipath Components
maxDelay=max(delays); % Maximum Delay
% Taps powers (dB)
tapPower = [-7; -3; -1; 0; -2; -6; -7; -1; -2; -7; -10; -15]; 
% Magnitudes for Gaussian Filter (dB)
gaussFilterMag = [0, 0, 0, -10, -10, -15, -15, -15, -15, -15, -15, -15]; 
% Frequencies for Gaussian Filter (Hz)
gaussFilterFreq = [0, 0, 0, -0.8,  -0.8, 0.7, 0.7, 0.7, 0.7, 0.7, 0.7, ...
    0.7; 0, 0, 0, 0.05, 0.05, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1; ...
0, 0, 0, 0.4, 0.4, -0.4, -0.4, -0.4, -0.4, -0.4, -0.4, -0.4; ...
0, 0, 0, 0.1, 0.1, 0.15, 0.15, 0.15, 0.15, 0.15, 0.15, 0.15];
dopFreqStep = 1;            % Frequency step in defining Doppler filters

%% Axes
delayAxis = [0:(delayStep*1e6):maxDelay]; %delay axis (\mus)
nDelays=length(delayAxis);  % Length of delay axis
timeAxis = ts.*[0:nSamples(1)-1];

fprintf(' Completed! \n')