load stocks

stocks = [ Amazon Apple EA EXPE EBAY INTC MSFT NFLX NVDA QCOM];  % same as with indices
L = length(stocks);
labels = {' AMZN',' AAPL',' EA ','EBAY', 'EXPE',' INTC',' MSFT',' NFLX',' NVDA',' QCOM'};  

stocks_norm = 100*stocks./repmat(stocks(1,:),L,1); % base 100 at 1/1/2003

pi=round(1000./stocks(1,:));

plot(date_stocks,stocks_norm)
datetick('x','yyyy')

R = diff(log(stocks));
dates_R = date_stocks(2:end);
ExpRet = mean(R);    % expected returns
Vol = std(R);        % volatilities
Sk = skewness(R);    % skewness
Kurt = kurtosis(R);  % kurtosis (all functions act on columns)
fprintf('%16s %6s %11s %11s %11s\n',' ','ExpRet','Vol','Sk','Kurt');
for i = 1:10 
   formatSpec = '%11s \t %6.3f \t %6.3f \t %6.3f \t %6.3f\n';
   fprintf(formatSpec,labels{i},100*ExpRet(i),100*Vol(i),Sk(i),Kurt(i));
end
             % advanced formatting: see help for 'fprintf'
             % note: labels{i} contains string with i-th label 
             % (e.g. labels{1} = 'Apple')
for i=1:10
figure
histfit(R(:,i));
title(['Returns distribution ',labels(i)])
end

for i=1:10
figure
          % entire series
      

    qqplot(R(:,i));
    %xlabel('year'), ylabel('$'), 
   
title(['qqplot Returns ',labels(i)])
    
    
end

for i=1:10
    
    figure
    autocorr(R(:,i),50);
    title(['Autocorrelation ',labels(i)])
end
save Results_StocksStatistics