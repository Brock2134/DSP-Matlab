% HWK 8 Part 2
% Macky Brock McWhirter
% Welch Method
close all;
clc;
clear all;

% Test Signal read-in
test_signal = load("test_signal.mat");
x = test_signal.test_signal;
fs = 500;

%% Welch Method ~ Rectangular Window
% N ~ Window Size

N = 200;

% Rectangular Window
window = rectwin(N);


[Pxx, W] = pwelch(x, window, N/2);
    
% Plot the frequency response magnitude
figure(); 
plot(W, Pxx); 
title("Rectangular Window");


[Sxx, f] = pwelch(x, window, N/2);
rbw = enbw(W,fs);
figure();
snr(Sxx,f,rbw,'power');


%% Welch Method ~ Hanning Window
N = 200;

window = hanning(N);
[Pxx, W] = pwelch(x, window, N/2);
    
% Plot the frequency response magnitude
figure(); 
plot(W, Pxx); 
title("Hanning Window");

[Sxx, f] = pwelch(x, window, N/2);
rbw = enbw(window,fs);
figure();
snr(Sxx,f,rbw,'power');
