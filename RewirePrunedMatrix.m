function [Mnew] = RewirePrunedMatrix(M,p, Cnum)

%This function takes a pruned adjacency matrix M and recconects a number of edges
%that is proprotional to the value p. 

%Input:
%   - M is the adjacency matrix for the household or bubble contacts.
%   - p is the proportion of connections we want to reconnect. 
%   - Cnum is the scenario C2 or C3

%Output:
%   - NewM is the adjacency matrix after it has been pruned.
%   - Phi is the clusetring coefficient.

%Note: M and Mnew are N x N matrices where N is the population size.

%Authors: Trystan Leng.
%Last update 13/08/2020.


if Cnum == 'C3'
    N = length(M);
    
    %working out if the matrix is household or not.
    if trace(M) > 0
        M = M - speye(N,N); %consider only upper triangular and remove diagonal
        Type = 'H';
    else
        Type = 'B';
    end
    
    [x,y]=find(M);   % links without the diagonal.
    
    r = randperm(length(x), round(length(x)*p)); % randomly choose links to swap
    
    %making the length of r even if r is odd
    if mod(length(r),2) ~= 0
        r(end) = [];
    end
    
    while ~isempty(r)
        
        X = x(r(1)); Y = y(r(1));
        
        
        if M(X,Y) == 1 %if the link is still there      
        
            nX = 1; nY = 1;
            % this while loop checks that all 4 people are unique
            while length(unique([X Y nX nY]))<4  || M(X,nY) + M(nY,X) + M(nX,Y) + M(Y,nX) >0
                r2 = randi(length(r) - 1) + 1;
               
                nX = x(r(r2)); nY = y(r(r2));
          
     
            end
            
            M(X,Y) = 0; %remove link
            M(nX,nY) =0; %remove link
            
            
            M(X,nY) = 1; %add link
            M(nX, Y) = 1; %add link
            
            %deleting used r elements
            %need to delete this one first as the other way round would
            %change the element that r2 refers to
            r(r2) = [];
            r(1) = [];
            
        end
        
    end
    
    Mnew = M;
    
    if Type == 'H'
       Mnew = Mnew + speye(length(M));
    end

elseif Cnum == 'C2'

    %%%NEW Version that takes into account links going both ways

    N = length(M);

    %working out if the matrix is household or not.
    if trace(M) > 0
        M = M - speye(N,N); %consider only upper triangular and remove diagonal
        Type = 'H';
    else
        Type = 'B';
    end

    %find all links infecting both ways
    M1 = 1*(M&M');
    Morig1 = M1;

    %find all links not infecting both ways
    M2 = M - M1;
    Morig2 = M2;

    %do all links not infecting both ways
     [x,y]=find(M2);   % links without the diagonal.

    r = randperm(length(x), round(length(x)*p)); % randomly choose links to swap

    %making the length of r even if r is odd
    if mod(length(r),2) ~= 0
        r(end) = [];
    end

    while ~isempty(r)

        X = x(r(1)); Y = y(r(1));


        if M2(X,Y) == 1 %if the link is still there      

            nX = 1; nY = 1;
            % this while loop checks that all 4 people are unique
            while length(unique([X Y nX nY]))<4  || M2(X,nY) + M(nY,X) + M(nX,Y) + M(Y,nX) >0
                r2 = randi(length(r) - 1) + 1;

                nX = x(r(r2)); nY = y(r(r2));


            end

            M2(X,Y) = 0; %remove link
            M2(nX,nY) =0; %remove link


            M2(X,nY) = 1; %add link
            M2(nX, Y) = 1; %add link

            %deleting used r elements
            %need to delete this one first as the other way round would
            %change the element that r2 refers to
            r(r2) = [];
            r(1) = [];

        end

    end

    Mnew2 = M2;


    M1 = triu(M1);

    [x,y]=find(M1);   % links without the diagonal.

    r = randperm(length(x), round(length(x)*p)); % randomly choose links to swap

    %making the length of r even if r is odd
    if mod(length(r),2) ~= 0
        r(end) = [];
    end

    while ~isempty(r)

        X = x(r(1)); Y = y(r(1));


        if M1(X,Y) == 1 %if the link is still there      

            nX = 1; nY = 1;
            % this while loop checks that all 4 people are unique
            while length(unique([X Y nX nY]))<4  || M1(X,nY) + M1(nY,X) + M1(nX,Y) + M1(Y,nX) >0
                r2 = randi(length(r) - 1) + 1;

                nX = x(r(r2)); nY = y(r(r2));


            end

            M1(X,Y) = 0; %remove link
            M1(nX,nY) =0; %remove link

            if X < nY %so that we add link to upper diagonal matrix
                M1(X,nY) = 1; %add link
            else
                M1(nY, X) = 1;
            end

            if nX < Y
                M1(nX, Y) = 1; %add link
            else
                M1(Y, nX) = 1;
            end

            %deleting used r elements
            %need to delete this one first as the other way round would
            %change the element that r2 refers to
            r(r2) = [];
            r(1) = [];

        end

    end

    Mnew1 = M1 + M1';


    Mnew = Mnew1 + Mnew2;

end

