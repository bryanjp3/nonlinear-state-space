
clc
clear all
format compact

%Load input signal from .mp3 file
Fs = 44100;
samples = [1,1*Fs];


% [y, Fs] = audioread('C:\Users\Dad\Documents\MATLAB\tube1\sound\a#2u.wav',samples);
[y, Fs] = audioread('C:\Users\japtain cack\Desktop\tube1\sound\a#2u.wav',samples);
y = y(:,1)';
N = length(y);


% RC values
Ra1 = 100e3;
Rg = 1e3;
Rk1 = .820e3;
Rk2 = 50e3;
Ck = 25e-6;

Fs = 1/Fs;

a = 2/Fs;

% Initialize Matrices
A = [-1/(Ck*Rk1)];

B = [0, 0];
 
C = [1/Ck, 1/Ck, 0, 0];

D = [-1; 
     -1;
      0;
      0];
 
E = [1, 0; 
     0, 1;
     0, 1;
     0, 1];

F = [-Rg, 0, 0, 0;
      0,-Ra1, -Ra1, 0;
      0, -Ra1,-Ra1-Rk2, -Rk2;
      0, 0, -Rk2, -Rk2];

A0=1*2;

u = [y*A0; 325+zeros(1,N)]; % vector of inputs
%  u = [0*sin(.01*pi*(1:N)); 325+zeros(1,N)];
x = zeros(1,N);
x(1) = 1.0;
H = (a*eye(1)-A)^-1;
K = D*H*C+F;
temp = zeros(4,N);



for n = 2:N
    p = D*H*( (a*eye(1) + A)*x(:,n-1) + B*( u(:,n) + u(:,n-1) ) + C*temp(:,n-1) )  + E*u(:,n);
        
    v = [0; 50; 0; 50]; %initial guess
    
    % After first iteration use previous value as guess
    if n > 2
        v = input;
    end
    
    % Newton Raphson Algorithm
    
    G = [10;10;10;10];
    count = 1;
    while sum(abs(G)) > 1e-2 & count < 22
        
        
        G = p - v + K*[gridCurrent(v(2),v(1));
                       anodeCurrent(v(2),v(1)); 
                       gridCurrent(v(4),v(3)); 
                       anodeCurrent(v(4),v(3))];
        Vak1 = v(2);
        Vgk1 = v(1);
        Vak2 = v(4);
        Vgk2 = v(3);
        
        h = 1e-6;
        
        %t = anodeCurrent(Vak1,Vgk1);
        j11 = (gridCurrent(Vak1, Vgk1+h) -  gridCurrent(Vak1, Vgk1))/h;
        j12 = 0;
        
        j21= ( anodeCurrent(Vak1, Vgk1+h) - anodeCurrent( Vak1, Vgk1 ) )/h;
        j22 = (anodeCurrent(Vak1+h, Vgk1) - anodeCurrent( Vak1, Vgk1 ) )/h;
        
        j33 = (gridCurrent(Vak2, Vgk2+h) -  gridCurrent(Vak2, Vgk2))/h;
        j34 = 0;
        
        t = anodeCurrent(Vak2,Vgk2);
        j43 = (anodeCurrent(Vak2, Vgk2+h) - t)/h;
        j44 = (anodeCurrent(Vak2+h, Vgk2) - t)/h;
        
        Jf = [ j11, j12, 0, 0; 
               j21, j22, 0, 0;
               0, 0, j33, j34;
               0, 0, j43, j44]; %jacobian of f
        
        Jg = K*Jf - eye(4);
        
        
        v = v - Jg^-1*G;
        input = v;
        count = count + 1;
        
    end
    vs(:,n)=v;
    gg(:,n)=G;
    ii(:,n) =   [gridCurrent(v(2),v(1));
                 anodeCurrent(v(2),v(1));                  
                 gridCurrent(v(4),v(3)); 
                 anodeCurrent(v(4),v(3))];
                   
    temp(:,n) = ii(:,n);

    x(:,n) = H*(a*eye(1)+A)*x(:, n-1) + H*B*(u(:,n)+u(:,n-1))+ H*C*(temp(:, n) + temp(:, n-1));
    
end 

out = (ii(4,:)+ii(3,:)*Rk2);
out = out(10:end);
out = out - mean(out);
plot(out);

plot(u(1,:)-ii(1,:)*Rg)

subplot(2,1,1)
plot([y])
grid on
subplot(2,1,2)
plot(-out)
grid on


% sound(y, 1/Fs);
% sound(out/max(abs(out))/4, 1/Fs);

out2 = toneStack(out, 1,0,1);
sound(out2/max(abs(out2))*.5, 1/Fs);
plot([out(1000:2000)', out2(1000:2000)'])