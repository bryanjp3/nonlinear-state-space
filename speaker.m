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

