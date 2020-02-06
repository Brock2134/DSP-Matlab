% Macky McWhirter
% 9/20/19
% Homework 3

%% Problem 4
% H[z] = (z - 1/2)/(z - 1/3)
% Transfer Function coefficients
b = [1 -1/2];
a = [1 -1/3];

% Pole-zero diagram
figure();
zplane(b,a);

% Frequency Response
figure();
freqz(b,a);

%% Problem 5
% H[z] = (z - 4/5)/(z - 3/5)
% Pole and zero placement 
% Transfer Function coefficients
d = [1 -.8];
c = [1 -.6];

% Pole-zero diagram
figure();
zplane(d,c);

% Frequency Response
figure();
freqz(d,c);
