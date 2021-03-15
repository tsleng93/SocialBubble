%This .mfile produces the .csv files require to produces Figures 3,8
%and extended data, after running 'MainCode.m'


%Set base deaths from comparator scenario C1
if size(Dc1,1) == 1
    meanBaseDeaths = Dc1;
else
    meanBaseDeaths = mean(Dc1);
end

%Fill in table
for i = 1:12
   
    mb = [meanBaseDeaths((i-1)*3 + 1), meanBaseDeaths((i-1)*3+2), meanBaseDeaths((i-1)*3+3)];
    
    if i == 4
        Rtable((i-1)*9 + 1,1) = 0.7;
        Rtable((i-1)*9 + 1,2) = 0.7;
        Rtable((i-1)*9 + 1,3) = 0.7;
    elseif i == 5
        Rtable((i-1)*9 + 1,1) = 0.9;
        Rtable((i-1)*9 + 1,2) = 0.9;
        Rtable((i-1)*9 + 1,3) = 0.9;
    else
        Rtable((i-1)*9 + 1,1) = 0.8;
        Rtable((i-1)*9 + 1,2) = 0.8;
        Rtable((i-1)*9 + 1,3) = 0.8;
    end
    
    
	Rtable((i-1)*9 + 2,1) = mean(Rc2(:,(i-1)*3 + 1));
	Rtable((i-1)*9 + 2,2) = mean(Rc2(:,(i-1)*3 + 2));
	Rtable((i-1)*9 + 2,3) = mean(Rc2(:,(i-1)*3 + 3));
    
    Rtable((i-1)*9 + 3,1) = mean(Rc3(:,(i-1)*3 + 1));
	Rtable((i-1)*9 + 3,2) = mean(Rc3(:,(i-1)*3 + 2));
	Rtable((i-1)*9 + 3,3) = mean(Rc3(:,(i-1)*3 + 3));
    
	Rtable((i-1)*9 + 4,1) = mean(R1(:,(i-1)*3 + 1));
	Rtable((i-1)*9 + 4,2) = mean(R1(:,(i-1)*3 + 2));
	Rtable((i-1)*9 + 4,3) = mean(R1(:,(i-1)*3 + 3));
   
	Rtable((i-1)*9 + 5,1) = mean(R2(:,(i-1)*3 + 1));
	Rtable((i-1)*9 + 5,2) = mean(R2(:,(i-1)*3 + 2));
	Rtable((i-1)*9 + 5,3) = mean(R2(:,(i-1)*3 + 3));
    
	Rtable((i-1)*9 + 6,1) = mean(R3(:,(i-1)*3 + 1));
	Rtable((i-1)*9 + 6,2) = mean(R3(:,(i-1)*3 + 2));
	Rtable((i-1)*9 + 6,3) = mean(R3(:,(i-1)*3 + 3));
	Rtable((i-1)*9 + 7,1) = mean(R4(:,(i-1)*3 + 1));
	Rtable((i-1)*9 + 7,2) = mean(R4(:,(i-1)*3 + 2));
	Rtable((i-1)*9 + 7,3) = mean(R4(:,(i-1)*3 + 3));
	Rtable((i-1)*9 + 8,1) = mean(R5(:,(i-1)*3 + 1));
	Rtable((i-1)*9 + 8,2) = mean(R5(:,(i-1)*3 + 2));
	Rtable((i-1)*9 + 8,3) = mean(R5(:,(i-1)*3 + 3));
	Rtable((i-1)*9 + 9,1) = mean(R6(:,(i-1)*3 + 1));
	Rtable((i-1)*9 + 9,2) = mean(R6(:,(i-1)*3 + 2));
	Rtable((i-1)*9 + 9,3) = mean(R6(:,(i-1)*3 + 3));

    Checktable((i-1)*9 + 1,1) = 0;
    Checktable((i-1)*9 + 1,2) = 0;
    Checktable((i-1)*9 + 1,3) = 0;
    
    Checktable((i-1)*9 + 2,1) = mean(Checkc2(:,(i-1)*3 + 1));
    Checktable((i-1)*9 + 2,2) = mean(Checkc2(:,(i-1)*3 + 2));
    Checktable((i-1)*9 + 2,3) = mean(Checkc2(:,(i-1)*3 + 3));
    
    Checktable((i-1)*9 + 3,1) = mean(Checkc3(:,(i-1)*3 + 1));
    Checktable((i-1)*9 + 3,2) = mean(Checkc3(:,(i-1)*3 + 2));
    Checktable((i-1)*9 + 3,3) = mean(Checkc3(:,(i-1)*3 + 3));
    
    Checktable((i-1)*9 + 4,1) = mean(Check1(:,(i-1)*3 + 1));
    Checktable((i-1)*9 + 4,2) = mean(Check1(:,(i-1)*3 + 2));
    Checktable((i-1)*9 + 4,3) = mean(Check1(:,(i-1)*3 + 3));
   
    Checktable((i-1)*9 + 5,1) = mean(Check2(:,(i-1)*3 + 1));
    Checktable((i-1)*9 + 5,2) = mean(Check2(:,(i-1)*3 + 2));
    Checktable((i-1)*9 + 5,3) = mean(Check2(:,(i-1)*3 + 3));
    
    Checktable((i-1)*9 + 6,1) = mean(Check3(:,(i-1)*3 + 1));
    Checktable((i-1)*9 + 6,2) = mean(Check3(:,(i-1)*3 + 2));
    Checktable((i-1)*9 + 6,3) = mean(Check3(:,(i-1)*3 + 3));
    Checktable((i-1)*9 + 7,1) = mean(Check4(:,(i-1)*3 + 1));
    Checktable((i-1)*9 + 7,2) = mean(Check4(:,(i-1)*3 + 2));
    Checktable((i-1)*9 + 7,3) = mean(Check4(:,(i-1)*3 + 3));
    Checktable((i-1)*9 + 8,1) = mean(Check5(:,(i-1)*3 + 1));
    Checktable((i-1)*9 + 8,2) = mean(Check5(:,(i-1)*3 + 2));
    Checktable((i-1)*9 + 8,3) = mean(Check5(:,(i-1)*3 + 3));
    Checktable((i-1)*9 + 9,1) = mean(Check6(:,(i-1)*3 + 1));
    Checktable((i-1)*9 + 9,2) = mean(Check6(:,(i-1)*3 + 2));
    Checktable((i-1)*9 + 9,3) = mean(Check6(:,(i-1)*3 + 3));


    Dtable((i-1)*9 + 1,1) = 1;
    Dtable((i-1)*9 + 1,2) = 1;
    Dtable((i-1)*9 + 1,3) = 1;
    
    
    Dtable((i-1)*9 + 2,1) = mean(Dc2(:,(i-1)*3 + 1))/mb(1);
    Dtable((i-1)*9 + 2,2) = mean(Dc2(:,(i-1)*3 + 2))/mb(2);
    Dtable((i-1)*9 + 2,3) = mean(Dc2(:,(i-1)*3 + 3))/mb(3);
    Dtable((i-1)*9 + 3,1) = mean(Dc3(:,(i-1)*3 + 1))/mb(1);
    Dtable((i-1)*9 + 3,2) = mean(Dc3(:,(i-1)*3 + 2))/mb(2);
    Dtable((i-1)*9 + 3,3) = mean(Dc3(:,(i-1)*3 + 3))/mb(3);
    
    
    Dtable((i-1)*9 + 4,1) = mean(D1(:,(i-1)*3 + 1))/mb(1);
    Dtable((i-1)*9 + 4,2) = mean(D1(:,(i-1)*3 + 2))/mb(2);
    Dtable((i-1)*9 + 4,3) = mean(D1(:,(i-1)*3 + 3))/mb(3);
    
    Dtable((i-1)*9 + 5,1) = mean(D2(:,(i-1)*3 + 1))/mb(1);
    Dtable((i-1)*9 + 5,2) = mean(D2(:,(i-1)*3 + 2))/mb(2);
    Dtable((i-1)*9 + 5,3) = mean(D2(:,(i-1)*3 + 3))/mb(3);
    
    Dtable((i-1)*9 + 6,1) = mean(D3(:,(i-1)*3 + 1))/mb(1);
    Dtable((i-1)*9 + 6,2) = mean(D3(:,(i-1)*3 + 2))/mb(2);
    Dtable((i-1)*9 + 6,3) = mean(D3(:,(i-1)*3 + 3))/mb(3);
    Dtable((i-1)*9 + 7,1) = mean(D4(:,(i-1)*3 + 1))/mb(1);
    Dtable((i-1)*9 + 7,2) = mean(D4(:,(i-1)*3 + 2))/mb(2);
    Dtable((i-1)*9 + 7,3) = mean(D4(:,(i-1)*3 + 3))/mb(3);
    Dtable((i-1)*9 + 8,1) = mean(D5(:,(i-1)*3 + 1))/mb(1);
    Dtable((i-1)*9 + 8,2) = mean(D5(:,(i-1)*3 + 2))/mb(2);
    Dtable((i-1)*9 + 8,3) = mean(D5(:,(i-1)*3 + 3))/mb(3);
    Dtable((i-1)*9 + 9,1) = mean(D6(:,(i-1)*3 + 1))/mb(1);
    Dtable((i-1)*9 + 9,2) = mean(D6(:,(i-1)*3 + 2))/mb(2);
    Dtable((i-1)*9 + 9,3) = mean(D6(:,(i-1)*3 + 3))/mb(3);

end


%Put into correct format
Rtable2 = readtable('Tab_Rtemplate.csv');
Dtable2 = readtable('Tab_Dtemplate.csv');
Rtable2(:, 9:11) = array2table(Rtable);
Rtable2(:, 12:14) = array2table(Checktable);
Dtable2(:, 9:11) = array2table(Dtable);
%Rtable2= array2table([Rtable, Checktable]);
%Dtable2 = array2table(Dtable);



%Write files
writetable(Rtable2, 'Tab_Rcurrent.csv');
writetable(Dtable2, 'Tab_Dcurrent.csv');
