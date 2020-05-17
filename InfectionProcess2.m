function [EpiSize, RSize, Rgen, Igen] = InfectionProcess2(M, eps, C, Infect_0)
%Infection Process on a Pruned Matrix

  N = length(M);
    R = [];
    for loop=1:1000
        I=zeros(N,1); I(randperm(N, Infect_0))=1;
        old_n=0; n=Infect_0;
        
        counter = 1;
        while n>old_n %& counter < 10
            
            new_infections = n-old_n;
            old_n=n;
            
            %eps2 is random R0 of infected individuals
            J =  ones(1,N)*1-exp(-eps*new_infections./(C*N));
            r = rand(size(J));
            I(r<J) = 1;            
            
            I=sign(M*I);
            n=sum(I);
           
            R(loop, counter) = (n - old_n)/new_infections*(N/(N-old_n));
            Iloop(loop, counter) = old_n;
            counter = counter+1;
        end
        
        Num_Infected(loop)=n;

        
    end
    EpiSize=mean(Num_Infected(Num_Infected>20))/N;
    
    
    for i = 1:size(R,2)
        A = R(:,i);
        %A = A(~isnan(A));
        %A = A(A~=0);
        Rgen(i) = mean(A);
        B = Iloop(:,i);
        %B = B(~isnan(A));
        %B = B(B~=0);
        Igen(i) = mean(B);
    end
    
    RSize = Rgen(5);