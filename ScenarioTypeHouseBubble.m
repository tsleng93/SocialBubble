function B = ScenarioTypeHouseBubble(H, TypeorSize, Position)

%This function forms and adjacency matrix for Bubble connections.
%The function requires a vector 'TypeorSize' which designates some attribute
%of the household, e.g. if it is Size 1, if it has includes a child <10 years
% old, etc.

%Input:
%   - H is the adjacency matrix for Household connections.
%   - TypeorSize is a vector that contains either the type of house (e.g if
%   it contains children or not)  or the size of each house.
%   - position is a vector that stores the position in the population of 
%   the first member of the household.

%Output
%   - B is the adjacency matrix for bubble connections.


temp = find(TypeorSize == 1);

B = sparse(zeros(length(H)));

L = length(TypeorSize);
LH = length(H);

for i = 1:(length(temp))/2
    
    j = 2*(i-1)+1;
    
    if j+1 > length(temp)
        break;
    else
        j2 = j+1;
    end
    
    k = temp(j);
    k2 = temp(j2);
     
    House_to_Connect = Position(k):(Position(k+1) - 1);
    
    if k2 == L
        Newpartners = Position(k2):LH;
    else
        Newpartners = Position(k2):(Position(k2+1) - 1);
    end
        
    B(House_to_Connect, Newpartners) = 1;
    B(Newpartners, House_to_Connect) = 1;    
    
end
