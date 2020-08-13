function [B,Inbubble] = ScenarioTypeHouseBubble2(H, TypeorSize, Position, Inbubble, d)

%This function forms and adjacency matrix for Bubble connections.
%The function requires a vector 'TypeorSize' which designates some attribute
%of the household, e.g. if it is Size 1, if it has includes a child <10 years
% old, etc.
%ScenarioTypeHouseBubble 2 connects household with the attribute to any other household

%Input:
%   - H is the adjacency matrix for Household connections.
%   - TypeorSize is a vector that contains either the type of house (e.g if
%   it contains children or not)  or the size of each house.
%   - position is a vector that stores the position in the population of 
%   the first member of the household.
%   - Inbubble is a vector storing whether a household is already part of a bubble
%   - d is the proportion of eligible households who enter into a bubble

%Output
%   - B is the adjacency matrix for bubble connections.


temp = find(TypeorSize == 1);

B = sparse(zeros(length(H)));

L = length(TypeorSize);
LH = length(H);



for i = 1:d*(length(temp))
    
    k = temp(i);
      
    if k == L
        House_to_Connect = Position(k):LH;     
    else
        House_to_Connect = Position(k):(Position(k+1) - 1);
    end

    %check it has not already been paired up
    if Inbubble(k) == 0
    
        r1 = find(Inbubble == 0);
        r2 = randi(length(r1));
        r3 = r1(r2);
        
        if r3 == L
            Newpartners = Position(r3):LH;     
        else
            Newpartners = Position(r3):(Position(r3+1) - 1);
        end
                
        B(House_to_Connect, Newpartners) = 1;
        B(Newpartners, House_to_Connect) = 1;
        
        Inbubble(k) = 1;
        Inbubble(r3) = 1;
    
    end
    
    
    
    if sum(Inbubble(temp))/length(Inbubble(temp)) > d
        break;
    end
    
end
