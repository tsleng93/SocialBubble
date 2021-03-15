%Scenario 1 - LSHTM parameters, tauB = 0.1 tauH, SAR 10%, R = 0.8
%Scenario 2 - LSHTM parameters, tauB = 0.1 tauH, SAR 20%, R = 0.8
%Scenario 3 - LSHTM parameters, tauB = 0.1 tauH, SAR 40%, R = 0.8
%Scenario 4 - LSHTM parameters, tauB = 0.5 tauH, SAR 10%, R = 0.8
%Scenario 5 - LSHTM parameters, tauB = 0.5 tauH, SAR 20%, R = 0.8
%Scenario 6 - LSHTM parameters, tauB = 0.5 tauH, SAR 40%, R = 0.8
%Scenario 7 - LSHTM parameters, tauB = tauH, SAR 10%, R = 0.8
%Scenario 8 - LSHTM parameters, tauB = tauH, SAR 20%, R = 0.8
%Scenario 9 - LSHTM parameters, tauB = tauH, SAR 40%, R = 0.8

%Scenario 10 - LSHTM parameters, tauB = 0.5 tauH, SAR 10%, R = 0.7
%Scenario 11 - LSHTM parameters, tauB = 0.5 tauH, SAR 20%, R = 0.7
%Scenario 12 - LSHTM parameters, tauB = 0.5 tauH, SAR 40%, R = 0.7
%Scenario 13 - LSHTM parameters, tauB = 0.5 tauH, SAR 10%, R = 0.9
%Scenario 14 - LSHTM parameters, tauB = 0.5 tauH, SAR 20%, R = 0.9
%Scenario 15 - LSHTM parameters, tauB = 0.5 tauH, SAR 40%, R = 0.9

%Scenario 16 - Warwick parameters, tauB = 0.1 tauH, SAR 10%, R = 0.8
%Scenario 17 - Warwick parameters, tauB = 0.1 tauH, SAR 20%, R = 0.8
%Scenario 18 - Warwick parameters, tauB = 0.1 tauH, SAR 40%, R = 0.8
%Scenario 19 - Warwick parameters, tauB = 0.5 tauH, SAR 10%, R = 0.8
%Scenario 20 - Warwick parameters, tauB = 0.5 tauH, SAR 20%, R = 0.8
%Scenario 21 - Warwick parameters, tauB = 0.5 tauH, SAR 40%, R = 0.8
%Scenario 22 - Warwick parameters, tauB = tauH, SAR 10%, R = 0.8
%Scenario 23 - Warwick parameters, tauB = tauH, SAR 20%, R = 0.8
%Scenario 24 - Warwick parameters, tauB = tauH, SAR 40%, R = 0.8

%Scenario 25 - LSHTM parameters, mean-field at individual level, tauB = 0.5 tauH, SAR 10%, R = 0.8
%Scenario 26 - LSHTM parameters, mean-field at individual level, tauB = 0.5 tauH, SAR 20%, R = 0.8
%Scenario 27 - LSHTM parameters, mean-field at individual level, tauB = 0.5 tauH, SAR 40%, R = 0.8

%Scenario 28 - LSHTM parameters, non-compliance, tauB = 0.5 tauH, SAR 10%, R = 0.8
%Scenario 29 - LSHTM parameters, non-compliance, tauB = 0.5 tauH, SAR 20%, R = 0.8
%Scenario 30 - LSHTM parameters, non-compliance, tauB = 0.5 tauH, SAR 40%, R = 0.8
%Final scenarios used in paper - 2,4,5,6,7,11,40,20,26,29






%base tau values
%tauLS = [0.31 0.69 1.72]; tauWar = [0 0.541 0];
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
RelInfM = [RelInfLS; RelInfLS; RelInfLS; RelInfLS; RelInfLS; RelInfLS; RelInfLS; RelInfLS; RelInfLS; RelInfLS; RelInfLS; RelInfLS; RelInfLS; RelInfLS; RelInfLS; RelInfWar; RelInfWar;RelInfWar; RelInfWar; RelInfWar; RelInfWar; RelInfWar; RelInfWar; RelInfWar; RelInfLS; RelInfLS; RelInfLS; RelInfLS; RelInfLS; RelInfLS; RelInfLS; RelInfLS; RelInfLS];  

%Relative Transmissibility paramaters, in 10 years age bands
RelTransLS = ones(1,9); RelTransWar = [0.64 0.64 1 1 1 1 2.9 2.9 2.9];
RelTransM = [RelTransLS; RelTransLS; RelTransLS; RelTransLS; RelTransLS; RelTransLS; RelTransLS; RelTransLS; RelTransLS; RelTransLS; RelTransLS; RelTransLS; RelTransLS; RelTransLS; RelTransLS; RelTransWar; RelTransWar;RelTransWar; RelTransWar; RelTransWar; RelTransWar; RelTransWar; RelTransWar; RelTransWar; RelTransLS; RelTransLS; RelTransLS; RelTransLS; RelTransLS; RelTransLS; RelTransLS; RelTransLS; RelTransLS];  

%set tauH values
tauH = [tauLS tauLS tauLS tauLS tauLS tauWar tauWar tauWar tauLS tauLS tauLS];
%set tauB values
tauB = [0.1*tauLS 0.5*tauLS  tauLS 0.5*tauLS 0.5*tauLS  0.1*tauWar 0.5*tauWar tauWar 0.5*tauLS 0.5*tauLS 0.5*tauLS];
%set epsilon values 
eps = [epsLS1 epsLS1 epsLS1 epsLS2 epsLS3 epsWar epsWar epsWar epsLS4 epsLS1 epsLS1];
load('FullCensusHouseholdWorkspace.mat');

%original C
Corig = C;
%for individual based mean field
Cindiv = ones(1,length(C));


Runs = 10;
transmissiontype = 'freq';

%Scenarios used for the paper
i = 5;
tauH = tauH(i);
tauB = tauB(i);
eps = eps(i);
RelInf = RelInfM(i,:);
RelTrans = RelTransM(i,:);

if i > 25 && i < 28
   C = Cindiv; 
else
   C = Corig;
end

for j = 1:Runs
    tic
    %Scenario c1
    [NewH, SAR] = PruneMatrixFull(H, tauH, 'H',  Age, RelTrans, RelInf, transmissiontype);
    SARs(j) = SAR;
    
    for k = 1:3
        randnum = randi(length(H));
     
        if k == 1        
            NewB1 = PruneMatrixFull(B1, tauB, 'B',  Age, RelTrans, RelInf, transmissiontype);
            NewB2 = PruneMatrixFull(B2, tauB, 'B',  Age, RelTrans, RelInf, transmissiontype);
            NewB3 = PruneMatrixFull(B3, tauB, 'B',  Age, RelTrans, RelInf, transmissiontype); 
            %B5 sum done afterwards
            NewB4 = PruneMatrixFull(B4, tauB, 'B',  Age, RelTrans, RelInf, transmissiontype);
            NewB6 = PruneMatrixFull(B6, tauB, 'B',  Age, RelTrans, RelInf, transmissiontype);
     
        elseif k == 2
           NewB1 = RewirePrunedMatrix(NewB1, 1, 'C2');
           NewB2 = RewirePrunedMatrix(NewB2, 1, 'C2');
           %B3 remains the same
           NewB4 = RewirePrunedMatrix(NewB4, 1, 'C2');
           %B5 sum done afterwards
           NewB6 = RewirePrunedMatrix(NewB6, 1, 'C2');
           
        elseif k == 3
            NewB1 = RewirePrunedMatrix(NewB1, 1, 'C3');
            NewB2 = RewirePrunedMatrix(NewB2, 1, 'C3');
            NewB3 = RewirePrunedMatrix(NewB3, 1, 'C3');
            NewB4 = RewirePrunedMatrix(NewB4, 1, 'C3');
            %B5 sum done afterwards
            NewB6 = RewirePrunedMatrix(NewB6, 1, 'C3');
        end
        
        NewB5 = NewB1 + NewB3;
        
        if j == 1
            %Run initial scenarios to ascertain initial values
            
            if k == 1
                [~, ~, ~, Igen] = InfectionProcessIndividual(NewH, eps, C, 50,Age,RelTrans,RelInf,Death_Prop, randnum);
                Initc1 = round(0.01*50/(Igen(4)/length(H)));
            end
            
            [~, ~, ~, Igen] = InfectionProcessIndividual(NewH + NewB1, eps, C, 50,Age,RelTrans,RelInf,Death_Prop, randnum);
            Init1(k) = round(0.01*50/(Igen(4)/length(H)));
            [~, ~, ~, Igen] = InfectionProcessIndividual(NewH + NewB2, eps, C, 50,Age,RelTrans,RelInf,Death_Prop, randnum);
            Init2(k) = round(0.01*50/(Igen(4)/length(H)));
            [~, ~, ~, Igen] = InfectionProcessIndividual(NewH + NewB3, eps, C, 50,Age,RelTrans,RelInf,Death_Prop, randnum);
            Init3(k) = round(0.01*50/(Igen(4)/length(H)));
            [~, ~, ~, Igen] = InfectionProcessIndividual(NewH + NewB4, eps, C, 50,Age,RelTrans,RelInf,Death_Prop, randnum);
            Init4(k) = round(0.01*50/(Igen(4)/length(H)));
            [~, ~, ~, Igen] = InfectionProcessIndividual(NewH + NewB5, eps, C, 50,Age,RelTrans,RelInf,Death_Prop, randnum);
            Init5(k) = round(0.01*50/(Igen(4)/length(H)));                     
            [~, ~, ~, Igen] = InfectionProcessIndividual(NewH + NewB6, eps, C, 50,Age,RelTrans,RelInf,Death_Prop, randnum);            
            Init6(k) = round(0.01*50/(Igen(4)/length(H)));
            

        end
        
        %Infection Processes        
        [~, RSize, Rgen, Igen, Deaths] = InfectionProcessIndividual(NewH, eps, C, Initc1,Age,RelTrans,RelInf,Death_Prop, randnum);
        Rc1(j,k) = RSize; Prevc1(j,k) = Igen(4)/length(H); Checkc1(j,k) = abs(Rgen(5) - Rgen(4))/Rgen(4); Dc1(j,k) = Deaths;

        [~, RSize, Rgen, Igen, Deaths] = InfectionProcessIndividual(NewH + NewB1, eps, C, Init1(k),Age,RelTrans,RelInf,Death_Prop, randnum);
        R1(j,k) = RSize; Prev1(j,k) = Igen(4)/length(H); Check1(j,k) = abs(Rgen(5) - Rgen(4))/Rgen(4); D1(j,k) = Deaths;
        
        [~, RSize, Rgen, Igen, Deaths] = InfectionProcessIndividual(NewH + NewB2, eps, C, Init2(k),Age,RelTrans,RelInf,Death_Prop, randnum);
        R2(j,k) = RSize; Prev2(j,k) = Igen(4)/length(H); Check2(j,k) = abs(Rgen(5) - Rgen(4))/Rgen(4); D2(j,k) = Deaths;
        
        [~, RSize, Rgen, Igen, Deaths] = InfectionProcessIndividual(NewH + NewB3, eps, C, Init3(k),Age,RelTrans,RelInf,Death_Prop, randnum);
        R3(j,k) = RSize; Prev3(j,k) = Igen(4)/length(H); Check3(j,k) = abs(Rgen(5) - Rgen(4))/Rgen(4); D3(j,k) = Deaths;
        
        [~, RSize, Rgen, Igen, Deaths] = InfectionProcessIndividual(NewH + NewB4, eps, C, Init4(k),Age,RelTrans,RelInf,Death_Prop, randnum);
        R4(j,k) = RSize; Prev4(j,k) = Igen(4)/length(H); Check4(j,k) = abs(Rgen(5) - Rgen(4))/Rgen(4); D4(j,k) = Deaths;                
        [~, RSize, Rgen, Igen, Deaths] = InfectionProcessIndividual(NewH + NewB5, eps, C, Init5(k),Age,RelTrans,RelInf,Death_Prop, randnum);
        R5(j,k) = RSize; Prev5(j,k) = Igen(4)/length(H); Check5(j,k) = abs(Rgen(5) - Rgen(4))/Rgen(4); D5(j,k) = Deaths;
     
        [~, RSize, Rgen, Igen, Deaths] = InfectionProcessIndividual(NewH + NewB6, eps, C, Init6(k),Age,RelTrans,RelInf,Death_Prop, randnum);
        R6(j,k) = RSize; Prev6(j,k) = Igen(4)/length(H); Check6(j,k) = abs(Rgen(5) - Rgen(4))/Rgen(4); D6(j,k) = Deaths;


    end
    
    toc
end

Dc1 = mean(mean(Dc1));

if j > 1
    D1 = mean(D1); D2 = mean(D2); D3 = mean(D3); D4 = mean(D4); D5 = mean(D5); D6 = mean(D6); 
end

Fig7Table(1,:) = [D1/Dc1, max(1 - D1(1)/D1(2), 0), max(1 - D1(1)/D1(3),0)]; 
Fig7Table(2,:) = [D2/Dc1, max(1 - D2(1)/D2(2), 0), max(1 - D2(1)/D2(3), 0)];
Fig7Table(3,:) = [D3/Dc1, max(1 - D3(1)/D3(2), 0), max(1 - D3(1)/D3(3), 0)]; 
Fig7Table(4,:) = [D4/Dc1, max(1 - D4(1)/D4(2), 0), max(1 - D4(1)/D4(3), 0)];
Fig7Table(5,:) = [D5/Dc1, max(1 - D5(1)/D5(2), 0), max(1 - D5(1)/D5(3), 0)]; 
Fig7Table(6,:) = [D6/Dc1, max(1 - D6(1)/D6(2), 0), max(1 - D6(1)/D6(3), 0)];

bar([Fig7Table(:, 4:5)])

