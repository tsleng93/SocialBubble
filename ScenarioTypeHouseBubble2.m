function [B,Inbubble] = ScenarioTypeHouseBubble2(H, TypeorSize, Position, Inbubble, d)
%Connects that house to any other house

%d = 1;


temp = find(TypeorSize == 1);

B = sparse(zeros(length(H)));

L = length(TypeorSize);
LH = length(H);


%{
for i = 1:length(Position)
   if sum(Borig(Position(i),:)) > 0
       Inbubble(i) = 1;
   else
       Inbubble(i) = 0;
   end
end
%}


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