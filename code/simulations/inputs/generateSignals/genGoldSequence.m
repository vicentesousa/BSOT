function [gdSequence] = genGoldSequence(N)
% Polinomio Gerador: P(x)=x^11+x^9+1
switch N
    case 2047
GDgen=comm.GoldSequence('FirstPolynomial',       [1 0 0 0 0 0 0 0 0 1 0 1], ...
                      'FirstInitialConditions',  [0 0 0 0 0 0 0 0 0 0 1], ...
                      'SecondPolynomial',        [1 0 0 1 0 0 1 0 0 1 0 1], ...
                      'SecondInitialConditions', [0 0 0 0 0 0 0 0 0 0 1], ...
                      'SamplesPerFrame',    N);        
    case 1023
GDgen=comm.GoldSequence('FirstPolynomial',       [1 0 0 0 0 0 0 1 0 0 1], ...
                      'FirstInitialConditions',  [0 0 0 0 0 0 0 0 0 1], ...
                      'SecondPolynomial',        [1 0 1 0 0 0 0 1 1 0 1], ...
                      'SecondInitialConditions', [0 0 0 0 0 0 0 0 0 1], ...
                      'SamplesPerFrame',    N);
    case 511
GDgen=comm.GoldSequence('FirstPolynomial',       [1 0 0 0 0 1 0 0 0 1], ...
                      'FirstInitialConditions',  [0 0 0 0 0 0 0 0 1], ...
                      'SecondPolynomial',        [1 0 0 1 0 1 1 0 0 1], ...
                      'SecondInitialConditions', [0 0 0 0 0 0 0 0 1], ...
                      'SamplesPerFrame',    N);                  
    case 255
%Aproximation - it doesn't generate polynomials with "n=8" (2^n=256, n=8)
GDgen=comm.GoldSequence('FirstPolynomial',       [1 0 1 1 1 0 0 0 1], ...
                      'FirstInitialConditions',  [0 0 0 0 0 0 0 1], ...
                      'SecondPolynomial',        [1 0 1 1 0 0 1 1 1], ...
                      'SecondInitialConditions', [0 0 0 0 0 0 0 1], ...
                      'SamplesPerFrame',    N);
    case 127
GDgen=comm.GoldSequence('FirstPolynomial',       [1 0 0 0 1 0 0 1], ...
                      'FirstInitialConditions',  [0 0 0 0 0 0 1], ...
                      'SecondPolynomial',        [1 0 0 0 1 1 1 1], ...
                      'SecondInitialConditions', [0 0 0 0 0 0 1], ...
                      'SamplesPerFrame',    N);
    case 63
GDgen=comm.GoldSequence('FirstPolynomial',       [1 0 0 0 0 1 1], ...
                      'FirstInitialConditions',  [0 0 0 0 0 1], ...
                      'SecondPolynomial',        [1 1 0 0 1 1 1], ...
                      'SecondInitialConditions', [0 0 0 0 0 1], ...
                      'SamplesPerFrame',    N);
end

gdSequence=GDgen()';
end