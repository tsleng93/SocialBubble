function B = BubbleMakerSolo2(M, maxnum, d)

%Function creates a bubble joining anyone in a household <= maxnum to another household

%maxnum is max number of people in house to allow them to join somebody else's
%household

%d is the proportion of individuals forming an additional bubble

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
