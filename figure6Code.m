
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

for k = 1:9
    DeathPropAge(Age == k) = Death_Prop(k);
end

%Set i = 5 for base parameters; for other sets of parameters set diffeent i
% For different parameter set description see 'MainCode.m'
i = 5; 
RelInf = RelInfM(i,:);
RelTrans = RelTransM(i,:);   

Runs = 10;

B5 = B1+B3;
%y terms refer to infecteds
%Dy terms refer to Deaths

[MultiGen1, MultiGen2] = MultiGenerationalHouseholds(Age, Position);


for j = 3:Runs
   tic
   
   
   randnum = randi(length(H));
   
   %Prune Matrices
   NewH = PruneMatrixFull(H, tauH(i), 'H',  Age, RelTrans, RelInf); 
   NewB1 = PruneMatrixFull(B1, tauB(i), 'B', Age, RelTrans, RelInf);
   NewB2 = PruneMatrixFull(B2, tauB(i), 'B', Age, RelTrans, RelInf);
   NewB3 = PruneMatrixFull(B3, tauB(i), 'B', Age, RelTrans, RelInf);
   NewB4 = PruneMatrixFull(B4, tauB(i), 'B', Age, RelTrans, RelInf);
   NewB5 = NewB1 + NewB3;
   NewB6 = PruneMatrixFull(B6, tauB(i), 'B', Age, RelTrans, RelInf);
   
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
   end
       
  
   
    %Baseline - Scenario c1   
    [~, ~, ~, ~, ~, Ic1] = InfectionProcessIndividual2(NewH, eps(i), C, Initc1(i),Age,RelTrans,RelInf, Death_Prop, randnum);
    Ic1Array(j,:) = Ic1;
    
    %Scenario 1
    [~, ~, ~, ~, ~, I1] = InfectionProcessIndividual2(NewH + NewB1, eps(i), C, Init1(i),Age,RelTrans,RelInf, Death_Prop, randnum);
    I1Array(j,:) = I1;

    %Scenario 2
    [~, ~, ~, ~, ~, I2] = InfectionProcessIndividual2(NewH + NewB2, eps(i), C, Init2(i),Age,RelTrans,RelInf, Death_Prop, randnum);
    I2Array(j,:) = I2;
    
    %Scenario 3
    [~, ~, ~, ~, ~, I3] = InfectionProcessIndividual2(NewH + NewB3, eps(i), C, Init3(i),Age,RelTrans,RelInf, Death_Prop, randnum);
    I3Array(j,:) = I3;
    
    %Scenario 4
    [~, ~, ~, ~, ~, I4] = InfectionProcessIndividual2(NewH + NewB4, eps(i), C, Init4(i),Age,RelTrans,RelInf, Death_Prop, randnum);    
    I4Array(j,:) = I4;
    
    %Scenario 5
    [~, ~, ~, ~, ~, I5] = InfectionProcessIndividual2(NewH + NewB1 + NewB3, eps(i), C, Init5(i),Age,RelTrans,RelInf, Death_Prop, randnum);
    I5Array(j,:) = I5;
    
    %Scenario 6
    [~, ~, ~, ~, ~, I6] = InfectionProcessIndividual2(NewH + NewB6, eps(i), C, Init6(i),Age,RelTrans,RelInf, Death_Prop, randnum);   
    I6Array(j,:) = I6;
    
         
    toc
end


Ic1 = mean(Ic1Array);
I1 = mean(I1Array);
I2 = mean(I2Array);
I3 = mean(I3Array);
I4 = mean(I4Array);
I5 = mean(I5Array);
I6 = mean(I6Array);

DIc1 = DeathPropAge.*Ic1;
DI1 = DeathPropAge.*I1;
DI2 = DeathPropAge.*I2;
DI3 = DeathPropAge.*I3;
DI4 = DeathPropAge.*I4;
DI5 = DeathPropAge.*I5;
DI6 = DeathPropAge.*I6;

%Calculate bases
%Base infected individuals in eligible and ineligible households
Basey1  = [sum(Ic1(sum(B1) > 0))  sum(Ic1(sum(B1)== 0))];
Basey2  = [sum(Ic1(sum(B2) > 0))  sum(Ic1(sum(B2)== 0))];
Basey3  = [sum(Ic1(sum(B3) > 0))  sum(Ic1(sum(B3)== 0))];    
Basey4  = [sum(Ic1(sum(B4) > 0))  sum(Ic1(sum(B4)== 0))];
Basey5  = [sum(Ic1(sum(B5) > 0))  sum(Ic1(sum(B5)== 0))];
Basey6  = [sum(Ic1(sum(B6) > 0))  sum(Ic1(sum(B6)== 0))];


%Base deaths in eligible and ineligible households
BaseDy1  = [sum(DIc1(sum(B1) > 0))  sum(DIc1(sum(B1)== 0))];
BaseDy2  = [sum(DIc1(sum(B2) > 0))  sum(DIc1(sum(B2)== 0))];
BaseDy3  = [sum(DIc1(sum(B3) > 0))  sum(DIc1(sum(B3)== 0))];    
BaseDy4  = [sum(DIc1(sum(B4) > 0))  sum(DIc1(sum(B4)== 0))];
BaseDy5  = [sum(DIc1(sum(B5) > 0))  sum(DIc1(sum(B5)== 0))];
BaseDy6  = [sum(DIc1(sum(B6) > 0))  sum(DIc1(sum(B6)== 0))];

%Infected individuals in eligible and ineligible households
y1  = [sum(I1(sum(B1) > 0))  sum(I1(sum(B1)== 0))];
y2  = [sum(I2(sum(B2) > 0))  sum(I2(sum(B2)== 0))];
y3  = [sum(I3(sum(B3) > 0))  sum(I3(sum(B3)== 0))];    
y4  = [sum(I4(sum(B4) > 0))  sum(I4(sum(B4)== 0))];
y5  = [sum(I5(sum(B5) > 0))  sum(I5(sum(B5)== 0))];
y6  = [sum(I6(sum(B6) > 0))  sum(I6(sum(B6)== 0))];


%Deaths in eligible and ineligible households
Dy1  = [sum(DI1(sum(B1) > 0))  sum(DI1(sum(B1)== 0))];
Dy2  = [sum(DI2(sum(B2) > 0))  sum(DI2(sum(B2)== 0))];
Dy3  = [sum(DI3(sum(B3) > 0))  sum(DI3(sum(B3)== 0))];    
Dy4  = [sum(DI4(sum(B4) > 0))  sum(DI4(sum(B4)== 0))];
Dy5  = [sum(DI5(sum(B5) > 0))  sum(DI5(sum(B5)== 0))];
Dy6  = [sum(DI6(sum(B6) > 0))  sum(DI6(sum(B6)== 0))];


Table1(1,:) = [1, Dy1, BaseDy1, sum(BaseDy1), Dy1./BaseDy1, Dy1./sum(BaseDy1), (Dy1-BaseDy1)/sum(Dy1), sum(BaseDy1)/sum(Dy1),  y1, Basey1, sum(Basey1), y1./Basey1];
Table1(2,:) = [2, Dy2, BaseDy2, sum(BaseDy2), Dy2./BaseDy2, Dy2./sum(BaseDy2), (Dy2-BaseDy2)/sum(Dy2), sum(BaseDy2)/sum(Dy2),  y2, Basey2, sum(Basey2), y2./Basey2];
Table1(3,:) = [3, Dy3, BaseDy3, sum(BaseDy3), Dy3./BaseDy3, Dy3./sum(BaseDy3), (Dy3-BaseDy3)/sum(Dy3), sum(BaseDy3)/sum(Dy3),  y3, Basey3, sum(Basey3), y3./Basey3];
Table1(4,:) = [4, Dy4, BaseDy4, sum(BaseDy4), Dy4./BaseDy4, Dy4./sum(BaseDy4), (Dy4-BaseDy4)/sum(Dy4), sum(BaseDy4)/sum(Dy4),  y4, Basey4, sum(Basey4), y4./Basey4];
Table1(5,:) = [5, Dy5, BaseDy5, sum(BaseDy5), Dy5./BaseDy5, Dy5./sum(BaseDy5), (Dy5-BaseDy5)/sum(Dy5), sum(BaseDy5)/sum(Dy5),  y5, Basey5, sum(Basey5), y5./Basey5];
Table1(6,:) = [6, Dy6, BaseDy6, sum(BaseDy6), Dy6./BaseDy6, Dy6./sum(BaseDy6), (Dy6-BaseDy6)/sum(Dy6), sum(BaseDy6)/sum(Dy6),  y6, Basey6, sum(Basey6), y6./Basey6];


%Convert array to table
Table1 = array2table(Table1, 'VariableNames', {'Scenario', 'death_elig', 'death_inelig', 'C1_death_elig', 'C1_death_inelig', 'C1_total_death', 'B_over_D', 'C_over_E', 'B_over_F', 'C_over_F', 'PAF_B', 'PAF_C', 'PAF_C1', 'infection_elig', 'infection_inelig', 'C1_infection_elig', 'C1_infection_inelig', 'C1_total_infection', 'K_over_M', 'L_over_N'} );

Table1.Scenario = ['Scenario 1'; 'Scenario 2'; 'Scenario 3'; 'Scenario 4'; 'Scenario 5' ; 'Scenario 6'];

%Write file
writetable(Table1, 'Fatality_increase_current.csv');
%}


