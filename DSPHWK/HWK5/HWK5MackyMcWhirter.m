% Homework 5 Pt. 1
% Macky Brock McWhirter
close all;

%% Problem 1
% 5 Unique non-zero, 0.4*pi radians cutoff
% ((taps + 1)/2) + 1 = 5, taps = 7
% N = taps + 1 = 8, 8 is a multiple of 4, no coefficients lost

Fs = 48000;
Fp = 9600; % 0.4pi normalized Frequency
N = 8;
% Transition Width = 5,640 
Ast = 18;



halfbandDecimator = dsp.FIRHalfbandDecimator('SampleRate',Fs, ...
    'Specification','Filter order and stopband attenuation', ...
    'StopbandAttenuation',Ast,'FilterOrder',N);
%fvtool(halfbandDecimator,'Fs',Fs,'Color','white');

% Filter Coefficients
num = tf(halfbandDecimator);
impz(num);

% Frequency Response
freqz(halfbandDecimator);

%return;

% 7 Unique non-zero
% ((taps + 1)/2) + 1 = 7, taps = 11
% N = taps + 1 = 12, 12 is a multiple of 4, no coefficients lost
Fs = 48000;
Fp = 9600;
N = 12;
% Transition Width = 5760
Ast = 30;

halfbandDecimator = dsp.FIRHalfbandDecimator('SampleRate',Fs, ...
    'Specification','Filter order and stopband attenuation', ...
    'StopbandAttenuation',Ast,'FilterOrder',N);
%fvtool(halfbandDecimator,'Fs',Fs,'Color','white');

% Filter Coefficients
num = tf(halfbandDecimator);
impz(num);

% Frequency Response
freqz(halfbandDecimator);
