% Homework 7
% Multi-Stage Decimation
% Macky McWhirter

close all
clear all

% Read in audio
[x,fs] = audioread("toneramp.wav");

b = firhalfband(30,.005,'dev');

firststage = filter(b,1,x);

% Amplitude Response
dt = 1/24000;
t = 0:dt:(length(firststage)*dt)-dt;
figure();
stem(t,firststage);
xlabel('Seconds')
ylabel('Amplitude')
title('Original Amp')



j=1;
for i=1:2:length(firststage)
  dec1(j) = firststage(i);
  j = j+1;
end

rp = 1; rs = 70;
dev = [(10^(rp/20)-1)/(10^(rp/20)+1),  10^(-rs/20)];   
F = [3500 4000];                                           
A = [1 0];                                              
[No,Fo,Ao,W] = firpmord(F,A,dev,24000);   
c = firpm(No,Fo,Ao,W);                  


secondstage = filter(c,1,dec1);
j=1;
for (i=1:3:length(secondstage))
  dec2(j) = secondstage(i);
  j = j+1;
end

% Amplitude Response
dt = 1/8000;
t = 0:dt:(length(secondstage)*dt)-dt;
figure();
stem(t,secondstage);
xlabel('Seconds')
ylabel('Amplitude')
title('Second Amp')



% Second stage upsampled by 2
cu = zeros(2*length(c), 1);
for i=1:length(c)
    cu(i*2) = c(i);
end

figure(); 
freqz(cu,1,4096);
title('Upsampled Filter Freq Response')



% Combined solution

figure(); 
freqz(b,1,4096);
[b, w] = freqz(b,1,4096);
[c, w] = freqz(cu,1,4096);
d = b .* c;
figure(); 
plot(w/pi, db(d));
xlabel('Normalized Frequency (\times\pi rad/sample)')
ylabel('Magnitude (dB)')
title('Two-Stage Solution');