function [ output ] = toneStack( input, t, m, l)
%TONESTACK Summary of this function goes here
%   Detailed explanation goes here
clc
% t = 1;
% m = 0;
% l = 0;

C1 = 0.25e-9;
C2 = 20e-9;
C3 = 20e-9;
R1 = 250e3;
R2 = 1e6;
R3 = 25e3;
R4 = 56e3;


a0 = 1;%

a1 = (C1*R1 + C1*R3 + C2*R3 + C2*R4 + C3*R4)+ m*C3*R3 +...%
    l*(C1*R2 + C2*R2);

a2 = m*(C1*C3*R1*R3 - C2*C3*R3*R4 + C1*C3*R3^2 + C2*C3*R3^2) +...
     l*m*(C1*C3*R2*R3 + C2*C3*R2*R3)-...
     m^2*(C1*C3*R3^2 + C2*C3*R3^2)+...
     l*(C1*C2*R2*R4+ C1*C2*R1*R2 + C1*C3*R2*R4 + C2*C3*R2*R4)+...
     (C1*C2*R1*R4 + C1*C3*R1*R4 + C1*C2*R3*R4 + C1*C2*R1*R3 + C1*C3*R3*R4 + C2*C3*R3*R4);

a3 = l*m*(C1*C2*C3*R1*R2*R3 + C1*C2*C3*R2*R3*R4)...
     -m^2*(C1*C2*C3*R1*R3^2 + C1*C2*C3*R3^2*R4)...
     +m*(C1*C2*C3*R3^2*R4 + C1*C2*C3*R1*R3^2- C1*C2*C3*R1*R3*R4)...
     + l*C1*C2*C3*R1*R2*R4+ C1*C2*C3*R1*R3*R4;

b1 =t*C1*R1+m*C3*R3+l*(C1*R2+C2*R2)+C1*R3+C2*R3;%

b2 = t*(C1*C2*R1*R4+C1*C3*R1*R4)-m^2*(C1*C3*R3*R3+C2*C3*R3*R3)...
      +m*(C1*C3*R1*R3 + C1*C3*R3*R3 + C2*C3*R3*R3)...
      +l*(C1*C2*R1*R2 + C1*C2*R2*R4 + C1*C3*R2*R4)...
      +l*m*(C1*C3*R2*R3 + C2*C3*R2*R3)...
      +(C1*C2*R1*R3 + C1*C2*R3*R4 + C1*C3*R3*R4);%

b3 = l*m*(C1*C2*C3*R1*R2*R3 + C1*C2*C3*R2*R3*R4)...%
     -m^2*(C1*C2*C3*R1*R3^2 + C1*C2*C3*R3^2*R4)...
     +m*(C1*C2*C3*R1*R3^2 + C1*C2*C3*R3^2*R4)...
     +t*C1*C2*C3*R1*R3*R4 - t*m*C1*C2*C3*R1*R3*R4...
     +t*l*C1*C2*C3*R1*R2*R4;
%%%%%%%%%
c = 2*44100;

C = [c; c^2; c^3];

B0 = [-b1, -b2, -b3]*C;
B1 = [-b1,  b2,  3*b3]*C;
B2 = [ b1,  b2, -3*b3]*C;
B3 = [ b1, -b2,  b3]*C;

A0 = -a0 + [-a1, -a2, -a3]*C;
A1 = -3*a0 + [-a1,  a2,  3*a3]*C;
A2 = -3*a0 + [ a1,  a2, -3*a3]*C;
A3 = -a0 + [ a1, -a2,  a3]*C;


output = filter([B0, B1, B2, B3],[A0, A1, A2, A3],input);



end

