function [M, B, C, Age, BH, SizeHouse, TypeHouse, Position] = HouseholdMakerAge(NumHouse, House_List, ProbHouse, House_Sizes, SizeBubble,SizeBubble2)

%This function forms adjacency matrix for household connections and bubble
%connections. The size and age structure of each house is taken from a
%distribution of house types that we have aquire from data.


%Input:
%   - NumHouse is the number of houses we want to simulate.
%   - House_List is a list of house types that we select from to form
%   houses.
%   - ProbHouse is the probability of of selecting a house from HouseList.
%   - House_Sizes is a list which tells us the size of each house from
%   House_List.
%   - SizeBubble is the number of houses we want to form a bubble which we
%   store in matrix B.
%   - SizeBubble2 is the number of houses we want to store in the second
%   half of BH. The first half of BH has bubbles with sizebubble number of
%   houses.

%Output:
%   - M is the adjacency matrix for household connections.
%   - B is the adjacency matrix for bubble connections where the bubbles
%   are formed with SizeBubble number of houses.
%   - C is a vector which is the size of house each individual belongs to.
%   - Age is a vector which conatains what age group each individual
%   belongs to in the population.
%   - BH is the adjacency matrix for bubble connections where the first
%   half of houses form bubbles with SizeBubble number of houses and the 
%   second half od houses form bubbles with SizeBubble2 number of houses.

%Note: M, B and BH are N x N matrices where N is the population size. C and
%Age are vectors of size N.

%Authors: Trystan Leng and Connor White
%Last update 29/05/2020.


if nargin == 0
    NumHouse =  4000;
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
ProbHouse = cumsum(ProbHouse)/sum(ProbHouse);
ProbHouse(end) = 1;

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
            
            %do size houses and type houses and position
            SizeHouse(i) = length(House);
            
            if sum(House == 1) > 0
                TypeHouse(i) = 1; %1 for child < 10                   
            elseif sum (House ==2) > 0
                TypeHouse(i) = 2; %2 for child < 20
            else
                TypeHouse(i) = 0; % 0 for 0 children                                
            end
            
            Position(i) = length(M)+1;
            
            
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
