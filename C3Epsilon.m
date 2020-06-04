function [eps2, RB2, RB3, Reps2] = C3Epsilon(B, C, Age, RelTrans, RelInf, tauB, eps)

CB = sum(B);

for i = 1:length(RelInf)
    AInf(Age==i) = RelInf(i);
    ATrans(Age==i) = RelTrans(i);
end

KB = sum(sum((ATrans.*B).*(AInf./CB)'));
Keps = sum(AInf./C).*sum(ATrans)/length(C);

eps2 = KB/Keps*tauB + eps;
Reps2 = eps*Keps;
RB2 = tauB*KB;
