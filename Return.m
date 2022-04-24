function [ V_P, theta, R, R_P] = Return(stocks)


L = length(stocks);
%n of shares for each stock
pi=round(1000./stocks(1,:));
Vi=zeros(L,10);
V_P=zeros(L,1);
R_P=zeros(L-1,1);

for i=1:L 
    for j=1:10
    Vi(i,j)=pi(j)*stocks(i,j); 
    end  
    V_P(i)=sum(Vi(i,:)); % Total Portfolio Value
end

theta=zeros(L,10);

for i=1:L 
    for j=1:10
    theta(i,j)=(pi(j)*stocks(i,j))/V_P(i);
    end  
end

% Log Returns

R = diff(log(stocks));  %
                                    
for i=1:L-1
    
     %R_Pi(i)= theta(i,:)* R(i,:)'; %portfolio i
     R_P(i) = log(sum(theta(i+1,:).*exp(R(i,:)))); %Total portfolio
end

                    
end

