tauH = 1;
eps = 0.85;

tauB = [0.1*tauH 0.5*tauH tauH];
%Join all households together

House_List = load('House_List.csv');
ProbHouse = load('uk_composition_dist.csv');
House_Sizes = load('House_Sizes.csv');
SizeBubble = 2;
NumHouse = 3000;

RelTrans = [0.64 0.64 0.64 0.64 1 1 1 2.9 2.9 2.9];
RelInf = [0.5 0.5 0.5 0.5 1 1 1 1 1 1];
%{
%Scenario 1- All Households


[H, B, C, Age] = HouseholdMakerAge(NumHouse, House_List, ProbHouse, House_Sizes, SizeBubble);

for i = 1:3
    NewH = PruneMatrixFull(H, tauH, 'H',  Age, RelTrans, RelInf);
    NewB = PruneMatrixFull(B, tauB(i), 'B', Age, RelTrans, RelInf);
    NewM = 1*sparse(NewH|NewB);
    
    [EpiSize, RSize, Rgen, Igen] = InfectionProcessFull(NewM, eps, C, 100,Age,RelTrans,RelInf);
    
    R(i) = RSize;
    i
end
%}
%{
%Scenario 2 - Linking households with children, change temp whether we are
considering primary school or all children aged 0-20


temp = (House_List==1 | House_List ==2 | House_List == 3 | House_List == 4);
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

[H1, B1, C1, Age1] = HouseholdMakerAge(round(Frac*NumHouse), House_List_Child, ProbHouse_Child, House_Sizes_Child, SizeBubble);

[H2, ~, C2, Age2] = HouseholdMakerAge(NumHouse - (round(Frac*NumHouse)), House_List_Adult, ProbHouse_Adult, House_Sizes_Adult, SizeBubble);


H = blkdiag(H1,H2);
B = blkdiag(B1, zeros(length(H2)));

Age = [Age1, Age2];
C = [C1, C2];

for i = 1:3
    NewH = PruneMatrixFull(H, tauH, 'H',  Age, RelTrans, RelInf);
    NewB = PruneMatrixFull(B, tauB(i), 'B', Age, RelTrans, RelInf);
    NewM = 1*sparse(NewH|NewB);
    
    [EpiSize, RSize, Rgen, Igen] = InfectionProcessFull(NewM, eps, C, 100,Age,RelTrans,RelInf);
    
    R(i) = RSize;
    i
end
%}


%Scenario 3 - Linking up all households of size 1 (or size <= 2) to either
%each other (use B1 from household maker) or with the population at large
%(use bubblemaker solo)

House_List_Solo = House_List(House_Sizes < 3, :);
ProbHouse_Solo = ProbHouse(House_Sizes < 3);
House_Sizes_Solo  = House_Sizes(House_Sizes < 3);
Frac = sum(ProbHouse_Solo)/sum(ProbHouse);

ProbHouse_Solo = ProbHouse_Solo/sum(ProbHouse_Solo);

House_List_More = House_List(House_Sizes > 2, :);
ProbHouse_More = ProbHouse(House_Sizes > 2);
ProbHouse_More = ProbHouse_More/sum(ProbHouse_More);
House_Sizes_More = House_Sizes(House_Sizes> 2);

[H1, B1, C1, Age1] = HouseholdMakerAge(round(Frac*NumHouse), House_List_Solo, ProbHouse_Solo, House_Sizes_Solo, SizeBubble);

[H2, ~, C2, Age2] = HouseholdMakerAge(NumHouse - (round(Frac*NumHouse)), House_List_More, ProbHouse_More, House_Sizes_More, SizeBubble);

%B1 = BubbleMakerSolo(H1, 1);


H = blkdiag(H1,H2);
%B = blkdiag(B1, zeros(length(H2)));
B = BubbleMakerSolo(H, 2);

Age = [Age1, Age2];
C = [C1, C2];

for i = 1:3
    NewH = PruneMatrixFull(H, tauH, 'H',  Age, RelTrans, RelInf);
    NewB = PruneMatrixFull(B, tauB(i), 'B', Age, RelTrans, RelInf);
    NewM = 1*sparse(NewH|NewB);
    
    [EpiSize, RSize, Rgen, Igen] = InfectionProcessFull(NewM, eps, C, 100,Age,RelTrans,RelInf);
    
    R(i) = RSize;
    i
end
