%Running MainCode.m generates the underlying data for Figures 3, 8 and
%Extended Data. After running this, DataMaker.m should be
%run.

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



%Scenarios used for the paper
ScenarioVec = [1 2 3 4 5 6 7 8 9 11 14 20 26];
%ScenarioVec = [1 2 3 4 5 6 7 8 9 11 14 20 26];
%ScenarioVec = [1 2 3 20];
%ScenarioVec = [5];
ScenarioVec2 = 29;
ScenarioVec3 = 32;


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
%Initialise R, Check and D arrays
Rc1 = zeros(Runs, 33); Rc2 = zeros(Runs,33); Rc3 = zeros(Runs,33); R1 = zeros(Runs,30); R2 = zeros(Runs,33); R3 = zeros(Runs,33); R4 = zeros(Runs,33); R5 = zeros(Runs,33); R6 = zeros(Runs,33);
Checkc1 = zeros(Runs, 33); Checkc2 = zeros(Runs,33); Checkc3 = zeros(Runs,33); Check1 = zeros(Runs,33); Check2 = zeros(Runs,33); Check3 = zeros(Runs,33); Check4 = zeros(Runs,33); Check5 = zeros(Runs,33); Check6 = zeros(Runs,30);
Dc1 = zeros(Runs, 33); Dc2 = zeros(Runs,33); Dc3 = zeros(Runs,33); D1 = zeros(Runs,33); D2 = zeros(Runs,33); D3 = zeros(Runs,33); D4 = zeros(Runs,33); D5 = zeros(Runs,33); D6 = zeros(Runs,33);



for i = ScenarioVec
    if i > 25 && i < 28
       C = Cindiv; 
    else
       C = Corig;
    end
    
    
    RelInf = RelInfM(i,:);
    RelTrans = RelTransM(i,:);
    
    tic
    i
    for j = 1:Runs
        randnum = randi(length(H));
        %Prune Matrices
        %Scenario c1
        
        [NewH, SAR] = PruneMatrixFull(H, tauH(i), 'H',  Age, RelTrans, RelInf);
        SARs(j,i) = SAR;
        NewB1 = PruneMatrixFull(B1, tauB(i), 'B',  Age, RelTrans, RelInf);   
        NewB2 = PruneMatrixFull(B2, tauB(i), 'B',  Age, RelTrans, RelInf);
        NewB3 = PruneMatrixFull(B3, tauB(i), 'B',  Age, RelTrans, RelInf);
        NewB4 = PruneMatrixFull(B4, tauB(i), 'B',  Age, RelTrans, RelInf);
        NewB5 = NewB1 + NewB3;
        NewB6 = PruneMatrixFull(B6, tauB(i), 'B',  Age, RelTrans, RelInf);
        NewBc2 = RewirePrunedMatrix(NewB6, 1, 'C2');
        NewBc3 = RewirePrunedMatrix(NewB6, 1, 'C3');
        
        
        if j == 1
            %Run initial scenarios to ascertain initial values
            
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
 %}
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
%}                
        [~, RSize, Rgen, Igen, Deaths] = InfectionProcessIndividual(NewH + NewB5, eps(i), C, Init5(i),Age,RelTrans,RelInf,Death_Prop, randnum);
        R5(j,i) = RSize; Prev5(j,i) = Igen(4)/length(H); Check5(j,i) = abs(Rgen(5) - Rgen(4))/Rgen(4); D5(j,i) = Deaths;
        
        [~, RSize, Rgen, Igen, Deaths] = InfectionProcessIndividual(NewH + NewB6, eps(i), C, Init6(i),Age,RelTrans,RelInf,Death_Prop, randnum);
        R6(j,i) = RSize; Prev6(j,i) = Igen(4)/length(H); Check6(j,i) = abs(Rgen(5) - Rgen(4))/Rgen(4); D6(j,i) = Deaths;

        [~, RSize, Rgen, Igen, Deaths] = InfectionProcessIndividual(NewH + NewBc2, eps(i), C, Initc2(i),Age,RelTrans,RelInf,Death_Prop, randnum);
        Rc2(j,i) = RSize; Prevc2(j,i) = Igen(4)/length(H); Checkc2(j,i) = abs(Rgen(5) - Rgen(4))/Rgen(4); Dc2(j,i) = Deaths;
        
        [~, RSize, Rgen, Igen, Deaths] = InfectionProcessIndividual(NewH + NewBc3, eps(i), C, Initc3(i),Age,RelTrans,RelInf,Death_Prop, randnum);
        Rc3(j,i) = RSize; Prevc3(j,i) = Igen(4)/length(H); Checkc3(j,i) = abs(Rgen(5) - Rgen(4))/Rgen(4); Dc3(j,i) = Deaths;
%}
    end
    
    toc 
end
%}

%Non adherence
Ba1 = NonAdherenceBubble(H, TypeHouse, Position, 0.5);
Ba2 = NonAdherenceBubble(H, (TypeHouse>0), Position, 0.5);
Ba3 = NonAdherenceBubble(H, SizeHouse, Position, 0.5);
Ba4 = ScenarioTypeHouseBubble2(H, NumAdults ==1, Position, zeros(1,length(Position)),0.5);
Ba6 = NonAdherenceBubble(H, ones(1,length(SizeHouse)), Position, 0.5);


for i = ScenarioVec2
    C = Corig;
    RelInf = RelInfM(i,:);
    RelTrans = RelTransM(i,:);
    
    tic
    for j = 1:Runs
        randnum = randi(length(H));
        %Prune Matrices
        [NewH, SAR] = PruneMatrixFull(H, tauH(i), 'H',  Age, RelTrans, RelInf);
        SARs(j,i) = SAR;
        NewB1 = PruneMatrixFull(B1, tauB(i), 'B',  Age, RelTrans, RelInf);
        NewB2 = PruneMatrixFull(B2, tauB(i), 'B',  Age, RelTrans, RelInf);
        NewB3 = PruneMatrixFull(B3, tauB(i), 'B',  Age, RelTrans, RelInf);
        NewB4 = PruneMatrixFull(B4, tauB(i), 'B',  Age, RelTrans, RelInf);
        NewB5 = NewB1 + NewB3;
        NewB6 = PruneMatrixFull(B6, tauB(i), 'B',  Age, RelTrans, RelInf);
        NewBa1 = PruneMatrixFull(Ba1, tauB(i), 'B',  Age, RelTrans, RelInf);
        NewBa2 = PruneMatrixFull(Ba2, tauB(i), 'B',  Age, RelTrans, RelInf);
        NewBa3 = PruneMatrixFull(Ba3, tauB(i), 'B',  Age, RelTrans, RelInf);
        NewBa4 = PruneMatrixFull(Ba4, tauB(i), 'B',  Age, RelTrans, RelInf);
        NewBa5 = NewBa1 + NewBa3;
        NewBa6 = PruneMatrixFull(Ba6, tauB(i), 'B',  Age, RelTrans, RelInf);
        
        if j == 1
            %Run initial scenarios to ascertain initial values
            
            [~, ~, ~, Igen] = InfectionProcessIndividual(NewH, eps(i), C, 50,Age,RelTrans,RelInf,Death_Prop, randnum);
            Initc1(i) = round(0.01*50/(Igen(4)/length(H)));
            [~, ~, ~, Igen] = InfectionProcessIndividual(1*sparse((NewH|NewB1)|NewBa1), eps(i), C, 50,Age,RelTrans,RelInf,Death_Prop, randnum);
            Init1(i) = round(0.01*50/(Igen(4)/length(H)));
            [~, ~, ~, Igen] = InfectionProcessIndividual(1*sparse((NewH|NewB2)|NewBa2), eps(i), C, 50,Age,RelTrans,RelInf,Death_Prop, randnum);
            Init2(i) = round(0.01*50/(Igen(4)/length(H)));
            [~, ~, ~, Igen] = InfectionProcessIndividual(1*sparse((NewH|NewB3)|NewBa3), eps(i), C, 50,Age,RelTrans,RelInf,Death_Prop, randnum);
            Init3(i) = round(0.01*50/(Igen(4)/length(H)));
            [~, ~, ~, Igen] = InfectionProcessIndividual(1*sparse((NewH|NewB4)|NewBa4), eps(i), C, 50,Age,RelTrans,RelInf,Death_Prop, randnum);
            Init4(i) = round(0.01*50/(Igen(4)/length(H)));
            [~, ~, ~, Igen] = InfectionProcessIndividual(1*sparse((NewH|NewB5)|NewBa5), eps(i), C, 50,Age,RelTrans,RelInf,Death_Prop, randnum);
            Init5(i) = round(0.01*50/(Igen(4)/length(H)));           
            [~, ~, ~, Igen] = InfectionProcessIndividual(1*sparse((NewH|NewB6)|NewBa6), eps(i), C, 50,Age,RelTrans,RelInf,Death_Prop, randnum);            
            Init6(i) = round(0.01*50/(Igen(4)/length(H)));
            
        end
        %Infection Processes        
        [~, RSize, Rgen, Igen, Deaths] = InfectionProcessIndividual(NewH, eps(i), C, Initc1(i),Age,RelTrans,RelInf,Death_Prop, randnum);
        Rc1(j,i) = RSize; Prevc1(j,i) = Igen(4)/length(H); Checkc1(j,i) = abs(Rgen(5) - Rgen(4))/Rgen(4); Dc1(j,i) = Deaths;

        [~, RSize, Rgen, Igen, Deaths] = InfectionProcessIndividual(1*sparse((NewH|NewB1)|NewBa1), eps(i), C, Init1(i),Age,RelTrans,RelInf,Death_Prop, randnum);
        R1(j,i) = RSize; Prev1(j,i) = Igen(4)/length(H); Check1(j,i) = abs(Rgen(5) - Rgen(4))/Rgen(4); D1(j,i) = Deaths;
        
        [~, RSize, Rgen, Igen, Deaths] = InfectionProcessIndividual(1*sparse((NewH|NewB2)|NewBa2), eps(i), C, Init2(i),Age,RelTrans,RelInf,Death_Prop, randnum);
        R2(j,i) = RSize; Prev2(j,i) = Igen(4)/length(H); Check2(j,i) = abs(Rgen(5) - Rgen(4))/Rgen(4); D2(j,i) = Deaths;
        
        [~, RSize, Rgen, Igen, Deaths] = InfectionProcessIndividual(1*sparse((NewH|NewB3)|NewBa3), eps(i), C, Init3(i),Age,RelTrans,RelInf,Death_Prop, randnum);
        R3(j,i) = RSize; Prev3(j,i) = Igen(4)/length(H); Check3(j,i) = abs(Rgen(5) - Rgen(4))/Rgen(4); D3(j,i) = Deaths;
        
        [~, RSize, Rgen, Igen, Deaths] = InfectionProcessIndividual(1*sparse((NewH|NewB4)|NewBa4), eps(i), C, Init4(i),Age,RelTrans,RelInf,Death_Prop, randnum);
        R4(j,i) = RSize; Prev4(j,i) = Igen(4)/length(H); Check4(j,i) = abs(Rgen(5) - Rgen(4))/Rgen(4); D4(j,i) = Deaths;
                
        [~, RSize, Rgen, Igen, Deaths] = InfectionProcessIndividual(1*sparse((NewH|NewB5)|NewBa5), eps(i), C, Init5(i),Age,RelTrans,RelInf,Death_Prop, randnum);
        R5(j,i) = RSize; Prev5(j,i) = Igen(4)/length(H); Check5(j,i) = abs(Rgen(5) - Rgen(4))/Rgen(4); D5(j,i) = Deaths;
        
        [~, RSize, Rgen, Igen, Deaths] = InfectionProcessIndividual(1*sparse((NewH|NewB6)|NewBa6), eps(i), C, Init6(i),Age,RelTrans,RelInf,Death_Prop, randnum);
        R6(j,i) = RSize; Prev6(j,i) = Igen(4)/length(H); Check6(j,i) = abs(Rgen(5) - Rgen(4))/Rgen(4); D6(j,i) = Deaths;
       

    end
    toc
end
%}

%Excluding Elderly
Be1 = ScenarioTypeHouseBubble(H,  (TypeHouse == 1 & NumElderly == 0), Position);
Be2 = ScenarioTypeHouseBubble(H, ((TypeHouse ==1 | TypeHouse == 2) & NumElderly == 0), Position);
Be3 = ScenarioTypeHouseBubble(H, (SizeHouse == 1 & NumElderly == 0), Position);
Be4 = ScenarioTypeHouseBubble2(H, (NumAdults ==1 & NumElderly ==0), Position, 1*(NumElderly > 0),1);
Be6 = ScenarioTypeHouseBubble(H, NumElderly == 0, Position);

for i = ScenarioVec3
    C = Corig;
    RelInf = RelInfM(i,:);
    RelTrans = RelTransM(i,:);
    
    tic
    for j = 1:Runs
        randnum = randi(length(H));
        %Prune Matrices
        [NewH, SAR] = PruneMatrixFull(H, tauH(i), 'H',  Age, RelTrans, RelInf);
        SARs(j,i) = SAR;
        NewBe1 = PruneMatrixFull(Ba1, tauB(i), 'B',  Age, RelTrans, RelInf);
        NewBe2 = PruneMatrixFull(Ba2, tauB(i), 'B',  Age, RelTrans, RelInf);
        NewBe3 = PruneMatrixFull(Ba3, tauB(i), 'B',  Age, RelTrans, RelInf);
        NewBe4 = PruneMatrixFull(Ba4, tauB(i), 'B',  Age, RelTrans, RelInf);
        NewBe5 = NewBa1 + NewBa3;
        NewBe6 = PruneMatrixFull(Ba6, tauB(i), 'B',  Age, RelTrans, RelInf);
        
        if j == 1
            %Run initial scenarios to ascertain initial values
            
            [~, ~, ~, Igen] = InfectionProcessIndividual(NewH, eps(i), C, 50,Age,RelTrans,RelInf,Death_Prop, randnum);
            Initc1(i) = round(0.01*50/(Igen(4)/length(H)));
            [~, ~, ~, Igen] = InfectionProcessIndividual(NewH + NewBe1, eps(i), C, 50,Age,RelTrans,RelInf,Death_Prop, randnum);
            Init1(i) = round(0.01*50/(Igen(4)/length(H)));
            [~, ~, ~, Igen] = InfectionProcessIndividual(NewH + NewBe2, eps(i), C, 50,Age,RelTrans,RelInf,Death_Prop, randnum);
            Init2(i) = round(0.01*50/(Igen(4)/length(H)));
            [~, ~, ~, Igen] = InfectionProcessIndividual(NewH + NewBe3, eps(i), C, 50,Age,RelTrans,RelInf,Death_Prop, randnum);
            Init3(i) = round(0.01*50/(Igen(4)/length(H)));
            [~, ~, ~, Igen] = InfectionProcessIndividual(NewH + NewBe4, eps(i), C, 50,Age,RelTrans,RelInf,Death_Prop, randnum);
            Init4(i) = round(0.01*50/(Igen(4)/length(H)));
            [~, ~, ~, Igen] = InfectionProcessIndividual(NewH + NewBe5, eps(i), C, 50,Age,RelTrans,RelInf,Death_Prop, randnum);
            Init5(i) = round(0.01*50/(Igen(4)/length(H)));           
            [~, ~, ~, Igen] = InfectionProcessIndividual(NewH + NewBe6, eps(i), C, 50,Age,RelTrans,RelInf,Death_Prop, randnum);            
            Init6(i) = round(0.01*50/(Igen(4)/length(H)));
            
        end
        %Infection Processes        
        [~, RSize, Rgen, Igen, Deaths] = InfectionProcessIndividual(NewH, eps(i), C, Initc1(i),Age,RelTrans,RelInf,Death_Prop, randnum);
        Rc1(j,i) = RSize; Prevc1(j,i) = Igen(4)/length(H); Checkc1(j,i) = abs(Rgen(5) - Rgen(4))/Rgen(4); Dc1(j,i) = Deaths;

        [~, RSize, Rgen, Igen, Deaths] = InfectionProcessIndividual(NewH + NewBe1, eps(i), C, Init1(i),Age,RelTrans,RelInf,Death_Prop, randnum);
        R1(j,i) = RSize; Prev1(j,i) = Igen(4)/length(H); Check1(j,i) = abs(Rgen(5) - Rgen(4))/Rgen(4); D1(j,i) = Deaths;
        
        [~, RSize, Rgen, Igen, Deaths] = InfectionProcessIndividual(NewH + NewBe2, eps(i), C, Init2(i),Age,RelTrans,RelInf,Death_Prop, randnum);
        R2(j,i) = RSize; Prev2(j,i) = Igen(4)/length(H); Check2(j,i) = abs(Rgen(5) - Rgen(4))/Rgen(4); D2(j,i) = Deaths;
        
        [~, RSize, Rgen, Igen, Deaths] = InfectionProcessIndividual(NewH + NewBe3, eps(i), C, Init3(i),Age,RelTrans,RelInf,Death_Prop, randnum);
        R3(j,i) = RSize; Prev3(j,i) = Igen(4)/length(H); Check3(j,i) = abs(Rgen(5) - Rgen(4))/Rgen(4); D3(j,i) = Deaths;
        
        [~, RSize, Rgen, Igen, Deaths] = InfectionProcessIndividual(NewH + NewBe4, eps(i), C, Init4(i),Age,RelTrans,RelInf,Death_Prop, randnum);
        R4(j,i) = RSize; Prev4(j,i) = Igen(4)/length(H); Check4(j,i) = abs(Rgen(5) - Rgen(4))/Rgen(4); D4(j,i) = Deaths;
                
        [~, RSize, Rgen, Igen, Deaths] = InfectionProcessIndividual(NewH + NewBe5, eps(i), C, Init5(i),Age,RelTrans,RelInf,Death_Prop, randnum);
        R5(j,i) = RSize; Prev5(j,i) = Igen(4)/length(H); Check5(j,i) = abs(Rgen(5) - Rgen(4))/Rgen(4); D5(j,i) = Deaths;
        
        [~, RSize, Rgen, Igen, Deaths] = InfectionProcessIndividual(NewH + NewBe6, eps(i), C, Init6(i),Age,RelTrans,RelInf,Death_Prop, randnum);
        R6(j,i) = RSize; Prev6(j,i) = Igen(4)/length(H); Check6(j,i) = abs(Rgen(5) - Rgen(4))/Rgen(4); D6(j,i) = Deaths;
       

    end
    toc
end
%}




