% Homework 2
% Macky McWhirter
% 9/13/2019
% This homework has been modified from the original FFT
% size demo.
% Samplig frequency and time-interval definitions
fs = 64;
t_start = 0;
t_end = 1;

% Generate time-series vector for sampled signal
ts = 1/fs;
tvec = t_start:ts:t_end;

% Generate a test signal at this sampling rate

test_signal = sin(2*pi*4*tvec) + sin(2*pi*7*tvec);

% Plot the signal
% Since this is a discrete signal, it should not be plotted with lines
%figure()
%stem(tvec, test_signal)
%xlabel('time (secs)');
%ylabel('Test signal');

% Custom size FFT
fft_size = 64;
fd_signal = fft(test_signal, fft_size);

% Frequency vector
f_step = fs/fft_size; 
fvec = 0:f_step:(fs-f_step);

figure();
stem(fvec, abs(fd_signal));