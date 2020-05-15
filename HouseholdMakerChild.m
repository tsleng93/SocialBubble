function [M, B, C, A] = HouseholdMakerChild(SizeHouse,NumHouse, ProbHouse, SizeBubble)

%Make Households H with probability ProbHouse
%Also makes Bubble B
%C is a vector counting the number of individuals someone has in their
%household
%A is a vector of ages of individuals, i.e. whether they are children or
%adults

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

%Store Age vector
A = [];
a = 1;



Bubbleadd = zeros(1,SizeBubble);
%%%This makes bubbles of SizeBubble households
for i  = 1:NumHouse
    r = rand;
    for j = 1:length(ProbHouse)        
        if r < ProbHouse(j)    
            M = blkdiag(M,sparse(ones(SizeHouse(j))));
            Bubbleadd(mod(i,SizeBubble)+1) = SizeHouse(j); 
            
            %Record whether child or adult
            if SizeHouse(j) == 1
                A(a) = 1;
                a = a+1;
            elseif SizeHouse(j) == 2
                A(a) = 1;
                A(a+1) = 0;
                a = a+2;
            else
                A(a:(a+1)) = [1 1];
                A((a+2):(a + SizeHouse(j) - 1)) = zeros(1, length(SizeHouse(j) - 2));
                a = a+SizeHouse(j);
            end
            
            
            
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
C = sum(M);