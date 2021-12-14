function [Ga,Gb] = genGolaySequence(N)
Ga=1; Gb=1;
m=log2(N);
for i=1:m
Ga2=Ga;    
Ga=[-Gb -Ga];    
Gb=[Gb -Ga2];  
end

Ga=Ga/2+0.5;
Gb=Gb/2+0.5;
end