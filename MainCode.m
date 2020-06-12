%Running MainCode.m generates the underlying data for Figures 2, 4 and
%Supplementary Figures S3-S7. After running this, DataMaker.m should be
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

%base parameters
Runs = 1;

%Scenarios used for the paper
ScenarioVec = [2 4 5 6 8 11 14 20 26];
ScenarioVec2 = 29;

%base tau values
tauLS = [0.29 0.64 1.59]; tauWar = [0.23 0.54 1.46];
%base epsilon values - LSHTM
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

%Relative Transmissibility paramaters, in 10 years age bands
RelTransLS = ones(1,9); RelTransWar = [0.64 0.64 1 1 1 1 2.9 2.9 2.9];
RelTransM = [RelTransLS; RelTransLS; RelTransLS; RelTransLS; RelTransLS; RelTransLS; RelTransLS; RelTransLS; RelTransLS; RelTransLS; RelTransLS; RelTransLS; RelTransLS; RelTransLS; RelTransLS; RelTransWar; RelTransWar;RelTransWar; RelTransWar; RelTransWar; RelTransWar; RelTransWar; RelTransWar; RelTransWar; RelTransLS; RelTransLS; RelTransLS; RelTransLS; RelTransLS; RelTransLS];  

%set tauH values
tauH = [tauLS tauLS tauLS tauLS tauLS tauWar tauWar tauWar tauLS tauLS];
%set tauB values
tauB = [0.1*tauLS 0.5*tauLS  tauLS 0.5*tauLS 0.5*tauLS  0.1*tauWar 0.5*tauWar tauWar 0.5*tauLS 0.5*tauLS];
%set epsilon values 
eps = [epsLS1 epsLS1 epsLS1 epsLS2 epsLS3 epsWar epsWar epsWar epsLS4 epsLS1];

load('PaperHouseholdworkspace.mat');
%Obtain bubble matrix for Scenario c2
Bc2 = RewireMatrix2(B6,1);

%original C
C3 = C;
%for individual based mean field
C2 = ones(1,length(C));

%Initialise R, Check and D arrays
Rc1 = zeros(Runs, 30); Rc2 = zeros(Runs,30); Rc3 = zeros(Runs,30); R1 = zeros(Runs,30); R2 = zeros(Runs,30); R3 = zeros(Runs,30); R4 = zeros(Runs,30); R5 = zeros(Runs,30); R6 = zeros(Runs,30);
Checkc1 = zeros(Runs, 30); Checkc2 = zeros(Runs,30); Checkc3 = zeros(Runs,30); Check1 = zeros(Runs,30); Check2 = zeros(Runs,30); Check3 = zeros(Runs,30); Check4 = zeros(Runs,30); Check5 = zeros(Runs,30); Check6 = zeros(Runs,30);
Dc1 = zeros(Runs, 30); Dc2 = zeros(Runs,30); Dc3 = zeros(Runs,30); D1 = zeros(Runs,30); D2 = zeros(Runs,30); D3 = zeros(Runs,30); D4 = zeros(Runs,30); D5 = zeros(Runs,30); D6 = zeros(Runs,30);

%Running Scenarios 1-27
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
    Neweps(i) =  C3Epsilon(B6, C, Age, RelTrans, RelInf, tauB(i), eps(i));
       
    for j = 1:Runs
        %Scenario c1
        
        NewH = PruneMatrixFull(H, tauH(i), 'H',  Age, RelTrans, RelInf);
        
        [~, RSize, Rgen,~, Deaths] = InfectionProcessFull(NewH, eps(i), C, 100,Age,RelTrans,RelInf, Death_Prop);
         if abs(Rgen(5) - Rgen(4))/Rgen(4) > 0.05
            [~, RSize, Rgen,~, ~] = InfectionProcessFull(NewH, eps(i), C, 10,Age,RelTrans,RelInf, Death_Prop);
             if abs(Rgen(5) - Rgen(4))/Rgen(4) > 0.05
                [~, RSize, Rgen,~, ~] = InfectionProcessFull(NewH, eps(i), C, 5,Age,RelTrans,RelInf, Death_Prop);
            end
            
         end
        Rc1(j,i) = RSize;        
        Checkc1(j,i) = abs(Rgen(5) - Rgen(4))/Rgen(4);       
        Dc1(j,i) = Deaths/length(NewH);
        
        
        %}       
       
        %Scenario c2
        NewBc2 = PruneMatrixFull(Bc2, tauB(i), 'B', Age, RelTrans, RelInf);
        NewMc2 = NewH + NewBc2;
        [~, RSize, Rgen, ~, Deaths] = InfectionProcessFull(NewMc2, eps(i), C, 100,Age,RelTrans,RelInf, Death_Prop);
        if abs(Rgen(5) - Rgen(4))/Rgen(4) > 0.05
            [~, RSize, Rgen, ~, ~] = InfectionProcessFull(NewMc2, eps(i), C, 10,Age,RelTrans,RelInf, Death_Prop);
            if abs(Rgen(5) - Rgen(4))/Rgen(4) > 0.05
                [~, RSize, Rgen,~, ~] = InfectionProcessFull(NewMc2, eps(i), C, 5,Age,RelTrans,RelInf, Death_Prop);
            end
        end
        Rc2(j,i) = RSize;        
        Checkc2(j,i) = abs(Rgen(5) - Rgen(4))/Rgen(4);       
        Dc2(j,i) = Deaths/length(NewMc2);
        
        
        %Scenario c3
        [~, RSize, Rgen, ~, Deaths] = InfectionProcessFull(NewH, Neweps(i), C, 100,Age,RelTrans,RelInf, Death_Prop);
        if abs(Rgen(5) - Rgen(4))/Rgen(4) > 0.05
            [~, RSize, Rgen, ~, ~] = InfectionProcessFull(NewH, Neweps(i), C, 10,Age,RelTrans,RelInf, Death_Prop);
             if abs(Rgen(5) - Rgen(4))/Rgen(4) > 0.05
                [~, RSize, Rgen,~, ~] = InfectionProcessFull(NewH, Neweps(i), C, 5,Age,RelTrans,RelInf, Death_Prop);
            end
        end
        Rc3(j,i) = RSize;        
        Checkc3(j,i) = abs(Rgen(5) - Rgen(4))/Rgen(4);       
        Dc3(j,i) = Deaths/length(NewH);
        
        
        %Scenario 1
        NewB1 = PruneMatrixFull(B1, tauB(i), 'B', Age, RelTrans, RelInf);
        %NewM1 = 1*sparse(NewH|NewB1);
        NewM1 = NewH + NewB1;
        [~, RSize, Rgen, ~, Deaths] = InfectionProcessFull(NewM1, eps(i), C, 100,Age,RelTrans,RelInf, Death_Prop);
        
        if abs(Rgen(5) - Rgen(4))/Rgen(4) > 0.05
            [~, RSize, Rgen, ~, ~] = InfectionProcessFull(NewM1, eps(i), C, 10,Age,RelTrans,RelInf, Death_Prop);
             if abs(Rgen(5) - Rgen(4))/Rgen(4) > 0.05
                [~, RSize, Rgen, ~, ~] = InfectionProcessFull(NewM1, eps(i), C, 5,Age,RelTrans,RelInf, Death_Prop);
            end
        end
              
        R1(j,i) = RSize;        
        Check1(j,i) = abs(Rgen(5) - Rgen(4))/Rgen(4);       
        D1(j,i) = Deaths/length(NewM1);
               
        %Scenario 2
        NewB2 = PruneMatrixFull(B2, tauB(i), 'B', Age, RelTrans, RelInf);
        %NewM2 = 1*sparse(NewH|NewB2);
        NewM2 = NewH + NewB2;
        [~, RSize, Rgen, ~, Deaths] = InfectionProcessFull(NewM2, eps(i), C, 100,Age,RelTrans,RelInf, Death_Prop);
        if abs(Rgen(5) - Rgen(4))/Rgen(4) > 0.05
        [~, RSize, Rgen, ~, ~] = InfectionProcessFull(NewM2, eps(i), C, 10,Age,RelTrans,RelInf, Death_Prop);
            if abs(Rgen(5) - Rgen(4))/Rgen(4) > 0.05
                [~, RSize, Rgen, ~, ~] = InfectionProcessFull(NewM2, eps(i), C, 5,Age,RelTrans,RelInf, Death_Prop);
            end
        end
        R2(j,i) = RSize;        
        Check2(j,i) = abs(Rgen(5) - Rgen(4))/Rgen(4);       
        D2(j,i) = Deaths/length(NewM2);       
        
        
        
        %Scenario 3
        NewB3 = PruneMatrixFull(B3, tauB(i), 'B', Age, RelTrans, RelInf);
              
        %NewM3 = 1*sparse(NewH|NewB3);
        NewM3 = NewH + NewB3;
        [~, RSize, Rgen, ~, Deaths] = InfectionProcessFull(NewM3, eps(i), C, 100,Age,RelTrans,RelInf, Death_Prop);
        if abs(Rgen(5) - Rgen(4))/Rgen(4) > 0.05
            [~, RSize, Rgen, ~, ~] = InfectionProcessFull(NewM3, eps(i), C, 10,Age,RelTrans,RelInf, Death_Prop);
            if abs(Rgen(5) - Rgen(4))/Rgen(4) > 0.05
                [~, RSize, Rgen, ~, ~] = InfectionProcessFull(NewM3, eps(i), C, 5,Age,RelTrans,RelInf, Death_Prop);
            end
        end
        R3(j,i) = RSize;        
        Check3(j,i) = abs(Rgen(5) - Rgen(4))/Rgen(3);       
        D3(j,i) = Deaths/length(NewM3);      
        
        %Scenario 4
        
        NewB4 = PruneMatrixFull(B4, tauB(i), 'B', Age, RelTrans, RelInf);
        %NewM4 = 1*sparse(NewH|NewB4);
        NewM4 = NewH + NewB4;
        [~, RSize, Rgen, ~, Deaths] = InfectionProcessFull(NewM4, eps(i), C, 100,Age,RelTrans,RelInf, Death_Prop);
        if abs(Rgen(5) - Rgen(4))/Rgen(4) > 0.05
            [~, RSize, Rgen, ~, ~] = InfectionProcessFull(NewM4, eps(i), C, 10,Age,RelTrans,RelInf, Death_Prop);
            if abs(Rgen(5) - Rgen(4))/Rgen(4) > 0.05
                [~, RSize, Rgen, ~, ~] = InfectionProcessFull(NewM4, eps(i), C, 5,Age,RelTrans,RelInf, Death_Prop);
            end
        end
        R4(j,i) = RSize;        
        Check4(j,i) = abs(Rgen(5) - Rgen(4))/Rgen(4);       
        D4(j,i) = Deaths/length(NewM4);
         
         
        %Scenario 5
        %NewM5 = 1*sparse((NewH|NewB1)|NewB3);
        NewM5 = NewH+NewB1+NewB3;
        [~, RSize, Rgen, ~, Deaths] = InfectionProcessFull(NewM5, eps(i), C, 100,Age,RelTrans,RelInf, Death_Prop);
        if abs(Rgen(5) - Rgen(4))/Rgen(4) > 0.05
            [~, RSize, Rgen, ~, ~] = InfectionProcessFull(NewM5, eps(i), C, 10,Age,RelTrans,RelInf, Death_Prop);
            if abs(Rgen(5) - Rgen(4))/Rgen(4) > 0.05
                [~, RSize, Rgen, ~, ~] = InfectionProcessFull(NewM5, eps(i), C, 5,Age,RelTrans,RelInf, Death_Prop);
            end
        end
        R5(j,i) = RSize;        
        Check5(j,i) = abs(Rgen(5) - Rgen(4))/Rgen(4);       
        D5(j,i) = Deaths/length(NewM5);
 %}
        
        %Scenario 6
        NewB6 = PruneMatrixFull(B6, tauB(i), 'B', Age, RelTrans, RelInf);
        %NewM6 = 1*sparse(NewH|NewB6);
        NewM6 = NewH + NewB6;
        [~, RSize, Rgen, Igen, Deaths] = InfectionProcessFull(NewM6, eps(i), C, 100,Age,RelTrans,RelInf, Death_Prop);
        if abs(Rgen(5) - Rgen(4))/Rgen(4) > 0.05
            [~, RSize, Rgen, ~, ~] = InfectionProcessFull(NewM6, eps(i), C, 10,Age,RelTrans,RelInf, Death_Prop);
            if abs(Rgen(5) - Rgen(4))/Rgen(4) > 0.05
                [~, RSize, Rgen, ~, ~] = InfectionProcessFull(NewM6, eps(i), C, 5,Age,RelTrans,RelInf, Death_Prop);
            end
        end
        R6(j,i) = RSize;        
        Check6(j,i) = abs(Rgen(5) - Rgen(4))/Rgen(4);       
        D6(j,i) = Deaths/length(NewM6);
        %}
    
    end
    toc
end


%Running Scenarios 28-30 - Nonadherence
%Create additional non-adherence bubbles
Ba1 = NonAdherenceBubble(H, TypeHouse, Position, 0.5);
Ba2 = NonAdherenceBubble(H, (TypeHouse>0), Position, 0.5);
Ba3 = NonAdherenceBubble(H, SizeHouse, Position, 0.5);
Ba4 = BubbleMakerSolo2(H,1, 0.5);
Ba6 = NonAdherenceBubble(H, ones(1,length(SizeHouse)), Position, 0.5);


for i = ScenarioVec2
    
    i
    tic
    C = C3;
    RelInf = RelInfM(i,:);
    RelTrans = RelTransM(i,:);
    
    
    for j = 1:Runs
        
            %Baseline   
            NewH = PruneMatrixFull(H, tauH(i), 'H',  Age, RelTrans, RelInf);
            [~, RSize, Rgen, ~, Deaths] = InfectionProcessFull(NewH, eps(i), C, 100,Age,RelTrans,RelInf, Death_Prop);
            if abs(Rgen(5) - Rgen(4))/Rgen(4) > 0.05
                [~, RSize, Rgen, ~, ~] = InfectionProcessFull(NewH, eps(i), C, 10,Age,RelTrans,RelInf, Death_Prop);
                if abs(Rgen(5) - Rgen(4))/Rgen(4) > 0.05
                    [~, RSize, Rgen, ~, ~] = InfectionProcessFull(NewH, eps(i), C, 5,Age,RelTrans,RelInf, Death_Prop);
                end
            end
            Rc1(j,i) = RSize;        
            Checkc1(j,i) = abs(Rgen(5) - Rgen(4))/Rgen(4);       
            Dc1(j,i) = Deaths/length(NewH);

            %Scenario 1
            NewB1 = PruneMatrixFull(B1, tauB(i), 'B', Age, RelTrans, RelInf);
            NewBa1 = PruneMatrixFull(Ba1, tauB(i), 'B', Age, RelTrans, RelInf);
            NewM1 = 1*sparse((NewH|NewB1)|NewBa1);
            [~, RSize, Rgen, ~, Deaths] = InfectionProcessFull(NewM1, eps(i), C, 100,Age,RelTrans,RelInf, Death_Prop);
            if abs(Rgen(5) - Rgen(4))/Rgen(4) > 0.05
                [~, RSize, Rgen, ~, ~] = InfectionProcessFull(NewM1, eps(i), C, 10,Age,RelTrans,RelInf, Death_Prop);
                if abs(Rgen(5) - Rgen(4))/Rgen(4) > 0.05
                    [~, RSize, Rgen, ~, ~] = InfectionProcessFull(NewM1, eps(i), C, 5,Age,RelTrans,RelInf, Death_Prop);
                end  
            end    
            R1(j,i) = RSize;        
            Check1(j,i) = abs(Rgen(5) - Rgen(4))/Rgen(4);       
            D1(j,i) = Deaths/length(NewM1);

            %Scenario 2
            NewB2 = PruneMatrixFull(B2, tauB(i), 'B', Age, RelTrans, RelInf);
            NewBa2 = PruneMatrixFull(Ba2, tauB(i), 'B', Age, RelTrans, RelInf);
            NewM2 = 1*sparse((NewH|NewB2)|NewBa2); 
            [~, RSize, Rgen, ~, Deaths] = InfectionProcessFull(NewM2, eps(i), C, 100,Age,RelTrans,RelInf, Death_Prop);
            if abs(Rgen(5) - Rgen(4))/Rgen(4) > 0.05
                [~, RSize, Rgen, ~, ~] = InfectionProcessFull(NewM2, eps(i), C, 10,Age,RelTrans,RelInf, Death_Prop);
                if abs(Rgen(5) - Rgen(4))/Rgen(4) > 0.05
                    [~, RSize, Rgen, ~, ~] = InfectionProcessFull(NewM2, eps(i), C, 5,Age,RelTrans,RelInf, Death_Prop);
                end
            end
            R2(j,i) = RSize;        
            Check2(j,i) = abs(Rgen(5) - Rgen(4))/Rgen(4);       
            D2(j,i) = Deaths/length(NewM2);

            %Scenario 3
            NewB3 = PruneMatrixFull(B3, tauB(i), 'B', Age, RelTrans, RelInf);
            NewBa3 = PruneMatrixFull(Ba3, tauB(i), 'B', Age, RelTrans, RelInf);
            NewM3 = 1*sparse((NewH|NewB3)|NewBa3);
            [~, RSize, Rgen, ~, Deaths] = InfectionProcessFull(NewM3, eps(i), C, 100,Age,RelTrans,RelInf, Death_Prop);
            if abs(Rgen(5) - Rgen(4))/Rgen(4) > 0.05
                [~, RSize, Rgen, ~, ~] = InfectionProcessFull(NewM3, eps(i), C, 10,Age,RelTrans,RelInf, Death_Prop);
                if abs(Rgen(5) - Rgen(4))/Rgen(4) > 0.05
                    [~, RSize, Rgen, ~, ~] = InfectionProcessFull(NewM3, eps(i), C, 5,Age,RelTrans,RelInf, Death_Prop);
                end
            end
            R3(j,i) = RSize;        
            Check3(j,i) = abs(Rgen(5) - Rgen(4))/Rgen(4);       
            D3(j,i) = Deaths/length(NewM3);

            %Scenario 4 
            NewB4 = PruneMatrixFull(B4, tauB(i), 'B', Age, RelTrans, RelInf);
            NewBa4 = PruneMatrixFull(Ba4, tauB(i), 'B', Age, RelTrans, RelInf);
            NewM4 = 1*sparse((NewH|NewB4)|NewBa4);
            [~, RSize, Rgen, ~, Deaths] = InfectionProcessFull(NewM4, eps(i), C, 100,Age,RelTrans,RelInf, Death_Prop);
            if abs(Rgen(5) - Rgen(4))/Rgen(4) > 0.05
                [~, RSize, Rgen, ~, ~] = InfectionProcessFull(NewM4, eps(i), C, 10,Age,RelTrans,RelInf, Death_Prop);
                if abs(Rgen(5) - Rgen(4))/Rgen(4) > 0.05
                    [~, RSize, Rgen, ~, ~] = InfectionProcessFull(NewM4, eps(i), C, 5,Age,RelTrans,RelInf, Death_Prop);
                end
            end
            R4(j,i) = RSize;        
            Check4(j,i) = abs(Rgen(5) - Rgen(4))/Rgen(4);       
            D4(j,i) = Deaths/length(NewM4);

            %Scenario 5
            NewM5 = 1*sparse((((NewH|NewB1)|NewB3)|NewBa1)|NewBa3);
            [~, RSize, Rgen, ~, Deaths] = InfectionProcessFull(NewM5, eps(i), C, 100,Age,RelTrans,RelInf, Death_Prop);
            if abs(Rgen(5) - Rgen(4))/Rgen(4) > 0.05
                [~, RSize, Rgen, ~, ~] = InfectionProcessFull(NewM5, eps(i), C, 10,Age,RelTrans,RelInf, Death_Prop);
                if abs(Rgen(5) - Rgen(4))/Rgen(4) > 0.05
                    [~, RSize, Rgen, ~, ~] = InfectionProcessFull(NewM5, eps(i), C, 5,Age,RelTrans,RelInf, Death_Prop);
                end
            end
            R5(j,i) = RSize;        
            Check5(j,i) = abs(Rgen(5) - Rgen(4))/Rgen(4);       
            D5(j,i) = Deaths/length(NewM5); 
 
            %Scenario 6
            NewB6 = PruneMatrixFull(B6, tauB(i), 'B', Age, RelTrans, RelInf);
            NewBa6 = PruneMatrixFull(Ba6, tauB(i), 'B', Age, RelTrans, RelInf);
            NewM6 = 1*sparse((NewH|NewB6)|NewBa6);
            [~, RSize, Rgen, ~, Deaths] = InfectionProcessFull(NewM6, eps(i), C, 100,Age,RelTrans,RelInf, Death_Prop);
            if abs(Rgen(5) - Rgen(4))/Rgen(4) > 0.05
                [~, RSize, Rgen, ~, ~] = InfectionProcessFull(NewM6, eps(i), C, 10,Age,RelTrans,RelInf, Death_Prop);
                if abs(Rgen(5) - Rgen(4))/Rgen(4) > 0.05
                    [~, RSize, Rgen, ~, ~] = InfectionProcessFull(NewM6, eps(i), C, 10,Age,RelTrans,RelInf, Death_Prop);
                end
            end
            R6(j,i) = RSize;        
            Check6(j,i) = abs(Rgen(5) - Rgen(4))/Rgen(4);       
            D6(j,i) = Deaths/length(NewM6);
               
    end
end




