function [Mnew, Phi] = RewireMatrix2(M,p, Type)

    N = length(M);
    
    
    if Type == 'H'
        M = triu(M) - speye(N,N); %consider only upper triangular and remove diagonal
    elseif Type == 'B'
        M = triu(M);
    end
    
    [x,y]=find(M);   % links without the diagonal.
    
    r = randperm(length(x), round(length(x)*p)); % randomly choose links to swap
    
    %create second lists that we will update
    x2 = x; y2 = y;
    
    for i = 1:length(r)
        
        X = x(r(i)); Y = y(r(i));
        
        if M(X,Y) == 1 %if the link is still there
            
            nX = 1; nY = 1;
            while length(unique([X Y nX nY]))<4  || M(X,nY) + M(nY,X) + M(nX,Y) + M(Y,nX) >0
                r2 = randi(length(r));
                nX = x2(r(r2)); nY = y2(r(r2));
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
            %reset links of node you can swap with
            [x2,y2] = find(M);
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

