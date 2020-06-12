function B = BubbleMakerSolo2(M, maxnum, d)

%This function forms adjacency matrix for bubble connections. It takes the
%household connection matrix and will create bubbles for all households
%which are of size less than or equal to maxnum, who form bubbles with
%other households at random across the population for the first (d*100)% of
%the population.

%Input:
%   - M is the adjacency matrix for household connections.
%   - maxnum is the upper limit we set for household sizes that will form
%   bubbles.
%   - d is the proportion of the proportion of the population who form
%   bubbles, provided they are eligible.

%Output:
%   - B is the adjacency matrix for bubble connections.

%Note: M and B are N x N matrices where N is the population size.

%Authors: Trystan Leng and Connor White
%Last update 12/06/2020.

B = sparse(zeros(length(M)));

for j = 1:(d*length(M))
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
               %B(j, Newpartners) = 1;
               %B(Newpartners,j) = 1;
               B(House_to_Connect, Newpartners) = 1;
               B(Newpartners, House_to_Connect) = 1;
               k = 0;
           end
       end
    end
end
