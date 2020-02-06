% HWK 9 Part 1
% Macky Brock McWhirter
% Yule-Walker AR (all-pole method)
clear all;
close all;
clc;

% Test Signal read-in
test_signal = load("test_signal.mat");
x = test_signal.test_signal;
fs = 500;
p = 225;


% Yule-Walker aryule Method
[a, e] = aryule(x,p);
[H, F] = freqz(sqrt(e),a);

figure();
plot(F, 10*log10(abs(H)))
xlabel('Frequency (Hz)')
ylabel('PSD (dB/Hz)')
title('PSD (using aryule)')


% Yule-Walker PSD
figure();
[Pxx,f] = pyulear(x,p,512,fs);
plot(f, 10*log10(Pxx))
xlabel('Frequency (Hz)')
ylabel('PSD (dB/Hz)')
title('PSD (using pyulear)')


