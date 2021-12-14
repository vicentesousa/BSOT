function [sequences]=generateSequences(N, signalNames)
x_Ga=[0]; x_Gb=[0]; sequences=zeros(length(signalNames),N);
for kk=1:length(signalNames) 
    switch signalNames(kk)        
        case "SEQN-RD"         
            sequences(kk,1:end-1)=randi([0 1],1,N-1); % Random Sequence
        case "SEQN-PN"         
            sequences(kk,1:end-1)=genPnSequence(N-1); % PN Sequence
        case "SEQN-KA"
            sequences(kk,1:end-1)=genKasamiSequence(N-1); % Kasami Sequence
        case "SEQN-GD"
            sequences(kk,1:end-1)=genGoldSequence(N-1); % Gold Sequence
        case "SEQN-ZC"
            % FZC - Frank Zadoff Chu Sequence - Complex Signal (I/Q) 
            sequences(kk,1:end-1) = genFrankZadoffChu(N-1);
        case "SEQN-Ga"
            % Golay Sequences A
            if x_Ga==[0] [x_Ga,x_Gb] = genGolaySequence(N); end
            sequences(kk,:)=x_Ga;
        case "SEQN-Gb"
            % Golay Sequences B
            if x_Gb==[0] [x_Ga,x_Gb] = genGolaySequence(N); end
            sequences(kk,:)=x_Gb;
        otherwise
            disp('The transmitting signals names are incorrect.')                
    end
end

end