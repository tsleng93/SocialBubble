function B = NonAdherenceBubble(H, TypeorSize, Position, d)

%d = 1;


temp = find(TypeorSize == 1);

r = randperm(length(temp), round(length(temp)*d));

B = sparse(zeros(length(H)));

L = length(TypeorSize);
LH = length(H);

for i = 1:(length(r)/2)
    
    j = 2*(i-1)+1;
    
    if j+1 > length(r)
        break;
    else
        j2 = j+1;
    end
    
    k = temp(r(j));
    k2 = temp(r(j2));
    
    %k
    
    if k == L
        House_to_Connect = Position(k):LH;
    else
        House_to_Connect = Position(k):(Position(k+1) - 1);
    end
    
    
    
    if k2 == L
        Newpartners = Position(k2):LH;
    else
        Newpartners = Position(k2):(Position(k2+1) - 1);
    end
        
    B(House_to_Connect, Newpartners) = 1;
    B(Newpartners, House_to_Connect) = 1;    
    
end