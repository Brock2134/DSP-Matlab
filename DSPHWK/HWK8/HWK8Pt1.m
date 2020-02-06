% HWK 8 Part 1
% Macky Brock McWhirter
% Bartlett Method
close all;
clc;
clear all;

%% Test Signal Initial Analysis


% Test Signal read-in
test_signal = load("test_signal.mat");
x = test_signal.test_signal;

% Amplitude Response of Test_signal
fs = 500;
dt = 1/fs;
t = (0:dt:(length(x)*dt)-dt);
figure();
plot(t,x);
xlabel('Seconds')
ylabel('Amplitude')
title('Test Signal')


% Frequency Spectrum of Test_signal
fd_signal = fft(x, 2500);
f_step = fs/2500; 
fvec = 0:f_step:(fs-f_step);
figure();
stem(fvec, abs(fd_signal));
title("Test Signal Frequency Spectrum ");
xlabel('Hz');



% Frequency Spectrum using Power
% 2500 point DFT
nfft = 2500;
y = fft(x,nfft);
n = length(x);
f = (0:n-1)*(fs/n);
power = abs(y).^2/n;
yshift = fftshift(y);
fshift = (-n/2:n/2-1)*(fs/n);
powershift = abs(yshift).^2/n;

% Frequency Spectrum Power Graph
figure();
stem(fshift,powershift)
xlabel('Frequency')
ylabel('Power')
title('Test Signal Frequency Spectrum using Power');


% SNR
figure();
snr(x);

%% Bartlett Method

N = 450;

% Bartlett Window
window = bartlett(N);

% 0 overlap used in pwelch
[Pxx, W] = pwelch(x, window, 0);
    
% Plot the frequency response magnitude
figure(); 
plot(W, Pxx); 
title("Bartlett Method");

% Zero overlap used in pwelch
[Sxx, f] = pwelch(x, window, 0);
rbw = enbw(W,fs);
figure();
snr(Sxx,f,rbw,'power');
