% The MIT License (MIT)
% 
% Copyright (c) 2015 John Bryan
% 
% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files (the "Software"), to deal
% in the Software without restriction, including without limitation the rights
% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
% copies of the Software, and to permit persons to whom the Software is
% furnished to do so, subject to the following conditions:
% 
% The above copyright notice and this permission notice shall be included in all
% copies or substantial portions of the Software.
% 
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
% SOFTWARE.

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

