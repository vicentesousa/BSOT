function [meanData]=calculateMeanErrorIDSF(rmsError, repMontCarlo)

nDB=length(rmsError(1).rmseIDSF(1,:));
rep1=ceil(repMontCarlo/10); rep2=ceil(repMontCarlo/2); rep3=repMontCarlo;

for m=1:nDB
    meanData(1).meanErrorIDSF(:,m)=[mean(rmsError(1).rmseIDSF(1:rep1,m)); ...
          mean(rmsError(1).rmseIDSF(1:rep2,m)); ...
          mean(rmsError(1).rmseIDSF(1:rep3,m))];

end

end