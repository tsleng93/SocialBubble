function [EpiSize, RSize, Rgen, Igen, Deaths, Indiv_Infected] = InfectionProcessIndividual2(M, eps, C, Infect_0,A,RelTrans,RelInf,Death_Prop, randnum)

%This function simulates multiple epidemics on a population with connection
%given by M which is a pruned adjacency matrix. The parameters of the
%epidemic is given from the variables passed to the function.

%It differs from InfectionProcessIndividual only in that it also stores a 
%vector of the mean number of infections for each individual, which slows
%down computational speed

rng(randnum);

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
%   - Indiv_Infected is a vector of the mean number of infections for each
%   individual, from the 4th to the 9th generation


%Authors: Trystan Leng, Connor White and Matt Keeling.
%Last update 13/08/2020.


N = length(M);

L = length(RelTrans); 



for j = 1:L
    RelInf_Vec(A==j) = RelInf(j);   
    RelTrans_Vec(A==j) = RelTrans(j);        
end


%z_K is contact rate
%z_T is relative transmissibility
%z_C is relative susceptibility
z_K = 1./C;
z_T = RelTrans_Vec;
z_C = RelInf_Vec;



Left = eps*(z_C.*z_K);

RightNum = z_T.*z_K;
RightDenom = sum(z_K);


  
    R = NaN(1000, 9);
    Iloop = NaN(1000, 9);
    for loop=1:1000
        I=zeros(N,1); 
       
        
        %Randomly seed initial infecteds     
        rI = rand(1, Infect_0);
        rprobs = cumsum(Left)/sum(Left);
        
        
        for k = 1:Infect_0
            I(find(rprobs > rI(k), 1 , 'first')) = 1;
        end
        
        old_n=0; n=Infect_0;
        old_I = zeros(length(I),1);

        n_Vec = zeros(1,L);
        old_n_Vec = zeros(1,L);
        
        for j = 1:L       
           n_Vec(j) = sum(A(I==1)==j);      
        end
        
        counter = 1;
        
        %add this in case n_Vec_4 isn't defined
        n_Vec4 = 0;
        
        
        while n>old_n & counter < 10
            
            
            new_infections = n-old_n;            
            new_infections_I = I - old_I;
         

            I_prev = old_I;
            old_I = I;
            old_n=n;
            old_n_Vec = n_Vec;
            
            I=sign(M*new_infections_I + I_prev);
           
            %if RelInf effects rates
            Jrate = Left*sum(RightNum.*new_infections_I')/RightDenom;
            J = 1 - exp(-Jrate);            
            r = rand(size(J));
            I(r<J) = 1;
            

         
            n=sum(I);
            %calculate number of each
            for i = 1:L
               n_Vec(i) = sum(I.*(A==i)');               
            end
            
            if counter == 4
                n_Vec4 = n_Vec;
                I4 = I;
            end
                      
            R(loop, counter) = (n - old_n)/new_infections*(N/(N-old_n));
            Iloop(loop, counter) = old_n;
            counter = counter+1;            
            
        end
        
        Num_Infected(loop)=n;        
        Vec_Infected(loop,:) = n_Vec - n_Vec4;       
        I_matrix(loop,:) = (I-I4);
        
    end
    EpiSize=mean(Num_Infected(Num_Infected>20))/N;
    
    
    for i = 1:size(R,2)
       A = R(:,i);       
        A = A(~isnan(A));
        Rgen(i) = mean(A);
        B = Iloop(:,i);
        B = B(~isnan(B));       
        Igen(i) = mean(B);
    end
    
    Vec_Infect_2 = mean(Vec_Infected);   
    Deaths = sum(Death_Prop.*Vec_Infect_2);
    Indiv_Infected = mean(I_matrix);
    RSize = Rgen(4);
