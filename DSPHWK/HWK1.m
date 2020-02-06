% HWK 1 Problem 5
% Macky Brock McWhirter
% This homework solution has been modeled from the sampling demo posted

% Continuous signal
ts_cont = 1e-4;
fs_cont = 1/ts_cont;

% Tim
t_start = 0;
t_end = 10;

% continuous time vector
tvec = t_start:ts_cont:t_end;

% 5/7 Hz
f = (5/7); 
test_signal = sin(2*pi*f*tvec);


figure();
plot(tvec, test_signal);
xlabel('time (secs)');
ylabel('continuous test signal');

hold on 


% sampled signal
% (2/7) Hz signal
fs = (2/7);
ts = 1/fs;
fs_ratio = fs_cont/fs;

% Subsampling technique
test_signal_sample = test_signal_cont(1:fs_ratio:end);


tvec_sample = t_start:ts:t_end;

% Final sampled graph
stem(tvec_sample, test_signal_sample)
xlabel('time (secs)');
ylabel('sampled test signal');

hold off