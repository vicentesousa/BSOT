function legendName=legendNames(signalNames, nSignals, language)
for ii=1:nSignals
    if language=="por"
        switch signalNames(ii)
            case "SEQN-RD"
                legendName(ii)="Sequ�ncia Aleat�ria";
            case "SEQN-PN"   
                legendName(ii)="Sequ�ncia-m";
            case "SEQN-GD"
                legendName(ii)="Sequ�ncia Gold";
            case "SEQN-KA"
                legendName(ii)="Sequ�ncia Kasami";
            case "SEQN-ZC"
                legendName(ii)="Sequ�ncia ZC";
            case "SEQN-Ga"
                legendName(ii)="Sequ�ncia Golay A";
            case "SEQN-Gb"
                legendName(ii)="Sequ�ncia Golay B";
            case "SEQN-Gy"
                legendName(ii)="Sequ�ncia Golay";
            otherwise
                disp('Erro na inser��o da nomenclatura do sinal de sondagem.')
        end
    else
        switch signalNames(ii)
            case "SEQN-RD"
                legendName(ii)="Random Sequence";
            case "SEQN-PN"   
                legendName(ii)="m-Sequence";
            case "SEQN-GD"
                legendName(ii)="Gold Sequence";
            case "SEQN-KA"
                legendName(ii)="Kasami Sequence";
            case "SEQN-ZC"
                legendName(ii)="FZC Sequence";
            case "SEQN-Ga"
                legendName(ii)="Golay Sequence A";
            case "SEQN-Gb"
                legendName(ii)="Golay Sequence B";
            case "SEQN-Gy"
                legendName(ii)="Golay Sequence";
            otherwise
                disp('Error: the sounding signal names are incorrect.')
        end
    end
end