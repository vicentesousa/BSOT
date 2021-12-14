function [meanDlyDop]=calculateMeanDelayDoppler(dlyDop, nSamps, repMontCarlo)

nDB=length(dlyDop(1).rmsDelay(1,:));
rep1=ceil(repMontCarlo/10); rep2=ceil(repMontCarlo/2); rep3=repMontCarlo;


for n=1:nSamps
    for m=1:nDB

    % Calculate the mean of valid rms Delay values
    meanDlyDop(n).meanDly(:,m)=[mean(dlyDop(n).rmsDelay(find(dlyDop(n).rmsDelay(1:rep1,m)~=0),m)); ...
                                mean(dlyDop(n).rmsDelay(find(dlyDop(n).rmsDelay(1:rep2,m)~=0),m)); ...
                                mean(dlyDop(n).rmsDelay(find(dlyDop(n).rmsDelay(1:rep3,m)~=0),m))];

    % Calculate the mean of valid rms Doppler values
    meanDlyDop(n).meanDop(:,m)=[mean(dlyDop(n).rmsDoppler(find(dlyDop(n).rmsDoppler(1:rep1,m)~=0),m)); ...
                                mean(dlyDop(n).rmsDoppler(find(dlyDop(n).rmsDoppler(1:rep2,m)~=0),m)); ...
                                mean(dlyDop(n).rmsDoppler(find(dlyDop(n).rmsDoppler(1:rep3,m)~=0),m))];

    end
end
end
