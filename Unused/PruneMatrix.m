function NewM = PruneMatrix(M,tau, Type)

if Type == 'H'
    %Removes links from household with probability P

    P=1-exp(-tau);
    N = length(M);
    %M=triu(M)-speye(N,N);
    M = M - speye(N,N);
    [x,y]=find(M);
    r=rand(size(x));
    x(r>P)=[]; y(r>P)=[];

    %NewM=sparse(x,y,1,N,N)+sparse(y,x,1,N,N)+speye(N,N);
    NewM=sparse(x,y,1,N,N) + speye(N,N);
    
elseif Type == 'B'
    %Removes links from household with probability P
    P=1-exp(-tau);
    N = length(M);
    %M=triu(M);
    [x,y]=find(M);
    r=rand(size(x));
    x(r>P)=[]; y(r>P)=[];

    %NewM=sparse(x,y,1,N,N)+sparse(y,x,1,N,N);    
    NewM = sparse(x,y,1,N,N);
end
