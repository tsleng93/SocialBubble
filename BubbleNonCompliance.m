function B2 = BubbleNonCompliance(B, p, d)

%This function forms adjacency matrix for bubble connections. It takes the
%household connection matrix and will create bubbles which are formed of
%houses which are of size equal to or smaller than the number maxnum


%Input:
%   - B is the adjacency matrix for bubble connections.
%   - p is the proportion of connections that we want to recconect.
%   - d is the proportion of households who are supposed to expand bubbles

%Output:
%   - B2 is the adjacency matrix for bubble connections.

%Authors: Trystan Leng
%Last update 29/05/2020.

B2 = RewireMatrix2(B,p);

[x,y] = find(B2);

x2 = x(x> d*length(B) & y > d*length(B));
y2 = y(x > d*length(B) & y > d*length(B));

B2(x2,y2) = 0;
