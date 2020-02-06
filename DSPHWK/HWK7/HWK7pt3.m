% Homework 7 Part 3
% Polyphase Filter
% Macky McWhirter

clear all;
close all;

% Toneramp
toneramp = audioread('toneramp.wav');

% Sampling Frequency
fs = 48000;
fs2 = 8000;

% FIR filter
b = fir1(119,0.16);
toneramp_filter = filter(b,1,toneramp);

% Frequency Response of Anti-aliasing Filter
figure();
freqz(b,1);
title('Frequency Response of Prototype Anti-Aliasing Filter')



% Amplitude Response
dt = 1/fs2;
t = 0:dt:(length(toneramp_filter)*dt)-dt;
figure();
stem(t,toneramp_filter);
xlabel('Seconds')
ylabel('Amplitude')
title('Toneramp Original filter')



% Decimation and Polyphase 
firdecim = dsp.FIRDecimator(6,b);
p = polyphase(firdecim);

% Vector allocation
f0 = p(1,:);
f1 = p(2,:);
f2 = p(3,:);
f3 = p(4,:);
f4 = p(5,:);
f5 = p(6,:);

% Sub Filters
figure();
freqz(f0,1);
title('Frequency Response f0')

figure();
freqz(f1,1);
title('Frequency Response f1')

figure();
freqz(f2,1);
title('Frequency Response f2')

figure();
freqz(f3,1);
title('Frequency Response f3')

figure();
freqz(f4,1);
title('Frequency Response f4')

figure();
freqz(f5,1);
title('Frequency Response f5')


% Tone Ramp sub sequencing
n = length(toneramp);
j = 1;
for i=1:6:n
    x0(j) = toneramp(i);
    x1(j) = toneramp(i + 1);
    x2(j) = toneramp(i + 2);
    x3(j) = toneramp(i + 3);
    x4(j) = toneramp(i + 4);
    x5(j) = toneramp(i + 5);
    j = j + 1;
end

% Frequency Spectrum for each sequence
fft_size = fs2;
fd_signal = fft(x0, fft_size);
f_step = fs2/fft_size; 
fvec = 0:f_step:(fs2-f_step);
figure();
stem(fvec, abs(fd_signal));
title("x0 Freq Spectrum");

fft_size = fs2;
fd_signal = fft(x1, fft_size);
f_step = fs2/fft_size; 
fvec = 0:f_step:(fs2-f_step);
figure();
stem(fvec, abs(fd_signal));
title("x1 Freq Spectrum");

fft_size = fs2;
fd_signal = fft(x2, fft_size);
f_step = fs2/fft_size; 
fvec = 0:f_step:(fs2-f_step);
figure();
stem(fvec, abs(fd_signal));
title("x2 Freq Spectrum");

fft_size = fs2;
fd_signal = fft(x3, fft_size);
f_step = fs2/fft_size; 
fvec = 0:f_step:(fs2-f_step);
figure();
stem(fvec, abs(fd_signal));
title("x3 Freq Spectrum");

fft_size = fs2;
fd_signal = fft(x4, fft_size);
f_step = fs2/fft_size; 
fvec = 0:f_step:(fs2-f_step);
figure();
stem(fvec, abs(fd_signal));
title("x4 Freq Spectrum");

fft_size = fs2;
fd_signal = fft(x5, fft_size);
f_step = fs2/fft_size; 
fvec = 0:f_step:(fs2-f_step);
figure();
stem(fvec, abs(fd_signal));
title("x5 Freq Spectrum");



% Filters
filterone = filter(f0,1,x5);
filtertwo = filter(f1,1,x4);
filterthree = filter(f2,1,x3);
filterfour = filter(f3,1,x2);
filterfive = filter(f4,1,x1);
filtersix = filter(f5,1,x0);


% Filter Spectrum
fft_size = fs2;
fd_signal = fft(filterone, fft_size);
f_step = fs2/fft_size; 
fvec = 0:f_step:(fs2-f_step);
figure();
stem(fvec, abs(fd_signal));
title("x0 filtered Freq Spectrum");

fft_size = fs2;
fd_signal = fft(filtertwo, fft_size);
f_step = fs2/fft_size; 
fvec = 0:f_step:(fs2-f_step);
figure();
stem(fvec, abs(fd_signal));
title("x1 filtered Freq Spectrum");

fft_size = fs2;
fd_signal = fft(filterthree, fft_size);
f_step = fs2/fft_size; 
fvec = 0:f_step:(fs2-f_step);
figure();
stem(fvec, abs(fd_signal));
title("x2 filtered Freq Spectrum");

fft_size = fs2;
fd_signal = fft(filterfour, fft_size);
f_step = fs2/fft_size; 
fvec = 0:f_step:(fs2-f_step);
figure();
stem(fvec, abs(fd_signal));
title("x3 filtered Freq Spectrum");

fft_size = fs2;
fd_signal = fft(filterfive, fft_size);
f_step = fs2/fft_size; 
fvec = 0:f_step:(fs2-f_step);
figure();
stem(fvec, abs(fd_signal));
title("x4 filtered Freq Spectrum");

fft_size = fs2;
fd_signal = fft(filtersix, fft_size);
f_step = fs2/fft_size; 
fvec = 0:f_step:(fs2-f_step);
figure();
stem(fvec, abs(fd_signal));
title("x5 filtered Freq Spectrum");

% Sum of final filters
final = filterone + filtertwo + filterthree + filterfour + filterfive + filtersix;

% Final Filtered Amp Response
figure();
impz(final,1);
title('Final Filtered Amplitude Response')






