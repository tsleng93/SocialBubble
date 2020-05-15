function [M, B] = HouseholdMaker2(SizeHouse,NumHouse, ProbHouse, SizeBubble)

%Make Households with probability ProbHouse
%Also makes Bubble

if nargin == 0
    SizeHouse = 1:7;
    NumHouse = 4500;
    ProbHouse = [0.30 0.34 0.16 0.13 0.05 0.016 0.004];
    SizeBubble = 2;
end

%Always make NumHouse/SizeBubble an integer
if mod(NumHouse, SizeBubble) ~= 0
    NumHouse = NumHouse + mod(NumHouse, SizeBubble);
end


M = [];
B = [];
ProbHouse = cumsum(ProbHouse);

Bubbleadd = zeros(1,SizeBubble);
%%%This makes bubbles of 2 households
for i  = 1:NumHouse
    r = rand;
    for j = 1:length(ProbHouse)        
        if r < ProbHouse(j)    
            M = blkdiag(M,sparse(ones(SizeHouse(j))));
            Bubbleadd(mod(i,SizeBubble)+1) = SizeHouse(j); 
            break;
        end
    end
    
    if mod(i, SizeBubble) == 0
        B = blkdiag(B, sparse(ones(sum(Bubbleadd))));
    end
end


%%%This makes bubbles of up to Sizebubble individuals,
%{
SizeBubble2 = 10;
Bsum = 0;

for i  = 1:NumHouse
    r = rand;
    for j = 1:length(ProbHouse)        
        if r < ProbHouse(j)    
            M = blkdiag(M,sparse(ones(SizeHouse(j))));
            if Bsum + SizeHouse(j) > SizeBubble2
                B = blkdiag(B, sparse(ones(Bsum)));
                Bsum = SizeHouse(j);
            else
                Bsum = Bsum + SizeHouse(j);
            end
            break;
        end
    end
    
end

B = blkdiag(B, sparse(ones(Bsum)));

%}



B = B - M;
