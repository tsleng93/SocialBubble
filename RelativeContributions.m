function [Neweps] = RelativeContributions(H, B, Age, C, RelTrans, RelInf, tauH, tauB, eps)

load('PaperHouseholdworkspace.mat');

%B = zeros(length(H));


for i = 1:length(RelInf)
    AInf(Age==i) = RelInf(i);
    ATrans(Age==i) = RelTrans(i);
end



H2 = H - speye(length(H),length(H));


%If Ainf refers to rates
temp = AInf.*(tauH./sum(H2));

temp(isinf(temp)) = 0;
RateH = (ATrans.*H2).*temp';

R_H = sum(RateH);

temp = AInf.*(tauB./sum(B));

temp(isinf(temp)) = 0;
RateB = (ATrans.*B).*temp';

R_B = sum(RateB);


temp = ones(1,length(H))*sum(ATrans)*eps/length(H);


temp(isinf(temp)) = 0;
temp(isnan(temp)) = 0;
R_Eps = temp.*(AInf./C);

%R_Eps2 = (ones(1,length(H))*sum(ATrans)*eps/length(H)).*(AInf./C);

NewR_Eps = sum(R_B) + sum(R_Eps);


const = sum((ones(1,length(H))*sum(ATrans)/length(H)).*(AInf./C));

%Neweps = NewR_Eps*(length(H)/sum(ATrans))./(AInf./C);
%Neweps2 = mean(Neweps);

Neweps = sum(R_B)/const + eps;

R_Eps2 = (ones(1,length(H))*sum(ATrans)*Neweps/length(H)).*(AInf./C);







