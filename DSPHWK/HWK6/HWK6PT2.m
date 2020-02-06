% DSP Homework 6 Problem 2
% Macky Brock McWhirter
% October 18th, 2019
close all;
clear all;
clc;

equinox_original = audioread('equinox-48KHz.wav');
toneramp_original = audioread('toneramp.wav');

toneramp_1c = audioread('toneramp_p1.wav');
equinox_1d = audioread('equinox_p1.wav');

fs = 8000;
fsup = 48000;

% Amplitude Response
%{
dt = 1/fs;
t = 0:dt:(length(equinox_1c)*dt)-dt;
figure();
stem(t,equinox_1c);
xlim([0 0.003]);
ylim([0 0.003]);
xlabel('Seconds')
ylabel('Amplitude')
title('Equinox (8 kHz)')

%}

% Frequency vector
fft_size = fs;
fd_signal = fft(equinox_1d, fft_size);
f_step = fs/fft_size; 
fvec = 0:f_step:(fs-f_step);
figure();
stem(fvec, abs(fd_signal));
title("Equinox (before Upsampling)");

% Frequency vector
fft_size = fs;
fd_signal = fft(toneramp_1c, fft_size);
f_step = fs/fft_size; 
fvec = 0:f_step:(fs-f_step);
figure();
stem(fvec, abs(fd_signal));
title("ToneRamp (before Upsampling)");

% Upsample by a factor of 6 using Zero Insertion
equinox_upsample = upsample(equinox_1d,6);
toneramp_upsample = upsample(toneramp_1c,6);

% Frequency vector
fft_size = fsup;
fd_signal = fft(equinox_upsample, fft_size);
f_step = fsup/fft_size; 
fvec = 0:f_step:(fsup-f_step);
figure();
stem(fvec, abs(fd_signal));
title("Equinox (after Upsampling)");

% Frequency vector
fft_size = fsup;
fd_signal = fft(toneramp_upsample, fft_size);
f_step = fsup/fft_size; 
fvec = 0:f_step:(fsup-f_step);
figure();
stem(fvec, abs(fd_signal));
title("Toneramp (after Upsampling)");

% Image Rejection Filter
figure()
b = fir1(115,0.16);
freqz(b,1);
title('Frequency Response of Image Rejection')

equinox_filter = filter(b,1,equinox_upsample);
toneramp_filter = filter(b,1,toneramp_upsample);

% Frequency vector
fft_size = fsup;
fd_signal = fft(equinox_filter, fft_size);
f_step = fsup/fft_size; 
fvec = 0:f_step:(fsup-f_step);
figure();
stem(fvec, abs(fd_signal));
title("Equinox (after filtering)")

% Frequency vector
fft_size = fsup;
fd_signal = fft(toneramp_filter, fft_size);
f_step = fsup/fft_size; 
fvec = 0:f_step:(fsup-f_step);
figure();
stem(fvec, abs(fd_signal));
title("Toneramp (after filtering)")

audiowrite('toneramp_p2.wav',toneramp_filter,fsup);
audiowrite('equinox_p2.wav',equinox_filter,fsup);
