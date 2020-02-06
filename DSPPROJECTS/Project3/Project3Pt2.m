% Project 3 Part 2
% Transfer Function evaluation code
% Cole Lewis, Macky McWhirter, Breydon Westmoreland
close all;
clear all;
clc;

[y, fs] = audioread('TestSignalTest.wav');
x = audioread('TestSignal.wav');
corrlen = 10000;

%p=1000;
%coeff = aryule(y,p);

%figure
%freqz(1,coeff)



ac = xcorr(y, corrlen);

h = ac((corrlen+1):length(ac));


%figure(); stem(h);
%title("Method 2: h(n)");
    
% Plot the frequency response
%{
fvec_step = 2*pi/corrlen;
fvec = 0:fvec_step:(2*pi);
figure(); 
subplot(2,1,1); plot(fvec, abs(fft(h))); title("Method 2: H(jw)");
subplot(2,1,2); plot(fvec, angle(fft(h)));

hfilt = filter(h,1,y);

figure();
freqz(hfilt,1);
%}


SongBird = audioread('SongBird.mp3');

SongBirdTest = audioread('SongBirdTest.wav');
SongBird = transpose(SongBird(1:length(SongBirdTest)));

%SongBirdTwo = filter(1,coeff,SongBird);

SongBirdTwo = filter(h,80000,SongBird);
SongBirdTwo = SongBirdTwo(1:length(SongBirdTest));


SongBirdFinal = SongBirdTest - SongBirdTwo;

for i = 1:length(SongBirdFinal)
    
    if(abs(SongBirdTwo) > abs(SongBirdTest))
        SongBirdFinal(i) = 0;
    else
        SongBirdFinal(i) = SongBirdTest(i) - SongBirdTwo(i);
    end
    
end

