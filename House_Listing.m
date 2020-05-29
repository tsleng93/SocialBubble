%This Script simply takes household data and formats it into a format we
%use for forming househoulds in the model.

%Authors: Trystan Leng and Connor White
%Last update 29/05/2020.


temp = load('uk_composition_list.csv');
dist = load('uk_composition_dist.csv');


House_Sizes = sum(temp,2);


House_List = zeros(length(dist),max(House_Sizes));

for i = 1:1:length(dist)
   temp1 = temp(i,:);
   people_index = find(temp1>0);
   people = temp1(temp1 > 0);
   counter = 1;
   for j=1:1:length(people)
       
       for k = 1:1:people(j)
            House_List(i,counter) = people_index(j);
            counter = counter + 1;
       end
   end
end

csvwrite('House_List.csv',House_List); 
csvwrite('House_Sizes.csv',House_Sizes); 