%base parameters
Runs = 20;
%Death probability
Death_Prop = [0.00161,0.00695,0.0309,0.0844,0.161,0.595,1.93,4.28,7.8]./100;

%base tau values
tauLS = 0.5*[0.31 0.69 1.72]; tauWar = 0.5*[0 0.541 0];
%base epsilon values - LSHTM
%R = 0.8
epsLS1 = [1.29 1.13 0.925];
%R = 0.7
epsLS2 = [0 0.955 0];
%R = 0.9
epsLS3 = [0 1.31 0];
%mean-field at individual level
epsLS4 = [0 0.55 0];
%base epsilon values - Warwick
epsWar = [0 0.525 0];

%Relative Chance of infection parameters, in 10 year age bands
RelInfLS = [0.5 0.5 1 1 1 1 1 1 1]; RelInfWar = [0.79 0.79 1 1 1 1 1.25 1.25 1.25];
RelInfM = [RelInfLS; RelInfLS; RelInfLS; RelInfLS; RelInfLS; RelInfLS; RelInfLS; RelInfLS; RelInfLS; RelInfLS; RelInfLS; RelInfLS; RelInfLS; RelInfLS; RelInfLS; RelInfWar; RelInfWar;RelInfWar; RelInfWar; RelInfWar; RelInfWar; RelInfWar; RelInfWar; RelInfWar; RelInfLS; RelInfLS; RelInfLS; RelInfLS; RelInfLS; RelInfLS];  

%Relative transmissibility parameters, in 10 year age bands
RelTransLS = ones(1,9); RelTransWar = [0.64 0.64 1 1 1 1 2.9 2.9 2.9];
RelTransM = [RelTransLS; RelTransLS; RelTransLS; RelTransLS; RelTransLS; RelTransLS; RelTransLS; RelTransLS; RelTransLS; RelTransLS; RelTransLS; RelTransLS; RelTransLS; RelTransLS; RelTransLS; RelTransWar; RelTransWar;RelTransWar; RelTransWar; RelTransWar; RelTransWar; RelTransWar; RelTransWar; RelTransWar; RelTransLS; RelTransLS; RelTransLS; RelTransLS; RelTransLS; RelTransLS];  

%set tauH values
tauH = [tauLS tauLS tauLS tauLS tauLS tauWar tauWar tauWar tauLS tauLS];
%set tauB values
tauB = [0.1*tauLS 0.5*tauLS  tauLS 0.5*tauLS 0.5*tauLS  0.1*tauWar 0.5*tauWar tauWar 0.5*tauLS 0.5*tauLS];
%set epsilon values 
eps = [epsLS1 epsLS1 epsLS1 epsLS2 epsLS3 epsWar epsWar epsWar epsLS4 epsLS1];

load('FullCensusHouseholdWorkspace.mat');

transmissiontype = 'freq';

for k = 1:9
    DeathPropAge(Age == k) = Death_Prop(k);
end

%Set i = 5 for base parameters; for other sets of parameters set diffeent i
% For different parameter set description see 'MainCode.m'
i = 5; 
RelInf = RelInfM(i,:);
RelTrans = RelTransM(i,:);   
%Epsilons for this figure
eps = 0.9 + 0.05*(0:20);


for j = 1:Runs

    tic
    %Prune Matrices
    NewH = PruneMatrixFull(H, tauH(5), 'H',  Age, RelTrans, RelInf, transmissiontype);
    NewB1 = PruneMatrixFull(B1, tauB(5), 'B', Age, RelTrans, RelInf, transmissiontype);    
    NewB2 = PruneMatrixFull(B2, tauB(5), 'B', Age, RelTrans, RelInf, transmissiontype);
    NewB3 = PruneMatrixFull(B3, tauB(5), 'B', Age, RelTrans, RelInf, transmissiontype);          
    NewB4 = PruneMatrixFull(B4, tauB(5), 'B', Age, RelTrans, RelInf, transmissiontype);  
    NewB5 = NewB1+NewB3;
    NewB6 = PruneMatrixFull(B6, tauB(5), 'B', Age, RelTrans, RelInf, transmissiontype);  
    NewBc2 = RewirePrunedMatrix(NewB6, 1, 'C2');
    NewBc3 = RewirePrunedMatrix(NewB6, 1, 'C3');
   
    
    randnum = randi(length(H));
    
    for i = 1:length(eps)
        i
        
               
        if j == 1
            [~, ~, ~, Igen] = InfectionProcessIndividual(NewH, eps(i), C, 50,Age,RelTrans,RelInf,Death_Prop, randnum);
            Initc1(i) = round(0.01*50/(Igen(4)/length(H)));
            [~, ~, ~, Igen] = InfectionProcessIndividual(NewH + NewB1, eps(i), C, 50,Age,RelTrans,RelInf,Death_Prop, randnum);
            Init1(i) = round(0.01*50/(Igen(4)/length(H)));
            [~, ~, ~, Igen] = InfectionProcessIndividual(NewH + NewB2, eps(i), C, 50,Age,RelTrans,RelInf,Death_Prop, randnum);
            Init2(i) = round(0.01*50/(Igen(4)/length(H)));
            [~, ~, ~, Igen] = InfectionProcessIndividual(NewH + NewB3, eps(i), C, 50,Age,RelTrans,RelInf,Death_Prop, randnum);
            Init3(i) = round(0.01*50/(Igen(4)/length(H)));
            [~, ~, ~, Igen] = InfectionProcessIndividual(NewH + NewB4, eps(i), C, 50,Age,RelTrans,RelInf,Death_Prop, randnum);
            Init4(i) = round(0.01*50/(Igen(4)/length(H)));
            [~, ~, ~, Igen] = InfectionProcessIndividual(NewH + NewB5, eps(i), C, 50,Age,RelTrans,RelInf,Death_Prop, randnum);
            Init5(i) = round(0.01*50/(Igen(4)/length(H)));           
            [~, ~, ~, Igen] = InfectionProcessIndividual(NewH + NewB6, eps(i), C, 50,Age,RelTrans,RelInf,Death_Prop, randnum);            
            Init6(i) = round(0.01*50/(Igen(4)/length(H)));
            [~, ~, ~, Igen] = InfectionProcessIndividual(NewH + NewBc2, eps(i), C, 50,Age,RelTrans,RelInf,Death_Prop, randnum);
            Initc2(i) = round(0.01*50/(Igen(4)/length(H)));
            [~, ~, ~, Igen] = InfectionProcessIndividual(NewH + NewBc3, eps(i), C, 50,Age,RelTrans,RelInf,Death_Prop, randnum);
            Initc3(i) = round(0.01*50/(Igen(4)/length(H)));
        end
        
        
        %Infection Processes        
        [~, RSize, Rgen, Igen, Deaths] = InfectionProcessIndividual(NewH, eps(i), C, Initc1(i),Age,RelTrans,RelInf,Death_Prop, randnum);
        Rc1(j,i) = RSize; Prevc1(j,i) = Igen(4)/length(H); Checkc1(j,i) = abs(Rgen(5) - Rgen(4))/Rgen(4); Dc1(j,i) = Deaths;

        [~, RSize, Rgen, Igen, Deaths] = InfectionProcessIndividual(NewH + NewB1, eps(i), C, Init1(i),Age,RelTrans,RelInf,Death_Prop, randnum);
        R1(j,i) = RSize; Prev1(j,i) = Igen(4)/length(H); Check1(j,i) = abs(Rgen(5) - Rgen(4))/Rgen(4); D1(j,i) = Deaths;
        
        [~, RSize, Rgen, Igen, Deaths] = InfectionProcessIndividual(NewH + NewB2, eps(i), C, Init2(i),Age,RelTrans,RelInf,Death_Prop, randnum);
        R2(j,i) = RSize; Prev2(j,i) = Igen(4)/length(H); Check2(j,i) = abs(Rgen(5) - Rgen(4))/Rgen(4); D2(j,i) = Deaths;
        
        [~, RSize, Rgen, Igen, Deaths] = InfectionProcessIndividual(NewH + NewB3, eps(i), C, Init3(i),Age,RelTrans,RelInf,Death_Prop, randnum);
        R3(j,i) = RSize; Prev3(j,i) = Igen(4)/length(H); Check3(j,i) = abs(Rgen(5) - Rgen(4))/Rgen(4); D3(j,i) = Deaths;
        
        [~, RSize, Rgen, Igen, Deaths] = InfectionProcessIndividual(NewH + NewB4, eps(i), C, Init4(i),Age,RelTrans,RelInf,Death_Prop, randnum);
        R4(j,i) = RSize; Prev4(j,i) = Igen(4)/length(H); Check4(j,i) = abs(Rgen(5) - Rgen(4))/Rgen(4); D4(j,i) = Deaths;
                
        [~, RSize, Rgen, Igen, Deaths] = InfectionProcessIndividual(NewH + NewB5, eps(i), C, Init5(i),Age,RelTrans,RelInf,Death_Prop, randnum);
        R5(j,i) = RSize; Prev5(j,i) = Igen(4)/length(H); Check5(j,i) = abs(Rgen(5) - Rgen(4))/Rgen(4); D5(j,i) = Deaths;
        
        [~, RSize, Rgen, Igen, Deaths] = InfectionProcessIndividual(NewH + NewB6, eps(i), C, Init6(i),Age,RelTrans,RelInf,Death_Prop, randnum);
        R6(j,i) = RSize; Prev6(j,i) = Igen(4)/length(H); Check6(j,i) = abs(Rgen(5) - Rgen(4))/Rgen(4); D6(j,i) = Deaths;

        [~, RSize, Rgen, Igen, Deaths] = InfectionProcessIndividual(NewH + NewBc2, eps(i), C, Initc2(i),Age,RelTrans,RelInf,Death_Prop, randnum);
        Rc2(j,i) = RSize; Prevc2(j,i) = Igen(4)/length(H); Checkc2(j,i) = abs(Rgen(5) - Rgen(4))/Rgen(4); Dc2(j,i) = Deaths;
        
        [~, RSize, Rgen, Igen, Deaths] = InfectionProcessIndividual(NewH + NewBc3, eps(i), C, Initc3(i),Age,RelTrans,RelInf,Death_Prop, randnum);
        Rc3(j,i) = RSize; Prevc3(j,i) = Igen(4)/length(H); Checkc3(j,i) = abs(Rgen(5) - Rgen(4))/Rgen(4); Dc3(j,i) = Deaths;
    end
    
    toc
       
end



