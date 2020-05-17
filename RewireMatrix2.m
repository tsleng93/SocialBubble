function [Mnew, Phi] = RewireMatrix2(M,p)
%Connor's code

    N = length(M);
    
    %working out if the matrix is household or not.
    if trace(M) > 0
        M = triu(M) - speye(N,N); %consider only upper triangular and remove diagonal
        Type = 'H';
    else
        M = triu(M);
        Type = 'B';
    end
    
    [x,y]=find(M);   % links without the diagonal.
    
    r = randperm(length(x), round(length(x)*p)); % randomly choose links to swap
    
    %making the length of r even if r is odd
    if mod(length(r),2) ~= 0
        r(end) = [];
    end
    
    while length(r) > 0
        
        X = x(r(1)); Y = y(r(1));
        
        
        if M(X,Y) == 1 %if the link is still there      
        
            nX = 1; nY = 1;
            % this while loop checks that all 4 people are unique
            while length(unique([X Y nX nY]))<4  || M(X,nY) + M(nY,X) + M(nX,Y) + M(Y,nX) >0
                r2 = randi(length(r) - 1) + 1;
               
                nX = x(r(r2)); nY = y(r(r2));
          
     
            end
            
            M(X,Y) = 0; %remove link
            M(nX,nY) =0; %remove link
            
            if X < nY %so that we add link to upper diagonal matrix
                M(X,nY) = 1; %add link
            else
                M(nY, X) = 1;
            end
            
            if nX < Y
                M(nX, Y) = 1; %add link
            else
                M(Y, nX) = 1;
            end
            
            %deleting used r elements
            %need to delete this one first as the other way round would
            %change the element that r2 refers to
            r(r2) = [];
            r(1) = [];
            
        end
        
    end

    
    %recover full matrix
    if Type == 'H'
        M = M+M'+speye(N,N);
    elseif Type == 'B'
        M = M + M';
    end
    
    
    
    
    
    
%Find out clustering, only makes sense if M is the household matrix
    if trace(M) > 0
        MM=M-speye(N,N);
    else
        MM = M;
    end
    M2 = MM*MM;
    Triples = sum(sum(M2)) - trace(M2);
    
    %Triangles = trace(M2*M)
    Triangles = sum(M2(MM==1))
    Phi = Triangles/Triples;
    
    Mnew = M;

