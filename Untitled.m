clc
clear all
Fs = 44100;
samples = [114*Fs,116*Fs];
[y, Fs] = audioread('guitar.mp3', samples);
% sound(y, 44.1e3)


% input = 1*sin(.01*(1:N));
input = y(1791:1791+100,1);

r=repmat(input,1,10)';
 r=r(:)';

input = r;

Fs = Fs*1000;

N = length(input);

Uarr = [input; input*0+300];
Xarr = zeros(2,N);
Xarr(:,1) = [0;200];
Warr = zeros(1,N);


for n = 2:N-1
    U = Uarr(:,n);
    X = Xarr(:,n-1);
    % minimize g
    W = .6; % initial guess
    
    if n > 2
       W = Warr(:,n-1);
    end
    
    count=1;
    maxCount = 19;
    while count < maxCount
        dx = 1e-9;
        dg = (g(W+dx, X, U)-g(W, X, U))/dx;
        
        W = W - g(W, X, U)/dg;
        count = count + 1;
        if g(W, X, U) < 1e-7
           count = 20; 
        end
    end
    k1 = Fs^-1*f(W,X,U);
    X2 = X + Fs^-1*f(W+k1/2, X, .5*(U+Uarr(:,n+1)));
    Xarr(:,n) = X2;
    Warr(:,n) = W;
    
    if n > 1500
       Fs =  44.1e3*1000;
    end
end

plot(Warr)

% sound(Warr, 44.1e3)
