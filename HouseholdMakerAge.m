function [M, B, C, Age] = HouseholdMakerAge(NumHouse, House_List, ProbHouse, SizeBubble)

%Make Households H with probability ProbHouse
%Also makes Bubble B
%C is a vector counting the number of individuals someone has in their
%household
%Age is a vector of ages of individuals, in 5 year age gaps, until the 5th
%which is 25-55


if nargin == 0
    NumHouse =  30;
    House_List = load('House_List.csv');
    ProbHouse = load('uk_composition_dist.csv');
    SizeBubble = 2;
end

%Always make NumHouse/SizeBubble an integer
load('House_Sizes.csv');

if mod(NumHouse, SizeBubble) ~= 0
    NumHouse = NumHouse + (SizeBubble - mod(NumHouse, SizeBubble));
end


M = [];
B = [];
ProbHouse = cumsum(ProbHouse);

%Store Age vector
Age = [];

Bubbleadd = zeros(1,SizeBubble);
%%%This makes bubbles of SizeBubble households
for i  = 1:NumHouse
    r = rand;
    for j = 1:length(ProbHouse)        
        if r < ProbHouse(j)    
            
            House = House_List(j,:);
            House = House(House > 0);
            M = blkdiag(M,sparse(ones(House_Sizes(j))));
            Bubbleadd(mod(i,SizeBubble)+1) = House_Sizes(j); 
            
            Age = [Age,House];
                
            break;
        end
    end
    
    if mod(i, SizeBubble) == 0
        B = blkdiag(B, sparse(ones(sum(Bubbleadd))));
    end
end




B = B - M;
C = sum(M);

spy(M);
figure
spy(B);
