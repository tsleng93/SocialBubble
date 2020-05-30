function B = ScenarioTypeHouseBubble(H, TypeorSize, Position)

%d = 1;


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