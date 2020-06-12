%base parameters
Runs = 20;
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

load('PaperHouseholdworkspace.mat');

for k = 1:9
    DeathPropAge(Age == k) = Death_Prop(k);
end

%Set i = 5 for base parameters; for other sets of parameters set diffeent i
% For different parameter set description see 'MainCode.m'
i = 5; 
RelInf = RelInfM(i,:);
RelTrans = RelTransM(i,:);   
Neweps(i) =  RelativeContributions(H, B, Age, C, RelTrans, RelInf, tauH(i), tauB(i), eps(i));


%y terms refer to infecteds
%Dy terms refer to Deaths
for j = 1:Runs
   tic
   
    %Baseline - Scenario c1
    NewH = PruneMatrixFull(H, tauH(i), 'H',  Age, RelTrans, RelInf);    
    [~, ~, ~, ~, ~, Ic1] = InfectionProcessFull2(NewH, eps(i), C, 100,Age,RelTrans,RelInf, Death_Prop);
    
    DIc1 = DeathPropAge.*Ic1;
    
    %Base infected individuals in eligible and ineligible households
    Basey1(j,:)  = [sum(Ic1(sum(B1) > 0))  sum(Ic1(sum(B1)== 0))];
    Basey2(j,:)  = [sum(Ic1(sum(B2) > 0))  sum(Ic1(sum(B2)== 0))];
    Basey3(j,:)  = [sum(Ic1(sum(B3) > 0))  sum(Ic1(sum(B3)== 0))];
    Basey4(j,:)  = [sum(Ic1(sum(B4) > 0))  sum(Ic1(sum(B4)== 0))];
    Basey5(j,:)  = [sum(Ic1(sum(B5) > 0))  sum(Ic1(sum(B5)== 0))];
    Basey6(j,:)  = [sum(Ic1(sum(B6) > 0))  sum(Ic1(sum(B6)== 0))];
    
    %Base deaths in eligible and ineligible households
    BaseDy1(j,:)  = [sum(DIc1(sum(B1) > 0))  sum(DIc1(sum(B1)== 0))];
    BaseDy2(j,:)  = [sum(DIc1(sum(B2) > 0))  sum(DIc1(sum(B2)== 0))];
    BaseDy3(j,:)  = [sum(DIc1(sum(B3) > 0))  sum(DIc1(sum(B3)== 0))];
    BaseDy4(j,:)  = [sum(DIc1(sum(B4) > 0))  sum(DIc1(sum(B4)== 0))];
    BaseDy5(j,:)  = [sum(DIc1(sum(B5) > 0))  sum(DIc1(sum(B5)== 0))];
    BaseDy6(j,:)  = [sum(DIc1(sum(B6) > 0))  sum(DIc1(sum(B6)== 0))];
 
    %Scenario 1         
    NewB1 = PruneMatrixFull(B1, tauB(i), 'B', Age, RelTrans, RelInf);
    NewM1 = NewH + NewB1;
    [~, ~, ~, ~, ~, I1] = InfectionProcessFull2(NewM1, eps(i), C, 100,Age,RelTrans,RelInf, Death_Prop);  
    DI1 = DeathPropAge.*I1;    
    y1(j,:)  = [sum(I1(sum(B1) > 0)) sum(I1(sum(B1) == 0))];
    Dy1(j,:) = [sum(DI1(sum(B1) > 0)) sum(DI1(sum(B1) == 0))];
    
    %Scenario 2
    NewB2 = PruneMatrixFull(B2, tauB(i), 'B', Age, RelTrans, RelInf);
    NewM2 = NewH + NewB2;
    [~, ~, ~, ~, ~, I2] = InfectionProcessFull2(NewM2, eps(i), C, 100,Age,RelTrans,RelInf, Death_Prop);    
    DI2 = DeathPropAge.*I2;   
    y2(j,:)  = [sum(I2(sum(B2) > 0)) sum(I2(sum(B2) == 0))];
    Dy2(j,:) = [sum(DI2(sum(B2) > 0)) sum(DI2(sum(B2) == 0))];
   
    %Scenario 3
    NewB3 = PruneMatrixFull(B3, tauB(i), 'B', Age, RelTrans, RelInf);
    NewM3 = NewH + NewB3;
    [~, ~, ~, ~, ~, I3] = InfectionProcessFull2(NewM3, eps(i), C, 100,Age,RelTrans,RelInf, Death_Prop);
    DI3 = DeathPropAge.*I3; 
    y3(j,:)  = [sum(I3(sum(B3) > 0)) sum(I3(sum(B3) == 0))];
    Dy3(j,:) = [sum(DI3(sum(B3) > 0)) sum(DI3(sum(B3) == 0))];   
        
    %Scenario 4    
    NewB4 = PruneMatrixFull(B4, tauB(i), 'B', Age, RelTrans, RelInf);
    NewM4 = NewH + NewB4;
    [~, ~, ~, ~, ~, I4] = InfectionProcessFull2(NewM4, eps(i), C, 100,Age,RelTrans,RelInf, Death_Prop);    
    DI4 = DeathPropAge.*I4;   
    y4(j,:)  = [sum(I4(sum(B4) > 0)) sum(I4(sum(B4) == 0))];
    Dy4(j,:) = [sum(DI4(sum(B4) > 0)) sum(DI4(sum(B4) == 0))];    
    
    %Scenario 5
    NewM5 = NewH + NewB1 + NewB3;
    [~, ~, ~, ~, ~, I5] = InfectionProcessFull2(NewM5, eps(i), C, 100,Age,RelTrans,RelInf, Death_Prop);
    DI5 = DeathPropAge.*I5;    
    y5(j,:)  = [sum(I5(sum(B5) > 0)) sum(I5(sum(B5) == 0))];
    Dy5(j,:) = [sum(DI5(sum(B5) > 0)) sum(DI5(sum(B5) == 0))];   
       
    %Scenario 6
    NewB6 = PruneMatrixFull(B6, tauB(i), 'B', Age, RelTrans, RelInf);
    NewM6 = 1*sparse(NewH|NewB6);
    [~, ~, ~, ~, ~, I6] = InfectionProcessFull2(NewM6, eps(i), C, 100,Age,RelTrans,RelInf, Death_Prop);   
    DI6 = DeathPropAge.*I6;
    y6(j,:)  = [sum(I6(sum(B6) > 0)) sum(I6(sum(B6) == 0))];
    Dy6(j,:) = [sum(DI6(sum(B6) > 0)) sum(DI6(sum(B6) == 0))];   
    
    toc
end

%Average over Runs
if Runs > 1
  Dy1 = mean(Dy1); Dy2 = mean(Dy2); Dy3 = mean(Dy3); Dy4 = mean(Dy4); Dy5 = mean(Dy5); Dy6 = mean(Dy6);
  BaseDy1 = mean(BaseDy1); BaseDy2 = mean(BaseDy2); BaseDy3 = mean(BaseDy3); BaseDy4 = mean(BaseDy4); BaseDy5 = mean(BaseDy5); BaseDy6 = mean(BaseDy6);
  y1 = mean(y1); y2 = mean(y2); y3 = mean(y3); y4 = mean(y4); y5 = mean(y5); y6 = mean(y6);
  Basey1 = mean(Basey1); Basey2 = mean(Basey2); Basey3 = mean(Basey3); Basey4 = mean(Basey4); Basey5 = mean(Basey5); Basey6 = mean(Basey6);
end
    
Table1(1,:) = [1, Dy1, BaseDy1, sum(BaseDy1), Dy1./BaseDy1, Dy1./sum(BaseDy1), y1, Basey1, sum(Basey1), y1./Basey1];
Table1(2,:) = [2,Dy2, BaseDy2, sum(BaseDy2), Dy2./BaseDy2, Dy2./sum(BaseDy2), y2, Basey2, sum(Basey2), y2./Basey2];
Table1(3,:) = [3, Dy3, BaseDy3, sum(BaseDy3), Dy3./BaseDy3, Dy3./sum(BaseDy3), y3, Basey3, sum(Basey3), y3./Basey3];
Table1(4,:) = [4, Dy4, BaseDy4, sum(BaseDy4), Dy4./BaseDy4, Dy4./sum(BaseDy4), y4, Basey4, sum(Basey4), y4./Basey4];
Table1(5,:) = [5, Dy5, BaseDy5, sum(BaseDy5), Dy5./BaseDy5, Dy5./sum(BaseDy5), y5, Basey5, sum(Basey5), y5./Basey5];
Table1(6,:) = [6, Dy6, BaseDy6, sum(BaseDy6), Dy6./BaseDy6, Dy6./sum(BaseDy6), y6, Basey6, sum(Basey6), y6./Basey6];

%Convert array to table
Table1 = array2table(Table1, 'VariableNames', {'Scenario', 'death_elig', 'death_inelig', 'C1_death_elig', 'C1_death_inelig', 'C1_total_death', 'B_over_D', 'C_over_E', 'B_over_F', 'C_over_F', 'infection_elig', 'infection_inelig', 'C1_infection_elig', 'C1_infection_inelig', 'C1_total_infection', 'K_over_M', 'L_over_N'} );

%Write file
writetable(Table1, 'Fatality_incease_current.csv');


