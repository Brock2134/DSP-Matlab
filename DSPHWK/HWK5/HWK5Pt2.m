% Homework 5 Pt. 2
% Macky Brock McWhirter
close all;


% Original Coefficients
b = [.0043, -.0106, .0142, -.0106, .0043];
a = [1, -3.6775, 5.1726, -3.293, .8001];

% Pole-Zero Graph
figure()
zplane(b,a);

% Frequency Response
figure()
freqz(b,a)

%return;

% 16 bits
[bsix, asix, s] = FixedFunct(b,a,16);

% Pole-Zero
figure()
zplane(bsix,asix);

% Frequency Response
figure()
freqz(bsix,asix)


% 8 Bits
[beight, aeight] = FixedFunct(b,a,8);

figure()
zplane(beight,aeight);
figure()
freqz(beight,aeight)

% 12 bits

[btwel, atwel] = FixedFunct(b,a,12);

figure()
zplane(btwel,atwel);
figure()
freqz(btwel,atwel)

