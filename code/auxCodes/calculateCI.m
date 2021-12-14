function [vtError] = calculateCI(vtMean, vtStd, repMontCarlo)

if  repMontCarlo > 30
    vtSig = vtStd/sqrt(repMontCarlo); % sample standard deviation of the mean
    alphao2 = 0.05/2;      % Confidence interval of 95%
    vtConfInter = [vtMean + norminv(alphao2)*vtSig ;...
        vtMean - norminv(alphao2)*vtSig  ];
    vtError = norminv(alphao2)*vtSig;
else
    vtSig = vtStd/sqrt(repMontCarlo); % sample standard deviation of the mean
    alphao2 = 0.05/2;      % Confidence interval of 95%
    level = repMontCarlo-1;
    vtConfInter = [vtMean + tinv(alphao2,level)*vtSig ;...
        vtMean - tinv(alphao2,level)*vtSig  ];
    vtError = tinv(alphao2,level)*vtSig;    
end

end