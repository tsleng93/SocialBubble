function B2 = PartialBubble(B, p, d)

%B is bubble matrix
%p is probability of rewiring
%d% is proportion of households who are supposed to expand bubbles

%B2 = RewireMatrix(B,p);
B2 = RewireMatrix2(B,p);

[x,y] = find(B2);

%x2 = x(x> 0 & y > 0);
%y2 = y(x > 0 & y > 0);


x2 = x(x> d*length(B) & y > d*length(B));
y2 = y(x > d*length(B) & y > d*length(B));

B2(x2,y2) = 0;
