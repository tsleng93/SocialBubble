function NewM = RemoveChildLinks(M,A, P_c, Type)

%Keep child links from a pruned matrix with probability P_c


if Type == 'H'
    %Keep links from children with probablity P_c

    N = length(M);
    M= M -speye(N,N);
    
    
    
    %Remove child links
     %Multiply M by A, to just be left with children
    [x,y]=find(M.*A');
    r=rand(size(x));
    x(r>P_c)=[]; y(r>P_c)=[];
        
    %Adult links
    [x2, y2] = find(M.*((A==0)'));
    

    %NewM=sparse(x,y,1,N,N)+sparse(y,x,1,N,N)+speye(N,N);
    NewM=sparse([x;x2],[y;y2],1,N,N)+speye(N,N);
    
elseif Type == 'B'
    %Keep links from children with probability P_c
    N = length(M);
    %Multiply M by A, to just be left with children
    [x,y]=find(M*A');
    r=rand(size(x));
    x(r>P_c)=[]; y(r>P_c)=[];
    
    %Adult links
    [x2, y2] = find(M*((A==0)'));


    %NewM=sparse(x,y,1,N,N)+sparse(y,x,1,N,N);    
    NewM=sparse([x;x2],[y;y2],1,N,N);
end
