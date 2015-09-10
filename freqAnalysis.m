
clc
clear all
format compact

%Load input signal from .mp3 file
Fs = 44100;
samples = [1,1*Fs];


% [y, Fs] = audioread('C:\Users\Dad\Documents\MATLAB\tube1\sound\a#2u.wav',samples);

[y, Fs] = audioread('C:\Users\japtain cack\Desktop\tube1\sound\e2d.wav',samples);
nb = 2^15;
y = y(:,1)';
y = y(1:nb);

% y = cos(2*pi*2000*(1:nb)/Fs);
N = length(y);


yhat = fft(y, Fs);
area(abs(yhat(1:nb/4)))
grid on
sound(y, Fs)
% plot(y)