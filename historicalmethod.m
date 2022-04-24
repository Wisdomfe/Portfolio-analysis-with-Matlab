function [VaR,ES,index_div_VaR,index_div_ES]= historicalmethod (stocks,R,today,years,alpha)

%INPUT: stocks   
%       R   returns
%       today   VaR day estimation
%       years   
%       alpha   VaR level
%OUTPUT: VaR\ES   Var\ES del poratfoglio
%        index_div_VaR\indice_div_ES    index diversification VAR\ES



M=years*252; 

VaR=nan(1,11);  
ES=nan(1,11);
n_azioni=nan(1,10);
V_0=nan(1,10);
PL=nan(M,10);

n_shares=1000./stocks(1,:);   

%start sampling
begin=today-M;

%Var
for i=1:10                                        
    V_0(i)=stocks(today,i)*n_shares(i);   
    PL(:,i)=V_0(i)*R(begin+1:today,i);          
    [VaR(i), ES(i)] = RiskDiscrete(PL(:,i),alpha);    
end

V_0P=sum(V_0);    %Total portfolio Value
w=V_0/V_0P;    %Weights(%)

PL_P = V_0P*w*(R(begin+1:today,:))';    %PL portafolio
[VaR(11), ES(11)] = RiskDiscrete(PL_P,alpha);    

index_div_VaR=sum(VaR(1:10))/VaR(11);             %Diversification Index
index_div_ES=sum(ES(1:10))/ES(11);
VaR=VaR(11);                                       %Var and Es of portfolio
ES=ES(11);

end

