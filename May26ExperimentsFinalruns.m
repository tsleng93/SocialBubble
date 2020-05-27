%Final runs

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

%load data
House_List = load('Census_House_List.csv');
ProbHouse = load('Census_composition_dist.csv');
House_Sizes = load('Census_House_Sizes.csv');

%base parameters
SizeBubble = 2;
NumHouse = 10000;
Runs = 20;


%MinScenario = 16;
%MaxScenario = 24;
%Connor runs this one
ScenarioVec = 1:7;
%Trystan runs this one
%ScenarioVec = [8 9 11 14 20 26 29];


%Death probability
Death_Prop = [0.00161,0.00695,0.0309,0.0844,0.161,0.595,1.93,4.28,7.8]./100;

%base tau values
tauLS = [0.29 0.64 1.59];
tauWar = [0.23 0.54 1.46];
%base epsilon values - LSHTM - epsilons to be checked before final run
%R = 0.8
epsLS1 = [1.735 1.49 1.15];
%R = 0.7
epsLS2 = [1.53 1.29 1];
%R = 0.9
epsLS3 = [1.99 1.69 1.31];
%mean-field at individual level
epsLS4 = [0.75 0.62 0.44];
%base epsilon values - Warwick
epsWar = [0.87 0.75 0.64];

%RelInf
RelInfLS = [0.5 0.5 1 1 1 1 1 1 1];
RelInfWar = [0.79 0.79 1 1 1 1 1.25 1.25 1.25];
RelInfM = [RelInfLS; RelInfLS; RelInfLS; RelInfLS; RelInfLS; RelInfLS; RelInfLS; RelInfLS; RelInfLS; RelInfLS; RelInfLS; RelInfLS; RelInfLS; RelInfLS; RelInfLS; RelInfWar; RelInfWar;RelInfWar; RelInfWar; RelInfWar; RelInfWar; RelInfWar; RelInfWar; RelInfWar; RelInfLS; RelInfLS; RelInfLS; RelInfLS; RelInfLS; RelInfLS];  

%RelTrans
RelTransLS = ones(1,9);
RelTransWar = [0.64 0.64 1 1 1 1 2.9 2.9 2.9];
RelTransM = [RelTransLS; RelTransLS; RelTransLS; RelTransLS; RelTransLS; RelTransLS; RelTransLS; RelTransLS; RelTransLS; RelTransLS; RelTransLS; RelTransLS; RelTransLS; RelTransLS; RelTransLS; RelTransWar; RelTransWar;RelTransWar; RelTransWar; RelTransWar; RelTransWar; RelTransWar; RelTransWar; RelTransWar; RelTransLS; RelTransLS; RelTransLS; RelTransLS; RelTransLS; RelTransLS];  

%set tauH values
tauH = [tauLS tauLS tauLS tauLS tauLS tauWar tauWar tauWar tauLS tauLS];
%set tauB values
tauB = [0.1*tauLS 0.5*tauLS  tauLS 0.5*tauLS 0.5*tauLS  0.1*tauWar 0.5*tauWar tauWar 0.5*tauLS 0.5*tauLS];
%set epsilon values 
eps = [epsLS1 epsLS1 epsLS1 epsLS2 epsLS3 epsWar epsWar epsWar epsLS4 epsLS1];

%{
%Find SAR parameters
for i = ScenarioVec
    tic
    RelInf = RelInfM(i,:);
    RelTrans = RelTransM(i,:);
    
    for j = 1:Runs

        [H, ~, C, Age, ~] = HouseholdMakerAge(NumHouse, House_List, ProbHouse, House_Sizes, SizeBubble, SizeBubble);

        if i > 24 && i < 28
           C = ones(1, length(H)); 
        end

        [NewH, SAR] = PruneMatrixFull(H, tauH(i), 'H',  Age, RelTrans, RelInf);
        SAR2(i,j) = SAR;


        [EpiSize, RSize, Rgen, Igen, Deaths] = InfectionProcessFull(NewH, eps(i), C, 100,Age,RelTrans,RelInf, Death_Prop);
        BaseRSize(i,j) = RSize;
        BaseDeaths(i,j) = Deaths/length(NewH);
        
        i
        
    end
    toc
end
%}

%Main runs

for j=1:Runs
    j
    tic
    
    %With full matrix
    H = 1;
    while mod(length(H), 4) ~= 0
        [H, B, C, Age, BH] = HouseholdMakerAge(NumHouse, House_List, ProbHouse, House_Sizes, SizeBubble, 2*SizeBubble);
    end
    Cm = C;
    
    Bc2 = 1*BubbleMaker1(speye(length(H)), 4, 1);
    Bc2 = BubbleNonCompliance(Bc2, 1, 0.36);  
        
    for i = ScenarioVec
        RelInf = RelInfM(i,:);
        RelTrans = RelTransM(i,:);
        
        
        if i > 27
            B = BH;
            C = Cm;
        end
        
        if i > 24 && i < 28           
           C = ones(1, length(H));
        end
        

                
        NewH = PruneMatrixFull(H, tauH(i), 'H',  Age, RelTrans, RelInf);
        NewB = PruneMatrixFull(B, tauB(i), 'B', Age, RelTrans, RelInf);
        NewM = 1*sparse(NewH|NewB);
        
        NewBc2 = PruneMatrixFull(Bc2, tauB(i), 'B', Age, RelTrans, RelInf);
        NewMc2 = 1*sparse(NewH|NewBc2);
        
        
        %all in bubble
        [~, RSize, Rgen, ~, Deaths] = InfectionProcessFull(NewM, eps(i), C, 100,Age,RelTrans,RelInf, Death_Prop);
        R6(j,i) = RSize;        
        Check6(j,i) = abs(Rgen(6) - Rgen(5))/Rgen(5);       
        D6(j,i) = Deaths/length(NewM);
        
        %36% randomly choosing 3 contacts
        [~, RSize, Rgen, ~, Deaths] = InfectionProcessFull(NewMc2, eps(i), C, 100,Age,RelTrans,RelInf, Death_Prop);
        Rc2(j,i) = RSize;        
        Checkc2(j,i) = abs(Rgen(6) - Rgen(5))/Rgen(5);       
        Dc2(j,i) = Deaths/length(NewM);
        

    end        
    
    %with <10 year old children
    temp = (House_List==1);
    temp2 = sum(temp');
    House_List_Child = House_List(temp2>0, :);
    ProbHouse_Child = ProbHouse(temp2>0);
    House_Sizes_Child = House_Sizes(temp2>0);

    Frac = sum(ProbHouse_Child)/sum(ProbHouse);

    ProbHouse_Child = ProbHouse_Child/sum(ProbHouse_Child);

    House_List_Adult = House_List(temp2==0, :);
    ProbHouse_Adult = ProbHouse(temp2==0);
    ProbHouse_Adult = ProbHouse_Adult/sum(ProbHouse_Adult);
    House_Sizes_Adult = House_Sizes(temp2==0);

    House_List_Solo = House_List_Adult(House_Sizes_Adult < 2, :);
    ProbHouse_Solo = ProbHouse_Adult(House_Sizes_Adult < 2);
    House_Sizes_Solo  = House_Sizes_Adult(House_Sizes_Adult < 2);
    Frac2 = sum(ProbHouse_Solo)/sum(ProbHouse_Adult);

    ProbHouse_Solo = ProbHouse_Solo/sum(ProbHouse_Solo);

    House_List_More = House_List_Adult(House_Sizes_Adult >1, :);
    ProbHouse_More = ProbHouse_Adult(House_Sizes_Adult > 1);
    ProbHouse_More = ProbHouse_More/sum(ProbHouse_More);
    House_Sizes_More  = House_Sizes_Adult(House_Sizes_Adult > 1);

    NumChild = round(Frac*NumHouse);
    NumAdult = NumHouse- NumChild;
    NumSolo = round(Frac2*NumAdult);
    NumMore = NumAdult - NumSolo;
    
    
    [H1, B1, C1, Age1, BH1] = HouseholdMakerAge(NumChild, House_List_Child, ProbHouse_Child, House_Sizes_Child, SizeBubble, 2*SizeBubble);
    [H2, B2, C2, Age2, BH2] = HouseholdMakerAge(NumSolo, House_List_Solo, ProbHouse_Solo, House_Sizes_Solo, SizeBubble, 2*SizeBubble);
    [H3, ~, C3, Age3, ~] = HouseholdMakerAge(NumMore, House_List_More, ProbHouse_More, House_Sizes_More, SizeBubble, 2*SizeBubble);
     
    if i > 27
            B1 = BH1;
            B2 = BH2;
    end
        
    
    H = blkdiag(H1,H2, H3);
    Bs1 = blkdiag(B1, zeros(length(H2)),zeros(length(H3)));        
    Bs3 = blkdiag(zeros(length(H1)), B2, zeros(length(H3)));
    Bs4 = BubbleMakerSolo(H, 1);
    Bs5 = blkdiag(B1, B2,zeros(length(H3)));


    Age = [Age1, Age2, Age3];
    C = [C1, C2, C3];
    Cm = C;
    
    for i = ScenarioVec
                
        if i > 24 && i < 28
           C = ones(1, length(H)); 
        end
        
        if i > 27
           C = Cm; 
        end
        
        
        RelInf = RelInfM(i,:);
        RelTrans = RelTransM(i,:);

        NewH = PruneMatrixFull(H, tauH(i), 'H',  Age, RelTrans, RelInf);
        NewBs1 = PruneMatrixFull(Bs1, tauB(i), 'B', Age, RelTrans, RelInf);
        NewMs1 = 1*sparse(NewH|NewBs1);                   
        NewBs3 = PruneMatrixFull(Bs3, tauB(i), 'B', Age, RelTrans, RelInf);
        NewMs3 = 1*sparse(NewH|NewBs3);
        NewBs4 = PruneMatrixFull(Bs4, tauB(i), 'B', Age, RelTrans, RelInf);
        NewMs4 = 1*sparse(NewH|NewBs4);
        NewBs5 = PruneMatrixFull(Bs5, tauB(i), 'B', Age, RelTrans, RelInf);
        NewMs5 = 1*sparse(NewH|NewBs5);  
        
        [~, RSize, Rgen, ~, Deaths] = InfectionProcessFull(NewMs1, eps(i), C, 100,Age,RelTrans,RelInf, Death_Prop);
        R1(j,i) = RSize;
        Check1(j,i) = abs(Rgen(6) - Rgen(5))/Rgen(5);
        D1(j,i) = Deaths/length(NewM);
               
        [~, RSize, Rgen, ~, Deaths] = InfectionProcessFull(NewMs3, eps(i), C, 100,Age,RelTrans,RelInf, Death_Prop);
        R3(j,i) = RSize;
        Check3(j,i) = abs(Rgen(6) - Rgen(5))/Rgen(5);
        D3(j,i) = Deaths/length(NewM);   
        
        [~, RSize, Rgen, ~, Deaths] = InfectionProcessFull(NewMs4, eps(i), C, 100,Age,RelTrans,RelInf, Death_Prop);
        R4(j,i) = RSize;
        Check4(j,i) = abs(Rgen(5) - Rgen(4))/Rgen(4);
        D4(j,i) = Deaths/length(NewM);
        
        [~, RSize, Rgen, ~, Deaths] = InfectionProcessFull(NewMs5, eps(i), C, 100,Age,RelTrans,RelInf, Death_Prop);
        R5(j,i) = RSize;
        Check5(j,i) = abs(Rgen(6) - Rgen(5))/Rgen(5);
        D5(j,i) = Deaths/length(NewM);
               
    end
    
    
    % with < 20 year old children
    temp = (House_List==1 | House_List ==2);
    temp2 = sum(temp');
    House_List_Child = House_List(temp2>0, :);
    ProbHouse_Child = ProbHouse(temp2>0);
    House_Sizes_Child = House_Sizes(temp2>0);

    Frac = sum(ProbHouse_Child)/sum(ProbHouse);

    ProbHouse_Child = ProbHouse_Child/sum(ProbHouse_Child);

    House_List_Adult = House_List(temp2==0, :);
    ProbHouse_Adult = ProbHouse(temp2==0);
    ProbHouse_Adult = ProbHouse_Adult/sum(ProbHouse_Adult);
    House_Sizes_Adult = House_Sizes(temp2==0);
    
    [H1, B1, C1, Age1, BH1] = HouseholdMakerAge(round(Frac*NumHouse), House_List_Child, ProbHouse_Child, House_Sizes_Child, SizeBubble, SizeBubble);

    [H2, ~, C2, Age2] = HouseholdMakerAge(NumHouse - (round(Frac*NumHouse)), House_List_Adult, ProbHouse_Adult, House_Sizes_Adult, SizeBubble, SizeBubble);

    H = blkdiag(H1,H2);
    
    if i > 27
      B1 = BH1;
    end
    
    B = blkdiag(B1, zeros(length(H2)));
    

    
    
    
    Age = [Age1, Age2];
    C = [C1, C2];
    Cm = C;
    
    
    for i = ScenarioVec
        
        RelInf = RelInfM(i,:);
        RelTrans = RelTransM(i,:);        
        
        if i > 24 && i < 28
           C = ones(1, length(H)); 
        end
        if i > 27
           C = Cm; 
        end
        
        
       NewH = PruneMatrixFull(H, tauH(i), 'H',  Age, RelTrans, RelInf);
       NewB = PruneMatrixFull(B, tauB(i), 'B', Age, RelTrans, RelInf);
       NewM = 1*sparse(NewH|NewB);

       [~, RSize, Rgen, ~, Deaths] = InfectionProcessFull(NewM, eps(i), C, 100,Age,RelTrans,RelInf, Death_Prop);
       R2(j,i) = RSize;        
       Check2(j,i) = abs(Rgen(6) - Rgen(5))/Rgen(5);        
       D2(j,i) = Deaths/length(NewM);
    end
    
    
    toc 
end

%}
    

