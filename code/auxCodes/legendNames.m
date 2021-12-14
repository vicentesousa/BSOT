function legendName=legendNames(signalNames, nSignals, language)
for ii=1:nSignals
    if language=="por"
        switch signalNames(ii)
            case "SEQN-RD"
                legendName(ii)="Sequência Aleatória";
            case "SEQN-PN"   
                legendName(ii)="Sequência-m";
            case "SEQN-GD"
                legendName(ii)="Sequência Gold";
            case "SEQN-KA"
                legendName(ii)="Sequência Kasami";
            case "SEQN-ZC"
                legendName(ii)="Sequência ZC";
            case "SEQN-Ga"
                legendName(ii)="Sequência Golay A";
            case "SEQN-Gb"
                legendName(ii)="Sequência Golay B";
            case "SEQN-Gy"
                legendName(ii)="Sequência Golay";
            otherwise
                disp('Erro na inserção da nomenclatura do sinal de sondagem.')
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