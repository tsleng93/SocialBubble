%This .m file generates Supplementary Figure S1 from the paper 'The 
%effectiveness of social bubbles as part of a Covid-19 lockdown exit 
%strategy, a modelling study%}


%base parameters
Runs = 20;
tauH =  [0.29 0.64 1.59];
tauB = 0.5*tauH;
eps = [1.735 1.49 1.15];
%Death probability
Death_Prop = [0.00161,0.00695,0.0309,0.0844,0.161,0.595,1.93,4.28,7.8]./100;
RelInf = [0.5 0.5 1 1 1 1 1 1 1];
RelTrans = ones(1,9);

load('PaperHouseholdworkspace.mat');

for j = 1:Runs
    tic
    
    NewH1 = PruneMatrixFull(H, tauH(1), 'H',  Age, RelTrans, RelInf);
    NewH2 = PruneMatrixFull(H, tauH(2), 'H',  Age, RelTrans, RelInf);
    NewH3 = PruneMatrixFull(H, tauH(3), 'H',  Age, RelTrans, RelInf);
   
    %For different SARs

    % 10% SAR
    [~, ~, Rgen, ~, ~] = InfectionProcessFull(NewH1, eps(1), C, 100,Age,RelTrans,RelInf, Death_Prop);
    Rgen10(j,:) = Rgen;
    
    % 20% SAR
    [~, ~, Rgen, ~, ~] = InfectionProcessFull(NewH2, eps(2), C, 100,Age,RelTrans,RelInf, Death_Prop);
    Rgen20(j,:) = Rgen;

    % 40% SAR
    [~, ~, Rgen, ~,~] = InfectionProcessFull(NewH3, eps(3), C, 100,Age,RelTrans,RelInf, Death_Prop);
    Rgen40(j,:) = Rgen;

      
    %Different scenarios for 20% SAR
    NewH = NewH2;
    
    %Scenario 1
    NewB1 = PruneMatrixFull(B1, tauB(2), 'B', Age, RelTrans, RelInf);
    NewM1 = NewH + NewB1;
    [~, ~, Rgen, ~, ~] = InfectionProcessFull(NewM1, eps(2), C, 100,Age,RelTrans,RelInf, Death_Prop);
    Rgen1(j,:) = Rgen;
    
    %Scenario 2
    NewB2 = PruneMatrixFull(B2, tauB(2), 'B', Age, RelTrans, RelInf);
    NewM2 = NewH + NewB2;
    [~, ~, Rgen, ~, ~] = InfectionProcessFull(NewM2, eps(2), C, 100,Age,RelTrans,RelInf, Death_Prop);
    Rgen2(j,:) = Rgen;   

    %Scenario 3
    NewB3 = PruneMatrixFull(B3, tauB(2), 'B', Age, RelTrans, RelInf);
    NewM3 = NewH + NewB3;
    [~, ~, Rgen, ~, ~] = InfectionProcessFull(NewM3, eps(2), C, 100,Age,RelTrans,RelInf, Death_Prop);
    Rgen3(j,:) = Rgen;     

    %Scenario 4
    NewB4 = PruneMatrixFull(B4, tauB(2), 'B', Age, RelTrans, RelInf);
    NewM4 = NewH + NewB4;
    [~, ~, Rgen, ~, ~] = InfectionProcessFull(NewM4, eps(2), C, 100,Age,RelTrans,RelInf, Death_Prop);
    Rgen4(j,:) = Rgen;

    %Scenario 5
    NewM5 = NewH+NewB1+NewB3;
    [~, ~, Rgen, ~, ~] = InfectionProcessFull(NewM5, eps(2), C, 100,Age,RelTrans,RelInf, Death_Prop);
    Rgen5(j,:) = Rgen;

    %Scenario 6
    NewB6 = PruneMatrixFull(B6, tauB(2), 'B', Age, RelTrans, RelInf);
    NewM6 = NewH + NewB6;
    [~, RSize, Rgen, Igen, Deaths] = InfectionProcessFull(NewM6, eps(2), C, 100,Age,RelTrans,RelInf, Death_Prop);
    Rgen6(j,:) = Rgen;   
    
    j
  toc
end

%Plot Left Figure
figure;
plot(1:9, mean(Rgen10)); hold on
plot(1:9, mean(Rgen20)); 
plot(1:9, mean(Rgen40));
plot([1 9], [0.8 0.8], 'k--');
xlabel('generation, g');
ylabel('R(g)');

%Plot Right Figure
figure;
plot(1:9, mean(Rgen1)); hold on
plot(1:9, mean(Rgen2));
plot(1:9, mean(Rgen3));
plot(1:9, mean(Rgen4));
plot(1:9, mean(Rgen5));
plot(1:9, mean(Rgen6));