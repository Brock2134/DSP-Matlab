% Macky McWhirter
% Homework 5



% CIC Cascade coefficients
b = [ -1, -1, -1, -1, -1, -1, -1, -1, -1, -1];
a = 1;

b2 = [ -1, -1, -1, -1, -1, -1, -1, -1, -1, -1];
a2 = 1;

% CIC before cascade
% Pole-Zero
figure()
zplane(b,a);

% Freq Response
figure()
title('Freq Response')
freqz(b,a)

% Coefficients
figure()
impz(b,a);

%return;

% Cascade the two filters
filter1 = dfilt.df2t(b,a);
filter2 = dfilt.df2t(b2,a2);
cascade = dfilt.cascade(filter1,filter2); 

% Freq response of cascaded filter
freqz(cascade);
 
% Impulse response of cascaded filter
impz(cascade);