function B = BubbleMakerSolo(M, maxnum)

%maxnum is max number of people in house to allow them to join somebody else's
%household

B = sparse(zeros(length(M)));

for j = 1:length(M)
    
    if sum(M(j,:)) <= maxnum & sum(B(j,:)) == 0
       k = 1;
       while k > 0 
           r = randi(length(M));
           Newpartners = find(M(r,:));
           if  sum(B(r,:)) == 0
               B(j, Newpartners) = 1;
               B(Newpartners,j) = 1;
               k = 0;
           end
       end
    end
    
    
end