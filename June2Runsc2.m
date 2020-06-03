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

%Connor runs this one
ScenarioVec = [1:9 11 14 20 26];
%ScenarioVec = 1:6;
%Trystan runs this one
%ScenarioVec = [7 8 9 11 14 20 26];
%ScenarioVec = 5;



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


load('PaperHouseholdworkspace.mat');
Bc2 = RewireMatrix2(B6,1);

%original C
C3 = C;
%for individual based mean field
C2 = ones(1,length(C));


B1 = RewireMatrix2(B1,1);
B2 = RewireMatrix2(B2,1);
B5 = RewireMatrix2(B5,1);



for i = ScenarioVec
    i
    tic
    if i > 25 && i < 28
       C = C2; 
    else
       C = C3;
    end
    RelInf = RelInfM(i,:);
    RelTrans = RelTransM(i,:);
    %Neweps(i) =  C3Epsilon(B6, C, Age, RelTrans, RelInf, tauB(i), eps(i));
       
    for j = 1:Runs
        %Scenario c1
        
        NewH = PruneMatrixFull(H, tauH(i), 'H',  Age, RelTrans, RelInf);
        %{
        [~, RSize, Rgen, ~, Deaths] = InfectionProcessFull(NewH, eps(i), C, 100,Age,RelTrans,RelInf, Death_Prop);
        Rc1(j,i) = RSize;        
        Checkc1(j,i) = abs(Rgen(5) - Rgen(4))/Rgen(4);       
        Dc1(j,i) = Deaths/length(NewH);
        %}       
        %{
        %Scenario c2
        NewBc2 = PruneMatrixFull(Bc2, tauB(i), 'B', Age, RelTrans, RelInf);
        NewMc2 = 1*sparse(NewH|NewBc2);
        [~, RSize, Rgen, ~, Deaths] = InfectionProcessFull(NewMc2, eps(i), C, 100,Age,RelTrans,RelInf, Death_Prop);
        Rc2(j,i) = RSize;        
        Checkc2(j,i) = abs(Rgen(5) - Rgen(4))/Rgen(4);       
        Dc2(j,i) = Deaths/length(NewMc2);
        %}
        %{
        %Scenario c3
        NewH = PruneMatrixFull(H, tauH(i), 'H',  Age, RelTrans, RelInf);
        [~, RSize, Rgen, ~, Deaths] = InfectionProcessFull(NewH, Neweps(i), C, 100,Age,RelTrans,RelInf, Death_Prop);
        Rc3(j,i) = RSize;        
        Checkc3(j,i) = abs(Rgen(5) - Rgen(4))/Rgen(4);       
        Dc3(j,i) = Deaths/length(NewH);
        %}
        
        %Scenario 1
        NewB1 = PruneMatrixFull(B1, tauB(i), 'B', Age, RelTrans, RelInf);
        NewM1 = 1*sparse(NewH|NewB1);
        [~, RSize, Rgen, ~, Deaths] = InfectionProcessFull(NewM1, eps(i), C, 100,Age,RelTrans,RelInf, Death_Prop);
        R1(j,i) = RSize;        
        Check1(j,i) = abs(Rgen(5) - Rgen(4))/Rgen(4);       
        D1(j,i) = Deaths/length(NewM1);
               
        %Scenario 2
        NewB2 = PruneMatrixFull(B2, tauB(i), 'B', Age, RelTrans, RelInf);
        NewM2 = 1*sparse(NewH|NewB2); 
        [~, RSize, Rgen, ~, Deaths] = InfectionProcessFull(NewM2, eps(i), C, 100,Age,RelTrans,RelInf, Death_Prop);
        R2(j,i) = RSize;        
        Check2(j,i) = abs(Rgen(5) - Rgen(4))/Rgen(4);       
        D2(j,i) = Deaths/length(NewM2);       
        
        
        
        %Scenario 3
        NewB3 = PruneMatrixFull(B3, tauB(i), 'B', Age, RelTrans, RelInf);
        %{
        NewM3 = 1*sparse(NewH|NewB3);
        [~, RSize, Rgen, ~, Deaths] = InfectionProcessFull(NewM3, eps(i), C, 100,Age,RelTrans,RelInf, Death_Prop);
        R3(j,i) = RSize;        
        Check3(j,i) = abs(Rgen(5) - Rgen(4))/Rgen(3);       
        D3(j,i) = Deaths/length(NewM3);      
        %}
        %Scenario 4
        %{
        NewB4 = PruneMatrixFull(B4, tauB(i), 'B', Age, RelTrans, RelInf);
        NewM4 = 1*sparse(NewH|NewB4);
        [~, RSize, Rgen, ~, Deaths] = InfectionProcessFull(NewM4, eps(i), C, 100,Age,RelTrans,RelInf, Death_Prop);
        R4(j,i) = RSize;        
        Check4(j,i) = abs(Rgen(5) - Rgen(4))/Rgen(4);       
        D4(j,i) = Deaths/length(NewM4);
         %}      
        %Scenario 5
        NewM5 = 1*sparse((NewH|NewB1)|NewB3);
        [~, RSize, Rgen, ~, Deaths] = InfectionProcessFull(NewM5, eps(i), C, 100,Age,RelTrans,RelInf, Death_Prop);
        R5(j,i) = RSize;        
        Check5(j,i) = abs(Rgen(5) - Rgen(4))/Rgen(4);       
        D5(j,i) = Deaths/length(NewM5); 
        %{
        %Scenario 6
        NewB6 = PruneMatrixFull(B6, tauB(i), 'B', Age, RelTrans, RelInf);
        NewM6 = 1*sparse(NewH|NewB6);
        [~, RSize, Rgen, ~, Deaths] = InfectionProcessFull(NewM6, eps(i), C, 100,Age,RelTrans,RelInf, Death_Prop);
        R6(j,i) = RSize;        
        Check6(j,i) = abs(Rgen(5) - Rgen(4))/Rgen(4);       
        D6(j,i) = Deaths/length(NewM6);
        %}
    
    end
    toc
end

