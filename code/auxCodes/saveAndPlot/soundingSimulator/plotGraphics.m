function plotGraphics(savePlot, choosePlot, language, modelNsamples, repMontCarlo,...
                       lenTxSignals, plotSignalLen, plotSignalName, simulOutputName)
                   
switch savePlot
    
    case "save" 
        fprintf('\n #Saving Grafics...');
    case "plot" 
        fprintf('\n #Plotting Grafics...'); 
    case "all" 
        fprintf('\n #Saving and Plotting Grafics...'); 
    otherwise
        fprintf('\n #Save and Plot off.');
end
        
iLength=find(lenTxSignals==plotSignalLen);
if choosePlot=="all" || choosePlot=="rmseBar"        
% Plot Delay / Doppler / IDSF RSME Bar
plotRmseBar(savePlot, language, modelNsamples, repMontCarlo, ...
                lenTxSignals(iLength), plotSignalName, simulOutputName);
end  
if choosePlot=="all" || choosePlot=="rep"
% Plot RMSE for a Epecific Signal and Different Number of Repetitions
plotRMSEdRep(savePlot, language, modelNsamples, repMontCarlo, ...
                lenTxSignals(iLength), plotSignalName, simulOutputName);  
end
if choosePlot=="all" || choosePlot=="len"
% Plot RMSE for a Epecific Signal and Different Signal Lengths
plotRMSEdLen(savePlot, language, modelNsamples, repMontCarlo, ...
                lenTxSignals, plotSignalName, simulOutputName); 
end
if choosePlot=="all" || choosePlot=="samp"
% Plot RMSE for a Epecific Signal and Different Samples 
plotRMSEdSamp(savePlot, language, modelNsamples, repMontCarlo, ...
                 lenTxSignals(iLength), plotSignalName, simulOutputName); 
end
if choosePlot=="all" || choosePlot=="rmse"            
% Plot RMSE of Delay, Doppler and IDSF for all Signals
plotRMSE(savePlot, language, modelNsamples, repMontCarlo, ...
            lenTxSignals(iLength), simulOutputName);
end
if choosePlot=="all" || choosePlot=="dlydop"        
% Plot Delay and Doppler for all Signals
plotDlyDop(savePlot, language, modelNsamples, repMontCarlo, ...
                  lenTxSignals(iLength), simulOutputName);
end                   
if savePlot=="save" || savePlot=="plot" || savePlot=="all"
    fprintf(' Completed! \n')  
end
end