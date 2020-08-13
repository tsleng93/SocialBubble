%This .m file generates Supplementary Figure S1 from the paper 'The 
%effectiveness of social bubbles as part of a Covid-19 lockdown exit 
%strategy, a modelling study%}


%base parameters
Runs = 20;
tauH =  0.5*[0.31 0.69 1.72];
tauB = 0.5*tauH;
eps = [1.29 1.13 0.925];
%Death probability
Death_Prop = [0.00161,0.00695,0.0309,0.0844,0.161,0.595,1.93,4.28,7.8]./100;
RelInf = [0.5 0.5 1 1 1 1 1 1 1];
RelTrans = ones(1,9);

%load('PaperHouseholdworkspace.mat');
load('FullCensusHouseholdWorkspace.mat');


for j = 1:Runs
    tic
    randnum = randi(length(H));
    
    
    NewH1 = PruneMatrixFull(H, tauH(1), 'H',  Age, RelTrans, RelInf);
    NewH2 = PruneMatrixFull(H, tauH(2), 'H',  Age, RelTrans, RelInf);
    NewH3 = PruneMatrixFull(H, tauH(3), 'H',  Age, RelTrans, RelInf);
   
    %For different SARs
    
    
    if j == 1
        [~, ~, ~, Igen] = InfectionProcessIndividual(NewH1, eps(1), C, 50,Age,RelTrans,RelInf,Death_Prop, randnum);
        Init10 = round(0.01*50/(Igen(4)/length(H)));
        [~, ~, ~, Igen] = InfectionProcessIndividual(NewH2, eps(2), C, 50,Age,RelTrans,RelInf,Death_Prop, randnum);
        Init20 = round(0.01*50/(Igen(4)/length(H)));
        [~, ~, ~, Igen] = InfectionProcessIndividual(NewH3, eps(3), C, 50,Age,RelTrans,RelInf,Death_Prop, randnum);
        Init40 = round(0.01*50/(Igen(4)/length(H)));        
    end
    
    

    % 10% SAR
    [~, ~, Rgen, Igen, ~] = InfectionProcessIndividual(NewH1, eps(1), C, Init10,Age,RelTrans,RelInf, Death_Prop, randnum);
    Rgen10(j,:) = Rgen;  
    Igen10(j,:) = Igen;
    % 20% SAR
    [~, ~, Rgen, Igen, ~] = InfectionProcessIndividual(NewH2, eps(2), C, Init20,Age,RelTrans,RelInf, Death_Prop, randnum);
    Rgen20(j,:) = Rgen;
    Igen20(j,:) = Igen;
    % 40% SAR
    [~, ~, Rgen, Igen,~] = InfectionProcessIndividual(NewH3, eps(3), C, Init40,Age,RelTrans,RelInf, Death_Prop, randnum);
    Rgen40(j,:) = Rgen;
    Igen40(j,:) = Igen;
    
    
    

      
    %Different scenarios for 20% SAR
    NewH = NewH2;
    NewB1 = PruneMatrixFull(B1, tauB(2), 'B', Age, RelTrans, RelInf);
    NewB2 = PruneMatrixFull(B2, tauB(2), 'B', Age, RelTrans, RelInf);
    NewB3 = PruneMatrixFull(B3, tauB(2), 'B', Age, RelTrans, RelInf);
    NewB4 = PruneMatrixFull(B4, tauB(2), 'B', Age, RelTrans, RelInf);
    NewB5 = NewB1 + NewB3;
    NewB6 = PruneMatrixFull(B6, tauB(2), 'B', Age, RelTrans, RelInf);
    NewBc2 = RewirePrunedMatrix(NewB6, 1, 'C2');
    NewBc3 = RewirePrunedMatrix(NewB6, 1, 'C3');
    
    
    if j == 1
        [~, ~, ~, Igen] = InfectionProcessIndividual(NewH + NewB1, eps(2), C, 50,Age,RelTrans,RelInf,Death_Prop, randnum);
        Init1 = round(0.01*50/(Igen(4)/length(H)));
        [~, ~, ~, Igen] = InfectionProcessIndividual(NewH + NewB2, eps(2), C, 50,Age,RelTrans,RelInf,Death_Prop, randnum);
        Init2 = round(0.01*50/(Igen(4)/length(H)));
        [~, ~, ~, Igen] = InfectionProcessIndividual(NewH + NewB3, eps(2), C, 50,Age,RelTrans,RelInf,Death_Prop, randnum);
        Init3 = round(0.01*50/(Igen(4)/length(H)));
        [~, ~, ~, Igen] = InfectionProcessIndividual(NewH + NewB4, eps(2), C, 50,Age,RelTrans,RelInf,Death_Prop, randnum);
        Init4 = round(0.01*50/(Igen(4)/length(H)));
        [~, ~, ~, Igen] = InfectionProcessIndividual(NewH + NewB5, eps(2), C, 50,Age,RelTrans,RelInf,Death_Prop, randnum);
        Init5 = round(0.01*50/(Igen(4)/length(H)));
        [~, ~, ~, Igen] = InfectionProcessIndividual(NewH + NewB6, eps(2), C, 50,Age,RelTrans,RelInf,Death_Prop, randnum);
        Init6 = round(0.01*50/(Igen(4)/length(H)));
        [~, ~, ~, Igen] = InfectionProcessIndividual(NewH + NewBc2, eps(2), C, 50,Age,RelTrans,RelInf,Death_Prop, randnum);
        Initc2 = round(0.01*50/(Igen(4)/length(H)));
        [~, ~, ~, Igen] = InfectionProcessIndividual(NewH + NewBc3, eps(2), C, 50,Age,RelTrans,RelInf,Death_Prop, randnum);
        Initc3 = round(0.01*50/(Igen(4)/length(H)));  
        
    end
       
    
    %Scenario 1
    [~, ~, Rgen, Igen, ~] = InfectionProcessIndividual(NewH + NewB1, eps(2), C, Init1,Age,RelTrans,RelInf, Death_Prop, randnum);
    Rgen1(j,:) = Rgen;
    Igen1(j,:) = Igen;
    
    %Scenario 2
    [~, ~, Rgen, Igen, ~] = InfectionProcessIndividual(NewH + NewB2, eps(2), C, Init2,Age,RelTrans,RelInf, Death_Prop, randnum);
    Rgen2(j,:) = Rgen;
    Igen2(j,:) = Igen;   

    %Scenario 3    
    [~, ~, Rgen, Igen, ~] = InfectionProcessIndividual(NewH + NewB3, eps(2), C, Init3,Age,RelTrans,RelInf, Death_Prop, randnum);
    Rgen3(j,:) = Rgen;
    Igen3(j,:) = Igen;     

    %Scenario 4
    [~, ~, Rgen, Igen, ~] = InfectionProcessIndividual(NewH + NewB4, eps(2), C, Init4,Age,RelTrans,RelInf, Death_Prop, randnum);
    Rgen4(j,:) = Rgen;
    Igen4(j,:) = Igen;

    %Scenario 5
    [~, ~, Rgen, Igen, ~] = InfectionProcessIndividual(NewH + NewB5, eps(2), C, Init5,Age,RelTrans,RelInf, Death_Prop, randnum);
    Rgen5(j,:) = Rgen;
    Igen5(j,:) = Igen;

    %Scenario 6
    [~, ~, Rgen, Igen, ~] = InfectionProcessIndividual(NewH + NewB6, eps(2), C, Init6,Age,RelTrans,RelInf, Death_Prop, randnum);
    Rgen6(j,:) = Rgen;
    Igen6(j,:) = Igen; 
    
    %Scenario c2
    [~, ~, Rgen, Igen, ~] = InfectionProcessIndividual(NewH + NewBc2, eps(2), C, Initc2,Age,RelTrans,RelInf, Death_Prop, randnum);
    Rgenc2(j,:) = Rgen;
    Igenc2(j,:) = Igen; 
    
    %Scenario c3
    [~, ~, Rgen, Igen, ~] = InfectionProcessIndividual(NewH + NewBc3, eps(2), C, Initc2,Age,RelTrans,RelInf, Death_Prop, randnum);
    Rgenc3(j,:) = Rgen;
    Igenc3(j,:) = Igen; 
    
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
plot(1:9, mean(Rgenc2));
plot(1:9, mean(Rgenc3));
xlabel('generation, g');
ylabel('R(g)');
