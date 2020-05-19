function [EpiSize, RSize, Rgen, Igen] = InfectionProcessChildren(M, eps, C, Infect_0,Ch,Ch_P,Ch_I)
%Infection Process on a Pruned Matrix

  N = length(M);
  %Adults
  Ad = (Ch==0)*1;
    R = [];
    for loop=1:1000
        I=zeros(N,1); I(randperm(N, Infect_0))=1;
        old_n=0; n=Infect_0;
        
        %Number of Children Infected and Adults
        n_Ch = 0; old_n_Ch = 0;
        n_Ad = Infect_0; old_n_Ad = 0;
        counter = 1;
        while n>old_n %& counter < 10
            
            new_infections = n-old_n;
            new_infections_Ch = n_Ch - old_n_Ch;
            new_infections_Ad = n_Ad - old_n_Ad;
            old_n=n;
            old_n_Ch = n_Ch;
            old_n_Ad = n_Ad;
            
           
            %eps2 is random R0 of infected individuals
            %J =  ones(1,N)*1-exp(-eps*new_infections./(C*N));
           
            J =  ones(1,N)*1-exp(-eps*(new_infections_Ad + Ch_I*new_infections_Ch)./(C*N));
            
            %J= J.*(1 - (1-Ch)*Ch_P);
            J(J==1) = Ch_P*J(J==1);
            
            r = rand(size(J));
            I(r<J) = 1;            
            
            I=sign(M*I);
            n=sum(I);
            n_Ch = sum(I.*Ch');
            n_Ad = sum(I.*Ad');
            
            
          
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