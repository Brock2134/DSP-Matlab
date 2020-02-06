% DSP Homework 6 Problem 3
% Macky Brock McWhirter
% October 18th, 2019
close all;
clear all;
clc;

equinox_original = audioread('equinox-48KHz.wav');

fs = 48000;

% Frequency vector before any downsampling
fft_size = fs;
fd_signal = fft(equinox_original, fft_size);
f_step = fs/fft_size; 
fvec = 0:f_step:(fs-f_step);
figure();
stem(fvec, abs(fd_signal));
title("Equinox (before Downsampling & Filter) Spectrum");

% Lower Half
figure()
b = fir1(120,0.5);
freqz(b,1);
title('Frequency Response of Anti-Aliasing Filter');

equinox_lpfilter = filter(b,1,equinox_original);
equinox_lpdecimate = decimate(equinox_lpfilter,2);

% Frequency vector
fsds = fs/2; % 24000
fft_size = fsds;
fd_signal = fft(equinox_lpdecimate, fft_size);
f_step = fsds/fft_size; 
fvec = 0:f_step:(fsds-f_step);
figure();
stem(fvec, abs(fd_signal));
title("Equinox (after Downsampling & Filter) Spectrum");

audiowrite('equinox_p3_LOWER.wav',equinox_lpdecimate,fsds);

% Upper Half

figure()
b = fir1(120,0.5,'high');
freqz(b,1)
title('Frequency Response of Image-Rejection Filter')

equinox_decimate = decimate(equinox_original,2);
fft_size = fsds;
fd_signal = fft(equinox_decimate, fft_size);
f_step = fsds/fft_size; 
fvec = 0:f_step:(fsds-f_step);
figure();
stem(fvec, abs(fd_signal));
title("Equinox (after Downsampling (no HPF filter) Spectrum");

equinox_hpfilter = filter(b,1,equinox_decimate);

fft_size = fsds;
fd_signal = fft(equinox_hpfilter, fft_size);
f_step = fsds/fft_size; 
fvec = 0:f_step:(fsds-f_step);
figure();
stem(fvec, abs(fd_signal));
title("Equinox (after Downsampling (HPF filter) Spectrum");

audiowrite('equinox_p3_HIGHER.wav',equinox_hpfilter,fsds);

