function [EpiSize, RSize, Rgen, Igen] = InfectionProcessFull(M, eps, C, Infect_0,A,RelTrans,RelInf)
%Infection Process on a Pruned Matrix


  N = length(M);
  

  
 L = length(RelTrans); 
  
  
    R = [];
    for loop=1:1000
        I=zeros(N,1); I(randperm(N, Infect_0))=1;
        old_n=0; n=Infect_0;
        
        %Number of Children Infected and Adults
        %n_Ch = 0; old_n_Ch = 0;
        %n_Ad = Infect_0; old_n_Ad = 0;
        
        n_Vec = zeros(1,L);
        old_n_Vec = zeros(1,L);
        
        for j = 1:L
           n_Vec(j) = sum(A(I==1)==j);            
        end
        
        
        
        counter = 1;
        while n>old_n %& counter < 10
            
            new_infections = n-old_n;
            
            %{
            new_infections_Ch = n_Ch - old_n_Ch;
            new_infections_Ad = n_Ad - old_n_Ad;
            new_infections_El = n_El - old_n_El;
            
            old_n_Ch = n_Ch;
            old_n_Ad = n_Ad;
            old_n_El = n_El;
            %}          
            new_infections_Vec = n_Vec - old_n_Vec;
            
            
            old_n=n;
            old_n_Vec = n_Vec;
            
            %eps2 is random R0 of infected individuals
            %J =  ones(1,N)*1-exp(-eps*new_infections./(C*N));
            J =  ones(1,N)*1-exp(-eps*(sum(RelTrans.*new_infections_Vec))./(C*N));          
            
            %change relative chance of becoming infected 
            %for children
            %{
            J(A==1) = RelInf(1)*J(A==1);
            %for adults
            J(A==0) = RelInf(2)*J(A==0);
            %for elderly
            J(A==2) = RelInf(3)*J(A==2);
            %}
            for i = 1:L
               J(A==i) = RelInf(i)*J(A==i); 
            end
            
            
            r = rand(size(J));
            I(r<J) = 1;            
            
            I=sign(M*I);
            n=sum(I);
            %caculate number of each
            %{
            n_Ch = sum(I.*Ch');
            n_Ad = sum(I.*Ad');
            n_El = sum(I.*El');
            %}
            for i = 1:L
               n_Vec(i) = sum(I.*(A==i)');               
            end
            
          
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