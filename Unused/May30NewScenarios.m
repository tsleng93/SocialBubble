%load data
House_List = load('Census_House_List.csv');
ProbHouse = load('Census_composition_dist.csv');
House_Sizes = load('Census_House_Sizes.csv');

%base parameters
SizeBubble = 2;
NumHouse = 3000;
Runs = 1;

%Death probability
Death_Prop = [0.00161,0.00695,0.0309,0.0844,0.161,0.595,1.93,4.28,7.8]./100;

%RelInf
RelInf= [0.5 0.5 1 1 1 1 1 1 1];
%RelInf = [0.79 0.79 1 1 1 1 1.25 1.25 1.25];
%RelTrans
RelTrans = ones(1,9);
%RelTrans = [0.64 0.64 1 1 1 1 2.9 2.9 2.9];

tauH = 0.64;
eps = 1.49;

%tauH = 0.54;
%eps = 0.75;


tauB = 0.5*tauH;

[H, B, C, Age, BH, SizeHouse, TypeHouse, Position] = HouseholdMakerAge;
B1 = ScenarioTypeHouseBubble(H, TypeHouse, Position);
B2 = ScenarioTypeHouseBubble(H, (TypeHouse>0), Position);
B3 = ScenarioTypeHouseBubble(H, SizeHouse, Position);
B4 =  BubbleMakerSolo(H, 1);
B6 = B;
%{
Bc2 = 1*BubbleMaker1(speye(length(H)), 4, 1);
Bc2 = BubbleNonCompliance(Bc2, 1, 0.33);  
%}

i = 1;
for j = 1:Runs
   tic
    %Baseline
    NewH = PruneMatrixFull(H, tauH(i), 'H',  Age, RelTrans, RelInf);
    [~, RSize, Rgen, ~, Deaths] = InfectionProcessFull(NewH, eps(i), C, 1,Age,RelTrans,RelInf, Death_Prop);
    BaseR(j,i) = RSize;        
    BaseCheck(j,i) = abs(Rgen(6) - Rgen(5))/Rgen(5);       
    BaseD(j,i) = Deaths/length(NewM);
    
    %{
    %Baseline c2
    NewBc2 = PruneMatrixFull(B1, tauB(i), 'B', Age, RelTrans, RelInf);
    NewMc2 = 1*sparse(NewH|NewBc2);
    [~, RSize, Rgen, ~, Deaths] = InfectionProcessFull(NewMc2, eps(i), C, 100,Age,RelTrans,RelInf, Death_Prop);
    Rc2(j,i) = RSize;        
    Checkc2(j,i) = abs(Rgen(6) - Rgen(5))/Rgen(5);       
    Dc2(j,i) = Deaths/length(NewM);
    %}
    %Scenario 1
    
          
    NewB1 = PruneMatrixFull(B1, tauB(i), 'B', Age, RelTrans, RelInf);
    NewM1 = 1*sparse(NewH|NewB1);
    [~, RSize, Rgen, ~, Deaths] = InfectionProcessFull(NewM1, eps(i), C, 1,Age,RelTrans,RelInf, Death_Prop);
    R1(j,i) = RSize;        
    Check1(j,i) = abs(Rgen(6) - Rgen(5))/Rgen(5);       
    D1(j,i) = Deaths/length(NewM1); 
    
        
    %Scenario 2
    
    NewB2 = PruneMatrixFull(B2, tauB(i), 'B', Age, RelTrans, RelInf);
    NewM2 = 1*sparse(NewH|NewB2); 
    [~, RSize, Rgen, ~, Deaths] = InfectionProcessFull(NewM2, eps(i), C, 1,Age,RelTrans,RelInf, Death_Prop);
    R2(j,i) = RSize;        
    Check2(j,i) = abs(Rgen(6) - Rgen(5))/Rgen(5);       
    D2(j,i) = Deaths/length(NewM2); 
    
    
    %Scenario 3
    
    NewB3 = PruneMatrixFull(B3, tauB(i), 'B', Age, RelTrans, RelInf);
    NewM3 = 1*sparse(NewH|NewB3);
    [~, RSize, Rgen, ~, Deaths] = InfectionProcessFull(NewM3, eps(i), C, 1,Age,RelTrans,RelInf, Death_Prop);
    R3(j,i) = RSize;        
    Check3(j,i) = abs(Rgen(6) - Rgen(5))/Rgen(5);       
    D3(j,i) = Deaths/length(NewM3); 
        
    %Scenario 4 
    
    NewB4 = PruneMatrixFull(B4, tauB(i), 'B', Age, RelTrans, RelInf);
    NewM4 = 1*sparse(NewH|NewB4);
    [~, RSize, Rgen, ~, Deaths] = InfectionProcessFull(NewM4, eps(i), C, 1,Age,RelTrans,RelInf, Death_Prop);
    R4(j,i) = RSize;        
    Check4(j,i) = abs(Rgen(6) - Rgen(5))/Rgen(5);       
    D4(j,i) = Deaths/length(NewM4);      
    
    %Scenario 5
    NewM5 = 1*sparse((NewH|NewB1)|NewB3);
    [~, RSize, Rgen, ~, Deaths] = InfectionProcessFull(NewM5, eps(i), C, 1,Age,RelTrans,RelInf, Death_Prop);
    R5(j,i) = RSize;        
    Check5(j,i) = abs(Rgen(6) - Rgen(5))/Rgen(5);       
    D5(j,i) = Deaths/length(NewM5);    
    
    %Scenario 6
 
    NewB6 = PruneMatrixFull(B6, tauB(i), 'B', Age, RelTrans, RelInf);
    NewM6 = 1*sparse(NewH|NewB6);
    [~, RSize, Rgen, ~, Deaths] = InfectionProcessFull(NewM6, eps(i), C, 1,Age,RelTrans,RelInf, Death_Prop);
    R6(j,i) = RSize;        
    Check6(j,i) = abs(Rgen(6) - Rgen(5))/Rgen(5);       
    D6(j,i) = Deaths/length(NewM6);
    
    
    toc
end
