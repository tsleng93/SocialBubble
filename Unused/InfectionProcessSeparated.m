function [EpiSize, RSize, Rgen, Igen, Deaths] = InfectionProcessSeparated(M, eps, C, Infect_0,A,RelTrans,RelInf,Death_Prop, B, ceps)

%This function simulates multiple epidemics on a population with connection
%given by M which is a pruned adjacency matrix. The parameters of the
%epidemic is given from the variables passed to the function.


%Input:
%   - M is the adjacency matrix on which has been pruned.
%   - eps is the community infection pressure transmission rate.
%   - C is a vector which conatains the size of household each indiviual
%   belongs to.
%   - Infect_0 is the intitial number of infected people when we start the
%   simulation.
%   - A is a vector which store the age group each individual in the
%   population belongs to.
%   - RelTrans scales the the rate an individual transmits infection, 
%   dependent on their age group.
%   - RelInf scales the rate of transmission to an individual (i.e. their 
%   rate of infection) dependent on their age group.
%   - Death_Prop is the proportion of people who die when infected and is
%   age dependent.

%Output:
%   - EpiSize is the average number of people infected from each
%   simulation.
%   - Rsize is what we use as the actual value for R which is the 4th
%   - element of Rgen. 
%   - Rgen is the average size of R for each time step in the simulations.
%   - Igen is the average number of people infected at each timestep from
%   each simulation.
%   - Deaths is the average number of deaths from each simulation.


%Authors: Trystan Leng, Connor White and Matt Keeling.
%Last update 29/05/2020.

N = length(M);

L = length(RelTrans); 


Ceps(sum(B) > 0) = ceps;
Ceps(sum(B) == 0) = 1;




for j = 1:L
    RelInf_Vec(A==j) = RelInf(j);   
    RelTrans_Vec(A==j) = RelTrans(j);        
end

CR2 = Ceps.*RelTrans_Vec;
CR1 = (RelInf_Vec./C);
CR3 = eps*Ceps.*CR1;
SumC = sum(Ceps);

  
    R = [];
    for loop=1:100
        I=zeros(N,1); 
       
        I(randperm(N, Infect_0))=1;
        
        
        old_n=0; n=Infect_0;
        
        old_I = zeros(length(I),1);
        
        %Number of Children Infected and Adults
        n_Vec = zeros(1,L);
        old_n_Vec = zeros(1,L);
        
        for j = 1:L
        end
        
           n_Vec(j) = sum(A(I==1)==j);            
        
        
        counter = 1;
        
        %add this in case n_Vec_4 isn't defined
        n_Vec4 = 0;
        
        while n>old_n & counter < 10
            
            new_infections = n-old_n;
            new_infections_Vec = n_Vec - old_n_Vec;
            
            new_infections_I = I - old_I;
            
            
            old_I = I;
            old_n=n;
            old_n_Vec = n_Vec;
           
            %if RelInf effects rates
            J = (1-exp(-CR3*(sum(CR2'.*new_infections_I)/SumC)));
            
            r = rand(size(J));
            I(r<J) = 1;            
            
            I=sign(M*I);
            n=sum(I);
            %caculate number of each
            for i = 1:L
               n_Vec(i) = sum(I.*(A==i)');               
            end
            
            if counter == 4
                n_Vec4 = n_Vec;
            end
                      
            R(loop, counter) = (n - old_n)/new_infections*(N/(N-old_n));
            Iloop(loop, counter) = old_n;
            counter = counter+1;            
            
        end
        
        Num_Infected(loop)=n;
        
        Vec_Infected(loop,:) = n_Vec - n_Vec4;

        
    end
    EpiSize=mean(Num_Infected(Num_Infected>20))/N;
    
    
    for i = 1:size(R,2)
        A = R(:,i);
        Rgen(i) = mean(A);
        B = Iloop(:,i);
        Igen(i) = mean(B);
    end
    
    Vec_Infect_2 = mean(Vec_Infected);
   
    Deaths = sum(Death_Prop.*Vec_Infect_2);

    RSize = Rgen(4);
