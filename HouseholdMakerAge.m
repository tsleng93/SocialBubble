function [M, B, C, Age, BH] = HouseholdMakerAge(NumHouse, House_List, ProbHouse, House_Sizes, SizeBubble,SizeBubble2)

%Make Households H with probability ProbHouse
%Also makes Bubble B
%C is a vector counting the number of individuals someone has in their
%household
%Age is a vector of ages of individuals, in 5 year age gaps, until the 5th
%which is 25-55


if nargin == 0
    NumHouse =  10000;
    House_List = load('Census_House_List.csv');
    ProbHouse = load('Census_composition_dist.csv');
    House_Sizes = load('Census_House_Sizes.csv');
    SizeBubble = 2;
    SizeBubble2 = 2*SizeBubble;
end

%Always make NumHouse/SizeBubble an integer
if mod(NumHouse, SizeBubble) ~= 0
    NumHouse = NumHouse + (SizeBubble - mod(NumHouse, SizeBubble));
end
if mod(NumHouse/2, SizeBubble2) ~= 0
    NumHouse = NumHouse + (SizeBubble2 - mod(NumHouse/2, SizeBubble2))*2;
end

M = [];
B = [];
BH = [];
ProbHouse = cumsum(ProbHouse);

%Store Age vector
Age = [];

Bubbleadd = zeros(1,SizeBubble);
Bubbleadd2 = zeros(1,SizeBubble2);
%%%This makes bubbles of SizeBubble households
for i  = 1:NumHouse
    r = rand;
    for j = 1:length(ProbHouse)        
        if r < ProbHouse(j)    
            
            House = House_List(j,:);
            House = House(House > 0);
            M = blkdiag(M,sparse(ones(House_Sizes(j))));
            Bubbleadd(mod(i,SizeBubble)+1) = House_Sizes(j); 
            
            if i > NumHouse/2
                
                Bubbleadd2(mod(i,SizeBubble2)+1) = House_Sizes(j);
            end
            
            
            Age = [Age,House];
                
            break;
        end
    end
    
    if mod(i, SizeBubble) == 0
        B = blkdiag(B, sparse(ones(sum(Bubbleadd))));
        
        
        if i > NumHouse/2
             if mod(i, SizeBubble2) == 0
                BH= blkdiag(BH, sparse(ones(sum(Bubbleadd2))));
             end
        else
            BH= blkdiag(BH, sparse(ones(sum(Bubbleadd))));
        end
    end
    
    
end



B = B - M;
BH = BH - M;
C = sum(M);

%spy(M);
%figure
%spy(B);
