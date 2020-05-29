function B = BubbleMakerSolo(M, maxnum)

%This function forms adjacency matrix for bubble connections. It takes the
%household connection matrix and will create bubbles which are formed of
%houses which are of size equal to or smaller than the number maxnum


%Input:
%   - M is the adjacency matrix for household connections.
%   - maxnum is the upper limit we set for hosuehold sizes that will form
%   bubbles.

%Output:
%   - B is the adjacency matrix for bubble connections.

%Note: M and B are N x N matrices where N is the population size.

%Authors: Trystan Leng and Connor White
%Last update 29/05/2020.


B = sparse(zeros(length(M)));

for j = 1:length(M)
    %Finding a household that has a size equal to or less than maxnum and
    %is not already connected
    if sum(M(j,:)) <= maxnum && sum(B(j,:)) == 0
       %indexing all people in the house that are going to be connected to 
       House_to_Connect = find(M(j,:));
       k = 1;
       while k > 0 
           %finding another household to bubble person with
           r = randi(length(M));
           
           %indexing all people in that household
           Newpartners = find(M(r,:));
           
           
           
           %Checking this household has not be bubbled with already and
           %that it is not bubbling with its own household.
           if  sum(B(r,:)) == 0 && Newpartners(1) ~= House_to_Connect(1)
               %forming new contacts
             
               B(House_to_Connect, Newpartners) = 1;
               B(Newpartners, House_to_Connect) = 1;
               k = 0;
           end
       end
    end
end
