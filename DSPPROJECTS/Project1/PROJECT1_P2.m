% DSP Project 1
% Part 2: Message Encoder
% Cole Lewis, Macky McWhirter, Braydon Westmoreland
% 10/23/19

% Message decoded from Part 1
str = 'So long, and thanks for all the fish';

% Fun Message
%str = 'DSP is so much fun.';
%% Message Encoder Block

% Number Array Conversion
numarr = double(str);

% Time Vector creation
ts=1/8000;
T=1;
t=0:ts:(T -  1/8000 - 800/8000);
zArr = zeros(1,800);

% Run once to get the first second of data for cat()
bit = dec2bin(numarr(1), 8);

% First Concatenated array 
x = ((str2num(bit(1))*sin(2*pi* 200*t)) + ...
     (str2num(bit(2))*sin(2*pi* 400*t)) + ...
     (str2num(bit(3))*sin(2*pi* 600*t)) + ...
     (str2num(bit(4))*sin(2*pi* 800*t)) + ...
     (str2num(bit(5))*sin(2*pi*1000*t)) + ...
     (str2num(bit(6))*sin(2*pi*1200*t)) + ...
     (str2num(bit(7))*sin(2*pi*1400*t)) + ...
     (str2num(bit(8))*sin(2*pi*1600*t)));
 
% Normalization of original concatenated array
normalize = .5 / max(abs(x));
x = cat(2,x,zArr);
y = x * normalize;

% Array to iterate through the rest of the sequence
for i = 2:length(numarr)
    % Conversion to binary
    bit = dec2bin(numarr(i), 8);
    
    % Same process as earlier, Arrays are concatenated
    x = ((str2num(bit(1))*sin(2*pi* 200*t)) + ...
         (str2num(bit(2))*sin(2*pi* 400*t)) + ...
         (str2num(bit(3))*sin(2*pi* 600*t)) + ...
         (str2num(bit(4))*sin(2*pi* 800*t)) + ...
         (str2num(bit(5))*sin(2*pi*1000*t)) + ...
         (str2num(bit(6))*sin(2*pi*1200*t)) + ...
         (str2num(bit(7))*sin(2*pi*1400*t)) + ...
         (str2num(bit(8))*sin(2*pi*1600*t)));
    
    normalize = .5 / max(abs(x));
    x = x * normalize;
    x = cat(2,x,zArr);

    y = cat(2,y,x);
end

%% Spectrograph of the WAV file
% Code referenced from MathWorks website

% 512 point hamming window
window = hamming(512); 
noverlap = 256; 
nfft = 1024; 
[S,F,T,P] = spectrogram(y,window,noverlap,nfft,fs,'yaxis');
surf(T,F,10*log10(P),'edgecolor','none'); axis tight;view(0,90);
colormap(parula); 
set(gca,'clim',[-80 -30]);
xlabel('Time (sec)');
ylabel('Freq (kHz)')
%% Final WAV

% Final output is sent to WAV
audiowrite('P2Output.wav',y,8000)
