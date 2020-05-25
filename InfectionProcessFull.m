function [EpiSize, RSize, Rgen, Igen, Deaths] = InfectionProcessFull(M, eps, C, Infect_0,A,RelTrans,RelInf)
%Infection Process on a Pruned Matrix

N = length(M);

L = length(RelTrans); 



for j = 1:L
    RelInf_Vec(A==j) = RelInf(j);          
end

%Make initial infection probabilities
%Init_Infect = RelInf_Vec./C;
 
 
  
  
    R = [];
    for loop=1:100
        I=zeros(N,1); 
        %{
        Init_Infect_2 = Init_Infect;
        CumInit = cumsum(Init_Infect_2)/sum(Init_Infect_2);
        
        for k = 1:Infect_0
            r = rand;
            f = find(CumInit>r, 1);
            I(f) = 1;
            Init_Infect_2(f) = 0;
            CumInit = cumsum(Init_Infect_2)/sum(Init_Infect_2);            
        end
        %}
        I(randperm(N, Infect_0))=1;
        
        
        old_n=0; n=Infect_0;
        
        %Number of Children Infected and Adults
        n_Vec = zeros(1,L);
        old_n_Vec = zeros(1,L);
        
        for j = 1:L
           n_Vec(j) = sum(A(I==1)==j);            
        end
        
        
        
        counter = 1;
        while n>old_n & counter < 10
            
            new_infections = n-old_n;
            
            new_infections_Vec = n_Vec - old_n_Vec;
            
            
            old_n=n;
            old_n_Vec = n_Vec;
           
            
             
            
            %if RelInf effects rates
            J = (1-exp(-eps*(sum(RelTrans.*new_infections_Vec)/N).*(RelInf_Vec./C))); 
            
            
            %if RelInf effects probabilties
            %J =  ones(1,N)*1-exp(-eps*(sum(RelTrans.*new_infections_Vec))./(C*N));
            %If Relinf effects probabilities
            %for i = 1:L
            %   J(A==i) = RelInf(i)*J(A==i); 
            %end
            
            
            r = rand(size(J));
            I(r<J) = 1;            
            
            I=sign(M*I);
            n=sum(I);
            %caculate number of each
            for i = 1:L
               n_Vec(i) = sum(I.*(A==i)');               
            end
                      
            R(loop, counter) = (n - old_n)/new_infections*(N/(N-old_n));
            %R(loop, counter) = (n - old_n)/new_infections;
            Iloop(loop, counter) = old_n;
            counter = counter+1;            
            
        end
        
        Num_Infected(loop)=n;
        
        Vec_Infected(loop,:) = n_Vec;

        
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
    
    Vec_Infect_2 = mean(Vec_Infected);
   
    Deaths = (0.005/100)*sum(Vec_Infect_2(1:4)) + (0.22/100)*sum(Vec_Infect_2(5:8)) + (4.67/100)*sum(Vec_Infect_2(9:10));
    
    RSize = Rgen(4);
