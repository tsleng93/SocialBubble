function [NewM, SAR] = PruneMatrixFull(M,tau, Type, A, RelTrans, RelInf, freqordens)


%This function takes an adjacency matrix M and removes edges at a
%probability dependeant on individuals' age groups. In this case M
%is eiher a adjacency matrix for household connections or bubble 
%connections.


%Input:
%   - M is the adjacency matrix for the household or bubble contacts.
%   - tau is the baseline transmission rate across a household or bubble 
%   contact.
%   - Type is a character which tells the function if M is a household
%   ('H') adjacency matrix or a bubble ('B') adjacency matrix.
%   - A is a vector which store the age group each individual in the
%   population belongs to.
%   - RelTrans scales the the rate an individual transmits infection, 
%   dependent on their age group.
%   - RelInf scales the rate of transmission to an individual (i.e. their 
%   rate of infection) dependent on their age group.
%   - freqordens tells the function whether we are considering frequency or
%   density dependent transmission

%Output:
%   - NewM is the adjacency matrix after it has been pruned.
%   - SAR (secondary attack rate) is a ratio check to see the proportion of connections that are
%   present after compared to before pruning.

%Note: M is a N x N matrix where N is the population size.

%Authors: Trystan Leng, Connor White and Matt Keeling.
%Last update 15/03/2021.

for i = 1:length(RelInf)
    AInf(A==i) = RelInf(i);
    ATrans(A==i) = RelTrans(i);
end


if Type == 'H'
   M = M - speye(length(M),length(M));
end

if freqordens == 'freq'
    Rdenom = M;
elseif freqordens == 'dens'
    Rdenom = speye(length(M));
end

    
Morig = M;

%Define rate matrix
%for frequency dependent transmission
%tempIJ1 = AInf.*(tau./sum(M));
%for density dependent transmission
%tempIJ1 = AInf.*tau;
%With Rdenom (for either)
tempIJ1 = AInf.*(tau./sum(Rdenom));

tempIJ2 = ATrans;
tempIJ1(isinf(tempIJ1)) = 0;

tempJI1 = AInf.*tau;
%for frequency dependent transmission
%tempJI2 = ATrans./sum(M);
%for density dependent transmission
%tempJI2 = ATrans;

%With Rdenom (for either)
tempJI2 = ATrans./sum(Rdenom);

tempJI2(isinf(tempJI2)) = 0;


%For matlab%

tempIJ = (tempIJ2.*M).*tempIJ1';
tempJI = (tempJI2.*M).*tempJI1';
RateM = tempIJ + tempJI;
%}

%For Octave%
%{
tempIJ1Mat = repmat(tempIJ1, length(M), 1);
tempIJ2Mat = repmat(tempIJ2, length(M), 1);
tempJI1Mat = repmat(tempJI1, length(M), 1);
tempJI2Mat = repmat(tempJI2, length(M), 1);
RateM = (tempIJ2Mat.*M).*(tempIJ1Mat') + (tempJI2Mat.*M).*(tempJI1Mat');

tempIJ1Mat = [];  tempIJ2Mat = []; tempJI1Mat = []; tempJI2Mat = [];
%}


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
