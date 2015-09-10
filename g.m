function [ output ] = g( W, X, U )
%G Summary of this function goes here
%   Detailed explanation goes here

Rg = 1e3;
Ra1 = 100e3;
ia1 = anodeCurrent(W(1)-X(1), W(1)-X(2) - X(1) );
ig1 = gridCurrent(W(1)-X(1), W(1)-X(2) - X(1) );

ira1 = (U(2)-W(1))/Ra1;
irg = (U(1) - (W(1)-X(2)))/Rg;
icgp = ig1 - (U(1) - (W(1)-X(2)))/Rg;

output = [ ira1 - ia1 - icgp];

end

