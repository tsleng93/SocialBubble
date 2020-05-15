function [Mnew, Phi] = RewireMatrix(M,p)


    N = length(M);

    [x,y]=find(M - speye(N,N));   % links without the diagonal.
    for i=1:(length(x)*p/2)   % as we are picking links in both directions.
        X=0; Y=0; nX=0; nY=0; 
        while length(unique([X Y nX nY]))<4 %|| Marker1 == 0 || Marker2 > 0
            m=ceil(length(x)*rand(1,1));
            X=x(m); Y=y(m);
            n=ceil(length(x)*rand(1,1));
            nX=x(n); nY=y(n);
            
            if M(X,nY) == 1 || M(nX,Y) == 1 || M(X,Y) == 0 || M(nX,nY) ==0 || length(unique([X Y nX nY]))<4
               X = 0; Y = 0; nX  = 0; nY = 0; 
            else      
               M(X,Y)=0; M(Y,X)=0; M(nX,nY)=0; M(nY,nX)=0;
            
               M(X,nY)=1; M(nY,X)=1; M(nX,Y)=1; M(Y,nX)=1;
               %update x and y
               [x,y]=find(M - speye(N,N));   % links without the diagonal.
               
            end
        end
    end 
       
    %% THIS BIT DOES CLUSTERING BUT ONLY WHEN P=1;
    %sum(M)
    if trace(M) > 0
        MM=M-speye(N,N);
    else
        MM = M;
    end
    M2 = MM*MM;
    Triples = sum(sum(M2)) - trace(M2);
    
    %Triangles = trace(MM*M2);
    Triangles = sum(M2(MM==1));
    Phi = Triangles/Triples;
    
    Mnew = M;





end