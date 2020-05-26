function B = BubbleMaker1(M, s, d)
%Only works with households of same size
%M is household matrix
%s is size of bubble
%d is proportion of households who form bubbles

A = sum(M);
HouseholdSize = A(1);

B = [];

NumBubble = (length(M)/(s*HouseholdSize));

    for j = 1:NumBubble
        if j/NumBubble <= d
            B = blkdiag(B,sparse(ones(s*HouseholdSize)));
        else
            B = blkdiag(B,sparse(zeros(s*HouseholdSize)));
        end
        
    end
    
    
B = B-M;
B = (B>0);
