% DSP Project 2
% Part 1: The Encoder
% Cole Lewis, Macky McWhirter, Braydon Westmoreland
% 11/15/19
clear all;
close all;
clc;

% Fahrenheit 451 
[y,fs] = audioread("SpeechFile.wav");



%% Original Signal Analysis

% Original Amplitude Response
N = length(y);
xlimit = N/fs;
dt = 1/fs;
t = 0:dt:(N*dt)-dt;
%figure();
plot(t,y);
xlim([0 xlimit]);
xlabel('Seconds');
ylabel('Amplitude');
title('Amplitude Response of Speech File');

% Original Frequency Spectrum 16000 DFT Size
fft_size = 16000;
fd_signal = fft(y, fft_size);
f_step = fs/fft_size; 
fvec = 0:f_step:(fs-f_step);
%figure();
stem(fvec, abs(fd_signal));
%xlim([3000 4000])
title("Spectrum of Speech File");
xlabel('Hz');
ylabel('Amplitude');



%% Sub-Band Resampling

% Band 1
%figure()
lpf = fir1(120,0.26);
freqz(lpf,1);
title('Band 1 Filter Frequency Response')

speech_lpf = filter(lpf,1,y);
%speech_lpdecimate = decimate(speech_lpf,4);

j=1;
for (i=1:4:length(speech_lpf))
  speech_lpdecimate(j) = speech_lpf(i);
  j = j+1;
end

% Frequency vector
fsds = fs/4; 
fft_size = fsds*2;
fd_signal = fft(speech_lpdecimate(31:length(speech_lpdecimate)), fft_size);
f_step = fsds/fft_size; 
fvec = 0:f_step:(fsds-f_step);
%figure();
stem(fvec, 4*abs(fd_signal));
title("Band 1 Spectrum");



% Band 2
%figure()
bpf1 = fir1(120,[0.24 .51]);
freqz(bpf1,1);
title('Band 2 Filter Frequency Response')

speech_bpf1 = filter(bpf1,1,y);
%speech_bpdecimate = decimate(speech_bpf1,4);

j=1;
    for (i=1:4:length(speech_bpf1))
      speech_bpdecimate(j) = speech_bpf1(i);
      j = j+1;
    end
    
% Apply reflection: (-1)^n
    for (i = 1:length(speech_bpdecimate))
      if (mod(i,2) == 0)
        band2_reflected_signal(i) = speech_bpdecimate(i);
      else 
        band2_reflected_signal(i) = -speech_bpdecimate(i);
      end
    end
    
% Frequency vector
fsds = fs/4; 
fft_size = fsds*2;
fd_signal = fft(band2_reflected_signal(31:length(band2_reflected_signal)), fft_size);
f_step = fsds/fft_size; 
fvec = 0:f_step:(fsds-f_step);
%figure();
stem(fvec, 4*abs(fd_signal));
%xlim([0 1000])
title("Band 2 Spectrum");



% Band 3
%figure()
bpf2 = fir1(120,[0.49 .76]);
freqz(bpf2,1);
title('Band 3 Filter Frequency Response')

speech_bpf2 = filter(bpf2,1,y);
%speech_bpdecimate2 = decimate(speech_bpf2,4);

j=1;
for (i=1:4:length(speech_bpf2))
    speech_bpdecimate2(j) = speech_bpf2(i);
    j = j+1;
end
    
 
% Frequency vector
fsds = fs/4; 
fft_size = fsds*2;
fd_signal = fft(speech_bpdecimate2(31:length(speech_bpdecimate2)), fft_size);
f_step = fsds/fft_size; 
fvec = 0:f_step:(fsds-f_step);
%figure();
stem(fvec, 4*abs(fd_signal));
title("Band 3 (after Downsampling, BPF Filter, and mirror) Spectrum");


% Band 4
%figure()
b = fir1(120,0.74,'high');
freqz(b,1)
title('Band 4 Filter Frequency Response')

% Decimate
%speech_decimate = decimate(y,4);


% Apply image-rejection filter
speech_hpf = filter(b,1,y);

j=1;
for (i=1:4:length(speech_hpf))
      speech_hpdecimate(j) = speech_hpf(i);
      j = j+1;
end
    
% Apply reflection: (-1)^n
    for (i = 1:length(speech_hpdecimate))
      if (mod(i,2) == 0)
        band4_reflected_signal(i) = speech_hpdecimate(i);
      else 
        band4_reflected_signal(i) = -speech_hpdecimate(i);
      end
    end
    

fft_size = fsds*2;
fd_signal = fft(band4_reflected_signal(31:length(band4_reflected_signal)), fft_size);
f_step = fsds/fft_size; 
fvec = 0:f_step:(fsds-f_step);
%figure();
stem(fvec, 4*abs(fd_signal));
title("Band 4 (after Downsampling, Mirror, HPF filter) Spectrum");



%final = speech_hpfilter + speech_bpf1 + speech_bpf2 + speech_lpf;

%{
fft_size = 16000;
fd_signal = fft(final, fft_size);
f_step = fs/fft_size; 
fvec = 0:f_step:(fs-f_step);
%figure();
stem(fvec, abs(fd_signal));
%xlim([3000 4000])
title("Spectrum Check");
xlabel('Hz');
ylabel('Amplitude');

return
%}

%% Band Encoding
signal1 = speech_lpdecimate;
signal2 = speech_bpdecimate;
signal3 = speech_bpdecimate2;
signal4 = speech_hpdecimate;


%encoder
maxAmplitude1 = max(abs(signal1));
maxAmplitude2 = max(abs(signal2));
maxAmplitude3 = max(abs(signal3));
maxAmplitude4 = max(abs(signal4));
sizeOfEach = size(signal1);

signal1Norm = signal1 * (1/maxAmplitude1);
signal2Norm = signal2 * (1/maxAmplitude2);
signal3Norm = signal3 * (1/maxAmplitude3);
signal4Norm = signal4 * (1/maxAmplitude4);

sizeOfDataType = [16 16 16 16];

dataType1 =  ['ubit' num2str(sizeOfDataType(1),'%d')];
dataType2 =  ['ubit' num2str(sizeOfDataType(2),'%d')];
dataType3 =  ['ubit' num2str(sizeOfDataType(3),'%d')];
dataType4 =  ['ubit' num2str(sizeOfDataType(4),'%d')];

signal1int = signal1Norm*(2^(sizeOfDataType(1)-1)) + 2^(sizeOfDataType(1)-1); %convert to positive fixed point for unsigned
signal2int = signal2Norm*(2^(sizeOfDataType(2)-1)) + 2^(sizeOfDataType(2)-1); %convert to positive fixed point for unsigned
signal3int = signal3Norm*(2^(sizeOfDataType(3)-1)) + 2^(sizeOfDataType(3)-1); %convert to positive fixed point for unsigned
signal4int = signal4Norm*(2^(sizeOfDataType(4)-1)) + 2^(sizeOfDataType(4)-1); %convert to positive fixed point for unsigned

fileID = fopen('Speech.bin','w');
fwrite(fileID, sizeOfEach(2), 'int32', 0, 'n');
fwrite(fileID, sizeOfDataType, 'double', 0, 'n');
fwrite(fileID, maxAmplitude1, 'double', 0, 'n');
fwrite(fileID, maxAmplitude2, 'double', 0, 'n');
fwrite(fileID, maxAmplitude3, 'double', 0, 'n');
fwrite(fileID, maxAmplitude4, 'double', 0, 'n');
fwrite(fileID, signal1int, dataType1, 0, 'n');
fwrite(fileID, signal2int, dataType2, 0, 'n');
fwrite(fileID, signal3int, dataType3, 0, 'n');
fwrite(fileID, signal4int, dataType4, 0, 'n');
fclose(fileID);


