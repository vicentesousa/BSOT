function [meanData]=calculateMeanError(rmsError, nSamps, repMontCarlo)

nDB=length(rmsError(1).rmsDlyError(1,:));
rep1=ceil(repMontCarlo/10); rep2=ceil(repMontCarlo/2); rep3=repMontCarlo;

for n=1:nSamps
    for m=1:nDB

    meanData(n).meanErrorDly(:,m)=[mean(rmsError(n).rmsDlyError(1:rep1,m)); ...
                  mean(rmsError(n).rmsDlyError(1:rep2,m)); ...
                  mean(rmsError(n).rmsDlyError(1:rep3,m))];      

    meanData(n).meanErrorDop(:,m)=[mean(rmsError(n).rmsDopError(1:rep1,m)); ...
                  mean(rmsError(n).rmsDopError(1:rep2,m)); ...
                  mean(rmsError(n).rmsDopError(1:rep3,m))]; 

    end
end
end