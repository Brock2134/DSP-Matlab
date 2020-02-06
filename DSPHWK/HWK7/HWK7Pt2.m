% Homework 7 Part 2
% CIC Decimation Staged Filter
% Macky McWhirter
clear all;
close all;

% Toneramp
[x,fs] = audioread("toneramp.wav");


% CIC Filter 8 coefficients
b = [ -1, -1, -1, -1, -1, -1, -1, -1];
a = 1;

% Cascade the two filters
H1 = dfilt.df2t(b,a);
H2 = dfilt.df2t(b,a);
h = dfilt.cascade(H1,H2); 

% Freq Resp
freqz(h);
title('CIC Freq Response')

firststage = filter(h,x);

% Amplitude Response
dt = 1/24000;
t = 0:dt:(length(firststage)*dt)-dt;
figure();
stem(t,firststage);
xlabel('Seconds')
ylabel('Amplitude')
title('Original Amp')


j = 1;
for (i=1:2:length(firststage))
  firststageDec(j) = firststage(i);
  j = j+1;
end

rp = 1; rs = 70;
dev = [(10^(rp/20)-1)/(10^(rp/20)+1),  10^(-rs/20)];   
F = [3500 4000];                                           
A = [1 0];                                              
[No,Fo,Ao,W] = firpmord(F,A,dev,24000);   
m = firpm(No,Fo,Ao,W);                  

secondstage = filter(m,1,firststageDec);
j=1;
for (i=1:3:length(secondstage))
  secondstageDec(j) = secondstage(i);
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
mu = zeros(2*length(m), 1);
for i=1:length(m)
    mu(i*2) = m(i);
end
figure(); 
freqz(m,1,4096);


% Combined solution
figure();
[h, w] = freqz(h,4096);
[m, w] = freqz(mu,1,4096);
final = h .* m;
figure(); 
plot(w/pi, db(final));
xlabel('Normalized Frequency (\times\pi rad/sample)')
ylabel('Magnitude (dB)')
title('Two-Stage Solution');