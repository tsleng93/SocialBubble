function B = NonAdherenceBubble(H, TypeorSize, Position, d)

%This function forms an adjacency matrix for Bubble connections. The
%bubbles are formed from households that either are of size 1, or contain a
%child of <10 years of age.

%Input:
%   - H is the adjacency matrix for Household connections.
%   - TypeorSize is a vector that contains either the type of house (e.g if
%   it contains children or not)  or the size of each house.
%   - position is a vector that stores the position in the population of 
%   the first member of the household.
%   d is the proportion of houses that fill the condition that we want to
%   form into a bubble.

%Output
%   - B is the adjacency matrix for bubble connections.

%Authors: Trystan Leng and Connor White
%Last update 12/06/2020.


%Find all houses that satisfy the type or size
temp = find(TypeorSize == 1);

%randomly choose the households that will form bubbles
r = randperm(length(temp), round(length(temp)*d));

%initialise Bubble adjacency matrix
B = sparse(zeros(length(H)));

%L is number of households
L = length(TypeorSize);
%LH is size of population
LH = length(H);

for i = 1:(length(r)/2)
    
    j = 2*(i-1)+1;
    
    %to deal with an odd number of entries
    if j+1 > length(r)
        break;
    else
        j2 = j+1;
    end
    
    %choose households to join up into a bubble
    k = temp(r(j));
    k2 = temp(r(j2));
    
    %Vector of individuals from first household entering bubble  
    if k == L
        House_to_Connect = Position(k):LH;
    else
        House_to_Connect = Position(k):(Position(k+1) - 1);
    end    
    %Vector of individuals from second household entering bubble
    if k2 == L
        Newpartners = Position(k2):LH;
    else
        Newpartners = Position(k2):(Position(k2+1) - 1);
    end
   
    %Join households together into the bubble by setting their
    %entries in B to equal 1
    B(House_to_Connect, Newpartners) = 1;
    B(Newpartners, House_to_Connect) = 1;    
    
end
