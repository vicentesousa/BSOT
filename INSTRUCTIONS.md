# INSTITUTION: Federal University of Rio Grande do Norte
# AUTHOR(S): J. Marcos Leal B. Filho
# PURPOSE: Campaign for Wideband Channel Sounding Simulations using sequence signals and
	   cross correlation at the receiver.

## Features

- Generate a TDL input Channel Model;
- Generate transmitting signals with
  - Ramdom sequence
  - Pseudo-Noise (PN) sequence
  - Kasami sequence
  - Gold sequence
  - Frank-Zadoff-Chu sequence
  - Golay Sequence
- Monte Carlo Simulation of signal propagation and receiving (channel sounding)
- Estimate the Input Delay Spread Function (IDSF)
- Sounding Processing
  - Calculate the RMSE of between Channel Model and estimated IDSF's
  - Calculate the Mean Average Delay and Doppler Spread of the channel
  - Calculate the RMSE of the Mean Average Delay and Doppler Spread
- Simulation Plots:
  - Mean Average Delay and Doppler Spread
  - IDSF RMSE for differente SNR
  - Delay and Doppler Spread RMSE results: 
    - For different signal lengths / SNR
    - For different sample rates / SNR
    - For different quantity of repetitions / SNR

## Getting Started: Run 'campaign.m' in /code directory.

The examples and simulation scripts are in /code/simulations.

## Simulation Process Fluxogram: /data/simulationFluxogram.png

## Directories/Functions Map: /data/widebandChannelSounding.png

## License: MIT License