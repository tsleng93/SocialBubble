function [NewM, SAR] = PruneMatrixFull(M,tau, Type, A, RelTrans, RelInf)

%M full adjacency matrix
%tau is transmission rate
%Type is H or B, to be removed later
%A is age vector
%RelTrans is relative transmission of age groups
%RelInf is relative chance of infection of age groups


if nargin == 0
   %M = ones(6);
   [~, M, ~, A] = HouseholdMakerAge;
   tau = 1;
   Type = 'H';
   %A = [1 3 5 7 9 10];
   RelTrans = [0.64 0.64 0.64 0.64 1 1 1 2.9 2.9 2.9];
   RelInf = [0.5 0.5 0.5 0.5 1 1 1 1 1 1];    
    
end



for i = 1:length(RelInf)
    AInf(A==i) = RelInf(i);
    ATrans(A==i) = RelTrans(i);
end


if Type == 'H'
   M = M - speye(length(M),length(M));
end
    
Morig = M;

%Define rate matrix
%ATrans bit defines transmission probability from individual connected to
%Ainf tau bit puts the chance of infection together with the number in your
%household into the equation


%If Ainf refers to rates
temp = AInf.*(tau./sum(M));
%If Ainf refers to probabilities
%temp = (tau./sum(M));

temp(isinf(temp)) = 0;
RateM = (ATrans.*M).*temp';


%{
RateM1 = (ATrans.*M);
RateM2 = (AInf.*(tau./sum(M)))';
RateM2(RateM2==Inf) = 0;
RateM =RateM1.*RateM2;
%}
%RateM = (ATrans.*M).*(AInf.*(tau./sum(M)))';



%below to recover original prunematrix
%RateM = (ATrans.*M).*(AInf.*(tau))';



%Define probability matrix - people infect houses with probability P
PM = 1 - exp(-RateM);

%If Ainf refers to probabilities
%PM = AInf.*PM;


%Sample matrix
r = rand(size(M));
M(r>PM) = 0;

SAR = sum(sum(M))/sum(sum(Morig));

if Type == 'H'
    M = M + speye(length(M),length(M));
end

NewM = M;

%spy(M);
%figure
%spy(Morig);

