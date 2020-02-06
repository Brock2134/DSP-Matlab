% HWK 9 Part 2
% Macky Brock McWhirter
% Burg Methodology
clear all;
close all;
clc;

% Test Signal read-in
test_signal = load("test_signal.mat");
x = test_signal.test_signal;
fs = 500;
p = 125;

% Burg Methodology
figure();
a = arburg(x,p);
[H, F] = freqz(1,a,512,fs);
plot(F, 20*log10(abs(H)))
xlabel('Frequency (Hz)')
ylabel('PSD (dB/Hz)')
title('burg PSD')



% Burg PSD
figure();
[Pxx,f] = pburg(x,p,512,fs);
plot(f, 10*log10(Pxx))
xlabel('Frequency (Hz)')
ylabel('PSD (dB/Hz)')
title('pburg PSD')
%legend('True PSD','Pyulear PSD Estimate')

