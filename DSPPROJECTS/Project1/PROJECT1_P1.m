% DSP Project 1
% Part 1: Message Decoder
% Cole Lewis, Macky McWhirter, Braydon Westmoreland
% 10/23/19
clear 
close all

% Read in audio
[x,fs] = audioread("secret_message_4364.wav");

% Part 2 WAV file Test
%[x,fs] = audioread("P2Output.wav");

%% Spectrograph of the WAV file
% Code referenced from MathWorks website

% 512 point hamming window
window = hamming(512); 
noverlap = 256; 
nfft = 1024; 
[S,F,T,P] = spectrogram(x,window,noverlap,nfft,fs,'yaxis');
surf(T,F,10*log10(P),'edgecolor','none'); axis tight;view(0,90);
colormap(parula); 
set(gca,'clim',[-80 -30]);
xlabel('Time (sec)');
ylabel('Freq (kHz)')

%% Secret Message Decoder Block

% Range and integer array of zeros set
range = 5;
sum = zeros(1,length(x)/fs);

for i = 1:length(x)/fs
    % Integer array set to 0
    sum(i) = 0;
    
    % Low and high sampling values are set
    % Sampling frequency is 8 kHz
    low = (8000*(i-1)) + 1;
    high = (8000*(i));
    
    % fft function applied to convert to frequency domain
    y = abs(fft(x(low:high))); 
    
    % Finds peak frequencies above a threshhold 
    [pks,loc] = findpeaks(y,'MinPeakHeight',100); 
    
   
    
    % Logical array of values calculated using the peak location value
    bit7 = (200 - range) < loc & loc < (200 + range); 
    bit6 = (400 - range) < loc & loc < (400 + range);
    bit5 = (600 - range) < loc & loc < (600 + range);
    bit4 = (800 - range) < loc & loc < (800 + range);
    bit3 = (1000 - range) < loc & loc < (1000 + range);
    bit2 = (1200 - range) < loc & loc < (1200 + range);
    bit1 = (1400 - range) < loc & loc < (1400 + range);
    bit0 = (1600 - range) < loc & loc < (1600 + range);

    % If bit value is present, number is added to an integer array
    if(ismember(1, bit7)) 
        sum(i) = sum(i) + 2^7;
    end
    if(ismember(1, bit6))
        sum(i) = sum(i) + 2^6;
    end
    if(ismember(1, bit5))
        sum(i) = sum(i) + 2^5;
    end
    if(ismember(1, bit4))
        sum(i) = sum(i) + 2^4;
    end
    if(ismember(1, bit3))
        sum(i) = sum(i) + 2^3;
    end
    if(ismember(1, bit2))
        sum(i) = sum(i) + 2^2;
    end
    if(ismember(1, bit1))
        sum(i) = sum(i) + 2^1;
    end
    if(ismember(1, bit0))
        sum(i) = sum(i) + 2^0;
    end

end
 
% Graph of peaks
figure();
findpeaks(y,'MinPeakHeight',100); 
title('FFT Peaks')
xlabel('Frequency (Hz)')
ylabel('Amplitude')
    
    
    
% Converts from int array to char array
% Decoded Message displayed
char(sum) 

