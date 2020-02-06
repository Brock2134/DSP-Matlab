% HWK 9 Part 3
% Macky Brock McWhirter
% Auto-Regressive Model
clear all;
close all;
clc;

len = 60;


% Generate a whitenoise input vector
x = rand(len, 1)-0.5;
    
% Run through the system
y = hidden_system(x);

p = 9;

% Auto-Regressive Method

%a = aryule(y,p);
a = arburg(y,p);
figure();
freqz(1,a,[],500);

figure();

[H, F] = freqz(1,a,[],500);
plot(F, 20*log10(abs(H)))
xlabel('Frequency (Hz)')
ylabel('PSD (dB/Hz)')

[Pxx, W] = pyulear(y,p);

% Plot the frequency response magnitude
figure(); 
plot(W, Pxx); title("|H(jw)|");

