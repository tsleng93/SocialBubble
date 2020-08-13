function [NewM, SAR] = PruneMatrixFull(M,tau, Type, A, RelTrans, RelInf)


%This function takes an adjacency matrix M and removes edges at a
%probability dependeant on individuals' age groups. In this case M
%is eiher a adjacency matrix for household connections or bubble 
%connections.


%Input:
%   - M is the adjacency matrix for the household or bubble contacts.
%   - tau is the baseline transmission rate across a household or bubble 
%   contact.
%   - Type is a charecter which tells the function if M is a household
%   ('H') adjacency matrix or a bubble ('B') adjacency matrix.
%   - A is a vector which store the age group each individual in the
%   population belongs to.
%   - RelTrans scales the the rate an individual transmits infection, 
%   dependent on their age group.
%   - RelInf scales the rate of transmission to an individual (i.e. their 
%   rate of infection) dependent on their age group.

%Output:
%   - NewM is the adjacency matrix after it has been pruned.
%   - SAR (secondary attack rate) is a ratio check to see the proportion of connections that are
%   present after compared to before pruning.

%Note: M is a N x N matrix where N is the population size.

%Authors: Trystan Leng, Connor White and Matt Keeling.
%Last update 13/08/2020.




for i = 1:length(RelInf)
    AInf(A==i) = RelInf(i);
    ATrans(A==i) = RelTrans(i);
end


if Type == 'H'
   M = M - speye(length(M),length(M));
end
    
Morig = M;

%Define rate matrix
tempIJ1 = AInf.*(tau./sum(M));
tempIJ2 = ATrans;
tempIJ1(isinf(tempIJ1)) = 0;

tempJI1 = AInf.*tau;
tempJI2 = ATrans./sum(M);
tempJI2(isinf(tempJI2)) = 0;


%For matlab%
tempIJ = (tempIJ2.*M).*tempIJ1';
tempJI = (tempJI2.*M).*tempJI1';


%For Octave%
%{
tempIJ1Mat = repmat(tempIJ1, length(M), 1);
tempIJ2Mat = repmat(tempIJ2, length(M), 1);
tempJI2Mat = repmat(tempJI1, length(M), 1);
tempJI2Mat = repmat(tempJI2, length(M), 1);
tempIJ = (tempIJ2mat.*M).*(tempIJ1Mat');
tempJI = (tempJI2mat.*M).*(tempJI1Mat');
%}

RateM = tempIJ + tempJI;


%Define probability matrix - people infect houses with probability P
PM = 1 - exp(-RateM);


%Sample matrix
r = rand(size(M));
M(r>PM) = 0;

SAR = sum(sum(M))/sum(sum(Morig));

if Type == 'H'
    M = M + speye(length(M),length(M));
end

NewM = M;
