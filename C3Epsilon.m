function [eps2] = C3Epsilon(B, C, Age, RelTrans, RelInf, tauB, eps)

%This function calculates the mean-field rate of transmission for
%Scenario C3, i.e. where individuals make extra contacts through random 
%contacts rather than through bubbles

%Input:
%   - B is the adjacency matrix of bubble contacts
%   - C is a vector which conatains the size of household each individual
%   belongs to.
%   - Age is a vector which store the age group each individual in the
%   population belongs to.
%   - RelTrans scales the the rate an individual transmits infection, 
%   dependent on their age group.
%   - RelInf scales the rate of transmission to an individual (i.e. their 
%   rate of infection) dependent on their age group.
%   - tauB is the base rate of transmission across bubble contacts
%   - eps is the previous rate of mean-field transmission, when bubble contacts
%   are uncluded.

%Output:
%   - eps2 is the new mean-field rate of transmission for C3

%Authors: Trystan Leng and Connor White
%Last update 12/06/2020.


CB = sum(B);

for i = 1:length(RelInf)
    AInf(Age==i) = RelInf(i);
    ATrans(Age==i) = RelTrans(i);
end

%Calculate B and eps constants
%Total rate of Bubble transmission is KB x tauB
%Total rate of mean-field transmission is Keps x eps

%If using Matlab
KB = sum(sum((ATrans.*B).*(AInf./CB)'));

%if using Octave
%{
for i = 1:length(B)
  KBvec(i) = sum(ATrans.*B(i,:).*(AInf(i)./CB(i)));
end
KB = sum(KBvec);
%}


Keps = sum(AInf./C).*sum(ATrans)/length(C);

%Find eps2 satisying (Keps x eps2) = (KB x tauB) + (Keps x eps)
eps2 = KB/Keps*tauB + eps;
