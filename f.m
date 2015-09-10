function [ output ] = f( W, X, U )
%G Summary of this function goes here
%   Detailed explanation goes here

Rg = 1e3;
Ra1 = 100e3;
Cgp = 2e-11;
Ck = 20e-6;
Rk = 1e3;

ia1 = anodeCurrent(W(1)-X(1), W(1)-X(2) - X(1) );
ig1 = gridCurrent(W(1)-X(1), W(1)-X(2) - X(1) );


icgp = ig1 - (U(1) - (W(1)-X(2)))/Rg;
ick = ia1 + ig1 - X(1)/Rk;

output = [1/Ck*ick
          1/Cgp*icgp];

end

