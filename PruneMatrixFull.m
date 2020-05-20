function [Morig, NewM] = PruneMatrixFull(M,tau, Type, A, RelTrans, RelInf)

%M full adjacency matrix
%tau is transmission rate
%Type is H or B, to be removed later
%A is age vector
%RelTrans is relative transmission of age groups
%RelInf is relative chance of infection of age groups


if nargin == 0
   %M = ones(6);
   [M, ~, ~, A] = HouseholdMakerAge;
   tau = 1;
   Type = 'H';
   %A = [1 3 5 7 9 10];
   RelTrans = [0.64 0.64 0.64 0.64 1 1 1 2.9 2.9 29];
   RelInf = [0.5 0.5 0.5 0.5 1 1 1 1 1 1];    
    
end

Morig = M;

for i = 1:length(RelInf)
    AInf(A==i) = RelInf(i);
    ATrans(A==i) = RelTrans(i);
end


if Type == 'H'
   M = M - speye(length(M),length(M));
end
    


%Define rate matrix
%ATrans bit defines transmission probability from individual connected to
%Ainf tau bit puts the chance of infection together with the number in your
%household into the equation
RateM = (ATrans.*M).*(AInf.*(tau./sum(M)))';


%Define probability matrix - people infect houses with probability P
PM = 1 - exp(-RateM);

%Sample matrix
r = rand(size(M));
M(r>PM) = 0;

if Type == 'H'
    M = M + speye(length(M),length(M));
end

NewM = M;



