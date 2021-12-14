function sequenceFZC=genFrankZadoffChu(N)

rootOrder=23;

for ii=0:N-1
    if mod(N,2)==0
        sequenceFZC(ii+1)=exp(-j*pi*rootOrder*(ii^2)/N);
    else
        sequenceFZC(ii+1)=exp(-j*pi*rootOrder*ii*(ii+1)/N);
    end    
end

end