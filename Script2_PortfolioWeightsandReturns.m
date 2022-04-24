clear all
load stocks
stocks = [ Amazon Apple EA EXPE EBAY INTC MSFT NFLX NVDA QCOM];  % same as with indices
labels = {' AMZN',' AAPL',' EA ','EBAY', 'EXPE',' INTC',' MSFT',' NFLX',' NVDA',' QCOM'}; 

[V_P, theta, R, R_P] = Return(stocks);

dates_R = date_stocks(2:end);
figure
plot(date_stocks,V_P);    
datetick('x','yyyy'); 
xlabel('year'), ylabel('portfolio value'), 
title('Portfolio value')
figure
plot(date_stocks,theta);    
datetick('x','yyyy'); 
xlabel('year'), ylabel('Weights of assets '), 
title('Percent weights')
legend(labels)
 
figure
plot(dates_R,R_P);    
datetick('x','yyyy'); 
xlabel('year'), ylabel('returns'), 
title('Portfolio daily returns')
save Results_PortfolioWeights&Returns

%clear all