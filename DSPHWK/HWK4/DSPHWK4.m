clear all;
close all;
clc;

% Macky Brock McWhirter
% R11395102
% 10/4/2019
% DSP Homework 4

% Sampling Frequency
fs = 48000;

% Initial Tone Ramp file with original sound
x = audioread('toneramp.wav');
%sound(x,48000);
%figure();
%freqz(x);
%pause;
%% Problem 2 ~ Windowing method
clc;


% Define N as the number of unique coefficients.
% The spectrum will be of size 2*N+1
%Chebyshev
N = 160;
%Hamming
%N = 96;
fft_size = 2*N+1;


% Ideal frequency response
Hd = zeros(fft_size,1);

% Figure out how many ones we will need, depending on our desired cutoff
% Chebyshev
wc = 0.11;
% Hamming
% wc = 0.1;
m = floor(N*wc);

% Create a window of 2*m+1 ones centered
Hd(N-m+2:N+m+2) = ones(2*m+1,1);

% Plot Hd
% Frequency Response
figure();
stem(Hd);
title("Desired frequency response (Hd)");

%return;

% Now compute the impulse response hd(n) with the iDFT

Hd = fftshift(Hd);
hd = fftshift(ifft(Hd));

% It should be real-valued.  But sometimes there are small numerical errors
% that cause the imaginary part to be non-zero
hd = real(hd);

% Plot hd
figure();
stem(hd);
title("Desired impulse response h(d) before windowing");

%return;

% Chebyshev used
%window = chebwin(fft_size, 100); 
window = hamming(fft_size); %N = 96, wc = 0.1
figure(); 
stem(window);
title("Window");
hd = hd .* window;

%Impulse Response
figure(); stem(hd);
title("Desired impulse response h(d) after windowing)");

%return;

% Pole-zero graph
b = hd;
%zplane(b, 1);
plot_poles_zeros(b, 1);

% actual filter response 
figure();
freqz(b, 1);

window = conv(x,b);
audiowrite('Problem2WindowMethod.wav',window,48000);
sound(window,48000);

pause;
%return;
%% Problem 3~ Approximation method
clc;
close all;

[n,fo,ao,w] = firpmord([2000 2500],[1 0],[0.001 0.01],48000);
b = firpm(n,fo,ao,w);

% Freq
figure();
stem(abs(fftshift(ifft(b))));
title("Desired Frequency response");

% impulse
figure();
stem(b);
title("Desired Impulse response");


% Pole-Zero graph
plot_poles_zeros(b, 1);

figure();
freqz(b, 1);

approx = conv(x,b);
audiowrite('Problem3ApproxMethod.wav',approx,48000);
sound(approx,48000);
pause;
%return;
%% Problem 4 ~ Frequency Sampling Method
clc;
close all;
% Define N as the number of unique coefficients.
% The spectrum will be of size 2*N+1
N = 400;
fft_size = 2*N+1;

% Construct the desired frequency response 
% Start with all zeros
Hd = zeros(fft_size,1);

Hd(1) = 1;
for idx=1:N
    Hd(idx+1)=abs(sawtooth(4*pi*(idx-1)/N));
    Hd(fft_size-idx+1)=conj(Hd(idx+1));
end

%{
for idx=1:N
    Hd(idx+1)=abs(sawtooth(2*pi*(idx-1)/N));
    Hd(fft_size-idx+1)=conj(Hd(idx+1));
end
%}

% Plot Hd
figure();
stem(Hd);
title("Desired frequency response (Hd)");

%return;

% Now compute the impulse response hd(n) with the iDFT
hd = fftshift(ifft(Hd));
% It should be real-valued.  But sometimes there are small numerical errors
% that cause the imaginary part to be non-zero
hd = real(hd);

% Plot hd
figure();
stem(hd);
title("Desired impulse response h(d) before windowing");

%return;

% Apply Windowing
window = ones(fft_size, 1);
%window = hanning(fft_size);
%window = hamming(fft_size);
%window = kaiser(fft_size, 5);
%window = chebwin(fft_size, 100);
figure(); stem(window);
title("Window");
hd = hd .* window;

% Plot hd
figure(); stem(hd);
title("Desired impulse response h(d) after windowing)");

%return;

% Show location of zeros
b = hd;
%zplane(b, 1);
plot_poles_zeros(b, 1);

% Plot the actual filter response (in linear scale)
figure();
[h, w] = freqz(b, 1);

subplot(2,1,1);
plot(w, abs(h));
title('Magnitude (Linear)');
subplot(2,1,2);
plot(w, angle(h));
title('Phase');

figure();
freqz(b);

freq = conv(x,hd);
audiowrite('Problem4FreqSampMethod.wav',freq,48000);
sound(freq,48000);
  
pause;
%return;
%% Problem 5 ~ IIR design
close all;

[b, a] = cheby2(8, 40, 0.125);
zplane(b,a);

% Frequency Response
figure();
stem(-real(fftshift(ifft(b))));
title("Desired Frequency response (Hd)");

% Impulse Response
figure();
stem(b);
title("Desired Impulse response (Hd)");


% Poles-Zeros



% Amp/Phase
freqz(b,a);

IIR = filter(b,a,x);


audiowrite('Problem5IIRMethod.wav',IIR,48000);
sound(IIR,48000);

