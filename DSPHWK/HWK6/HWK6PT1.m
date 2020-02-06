% DSP Homework 6 Problem 1
% Macky Brock McWhirter
% October 18th, 2019
close all;
clear all;
clc;

toneramp = audioread('toneramp.wav');
equinox = audioread('equinox-48KHz.wav');

% Problem 1a
fs = 48000;
fs2 = 8000;

%sound(toneramp,fs); 
%sound(equinox,fs);

% Anti-Aliasing LPF at 48 kHz
b = fir1(115,0.16);

% Frequency Response of Filter
figure();
freqz(b,1);
title('Frequency Response (Problem 1a)')


% toneramp_filter = conv(toneramp,b);
% equinox_filter = conv(equinox,b);

% Problem 1b

toneramp_filter = filter(b,1,toneramp);
equinox_filter = filter(b,1,equinox);

% Amplitude Response
dt = 1/fs;
t = 0:dt:(length(toneramp_filter)*dt)-dt;
figure();
stem(t,toneramp_filter);
xlabel('Seconds')
ylabel('Amplitude')
title('Toneramp (Problem 1b)')

figure();
stem(t,toneramp_filter);
xlim([0 0.0005]);
ylim([0 0.0005]);
xlabel('Seconds')
ylabel('Amplitude')
title('Toneramp (Problem 1b ~ Zoomed In)')


%sound(toneramp_filter,fs);
%sound(equinox_filter,fs);

% Problem 1c
% Downsampling
toneramp_decimate = decimate(toneramp_filter,6);
equinox_decimate = decimate(equinox_filter, 6);

% Amplitude Response
dt = 1/fs2;
t = 0:dt:(length(toneramp_decimate)*dt)-dt;
figure();
stem(t,toneramp_decimate);
xlabel('Seconds')
ylabel('Amplitude')
title('Decimated Toneramp (Problem 1c)')

figure();
stem(t,toneramp_decimate);
xlim([0 0.0005]);
ylim([0 0.0005]);
xlabel('Seconds')
ylabel('Amplitude')
title('Decimated Toneramp (Problem 1c ~ Zoomed In)')

%sound(toneramp_decimate,fs2);
%sound(equinox_rdecimate,fs2);

audiowrite('toneramp_p1.wav',toneramp_decimate,fs2);
audiowrite('equinox_p1.wav',equinox_decimate,fs2);




