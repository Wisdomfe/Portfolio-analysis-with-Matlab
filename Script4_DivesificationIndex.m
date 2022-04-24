clear all
load stocks
load  Results_Var&Es 
stocks = [ Amazon Apple EA EXPE EBAY INTC MSFT NFLX NVDA QCOM];
labels = {' AMZN',' AAPL',' EA ','EBAY', 'EXPE',' INTC',' MSFT',' NFLX',' NVDA',' QCOM'}; 



dates_R = date_stocks(2:end);
endcycle=length(dates_R);
years=5;
M=years*252;
alpha=0.01;
VaRDaily=nan(1,M-endcycle);
ESDaily=nan(1,M-endcycle);
index_VaRDaily=nan(1,M-endcycle);
index_ESDaily=nan(1,M-endcycle);

i=1;
for today=M+1:endcycle
    [VaRDaily(i),ESDaily(i),index_VaRDaily(i),index_ESDaily(i)]=historicalmethod(stocks,R,today,years,alpha);
    i=i+1;
end

%plot VaR ES in the same charts
figure
labels = {'Daily Var','Daily ES'};  
x=dates_R(M+1:endcycle);
datamatrix=[VaRDaily;ESDaily];

plot(x,datamatrix);    
datetick('x','yyyy') 
xlabel('year'), ylabel('Level'), 
title('Daily VaR and ES from December 2013 to December 2017')
legend(labels)


figure
labels = {'Diversification Index VaR','Diversification index ES'};  
x=dates_R(M+1:endcycle);
datamatrixindex=[index_VaRDaily;index_ESDaily];

plot(x,datamatrixindex);    
datetick('x','yyyy') 
xlabel('year'), ylabel('Level'), 
title('Daily diversification VaR and ES index from December 2013 to December 2017')
legend(labels)


    