%PCA 
clear all
load stocks 
load Results_PortfolioWeights&Returns
clear R R_simple 
stocks = [ Amazon Apple EA EXPE EBAY INTC MSFT NFLX NVDA QCOM];  

% calculation of historical covariance-variance matrix 

ret = diff(log(stocks));
cov = cov(ret);

%computation of the eigenvalues ​​and the respective eigenvectors

[W, A] = eig(cov);

% extraction of "p" main components
p = 3;
[lambda,index] = sort(diag(A),1,'descend'); % from the diagonal matrix of the eigenvalues ​​I take a vector
                                            % that contains them and sorts them
                                            % from largest to smallest.
                                            % in Index instead I keep the
                                            % permutation indices
                                            % carried out for ordinals

w = W(:,index(1:p)); % the first "p" elements of index therefore concur the indices of the first p
                     % main components, and I use them to extract i
                     % respective eigenvectors
w_PCA(1:p)=lambda(1:p)./sum(lambda); % percentage weights of the respective main components
                                     % these numbers indicate the percentage
                                     % of portfolio variance explained
                                     % from each component,
                                     % presumably are used to weigh i
                                     % returns of the three components at the end
                                     % to calculate the profit & loss:
                                     %V_P(today)*w_PCA*R_simple_PCA(begin:today,:)'
                                     

% ewrite of the 10 dimensional returns in terms of the 3 components
%Top (i.e. new returns on a 3-D basis)

L = length(ret);
ret_PCA=zeros(L,p); 
theta_PCA=zeros(L+1,p);
for i=1:L  
    ret_PCA(i,1:p) = (w'*ret(i,:)')';
    theta_PCA(i,1:p) = (w'*theta(i,:)')';
    
end


%% calculation of risk factors Var1% ES1% using the historical method over the whole window
% 1/12 / 2013-1 / 12/2017, based on the previous 5 years of data

endcycle=length(date_stocks)-1; % i ritorni hanno una riga in meno rispetto alle date
years=5;
M=years*252;
alpha=0.01;
VaRDaily=nan(1,endcycle-M);
ESDaily=nan(1,endcycle-M);
VaRDaily_PCA=nan(1,endcycle-M);
ESDaily_PCA=nan(1,endcycle-M);


i=1;
for today=M:endcycle % it starts from December 2nd because December 1st is a Sunday
    begin=today-M+1;
   
    PL_P = V_P(today)*theta(today,:)*ret(begin:today,:)'; % I fix the value of the portfolio for one day and multiply it individually
                                                    % for the returns observed in the previous five% years to obtain the Profit & Loss values
     
    
    PL_P_PCA = V_P(today)*theta_PCA(today,:)*ret_PCA(begin:today,:)';
    [VaRDaily(i),ESDaily(i)]=RiskDiscrete(PL_P,alpha);
    [VaRDaily_PCA(i),ESDaily_PCA(i)]=RiskDiscretePCA(PL_P_PCA,alpha);
    i=i+1;
    
end

figure
%labels = {'Daily Var','Daily Var_PCA'};  
x=date_stocks(M:end-1);
datamatrix=[VaRDaily_PCA./VaRDaily];

plot(x,datamatrix);    
datetick('x','yyyy') 
xlabel('year'), ylabel('Level'), 
title('Ratio Daily VaR PCA to VAR from December 2013 to December 2017')
%legend(labels)

figure
%labels = {'Daily Var','Daily Var_PCA'};  
x=date_stocks(M:end-1);
datamatrix=[ESDaily_PCA./ESDaily];

plot(x,datamatrix);    
datetick('x','yyyy') 
xlabel('year'), ylabel('Level'), 
title('Ratio Daily ES PCA to ES from December 2013 to December 2017')
%legend(labels)

theta_PCA_biennio=zeros(endcycle+1,p);

for i=1:endcycle+1  
  
    theta_PCA_biennio(i,:) = (w'*theta(i,:)')';
end

save Results_PCA