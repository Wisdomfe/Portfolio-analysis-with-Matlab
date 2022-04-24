load Results_PortfolioWeights&Returns
load stocks
alpha=0.01;
years=5;
M=years*252; %trading days in 5 years

VaR=nan(2,10);
ES=nan(2,10);
n_shares=nan(1,10);
V_0=nan(1,10);
PL=nan(M,10);

n_shares=round(1000./stocks(1,:));   %n-shares

m=1:M;
eta=0.95;
p=((1-eta)/(eta*(1-eta^M)))*eta.^(M+1-m);




%Var
for i=1:10                                        
    V_0(i)=stocks(M,i)*n_shares(i);   
    PL(:,i)=V_0(i)*R(1:M,i);          
    [VaR(1,i), ES(1,i)] = RiskDiscrete(PL(:,i),alpha);     
    [VaR(2,i), ES(2,i)] = RiskDiscrete(PL(:,i),p,alpha);    
end


VaR_P=nan(2,1);
ES_P=nan(2,1);

V_0P=sum(V_0);    %Total Portfolio Value
w=V_0/V_0P;    %Weights(%)

PL_P = V_0P*w*(R(1:M,:))';    %PL portafolio
[VaR_P(1), ES_P(1)] = RiskDiscrete(PL_P,alpha);    
[VaR_P(2), ES_P(2)] = RiskDiscrete(PL_P,p,alpha);    


Var_storic=VaR_P(1)
Expected_shortfall=ES_P(1)
Var_storic_weighted=VaR_P(2)
Expected_shortfall_weighted=ES_P(2)

index_div_VaR=sum(VaR(1,:))/VaR_P(1)
index_div_ES=sum(ES(1,:))/ES_P(1)
index_div_VaR_weig=sum(VaR(2,:))/VaR_P(2)
index_div_ES_weig=sum(ES(2,:))/ES_P(2)


save Results_Var&Es
