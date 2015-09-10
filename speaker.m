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

function [ output] = speaker( input )
%SPEAKER Summary of this function goes here
%   Detailed explanation goes here

N = length(input);
U = input;
X = zeros(3,N);

R1 = 5.8;
R2 = 5.23;
C = 321e-6;
L1 = .00055;
L2 = .00055;


A = [-1/(C*R2), 1/C, -1/C;
     -1/L1, -R1/L1, 0;
     1/L2, 0, 0];
 
B = [0;1/L1;0];


h = 1/44100;
H = (2/h*eye(3)-A);
for n = 1:N-1
   X(:,n+1) =  H^-1*( (2/h*eye(3)+A)*X(:,n)+ B*(U(n) + U(n+1)) );
    
end

output = X(1,:)/R2;
end

