% DSP Project 2
% Part 2: The Decoder
% Cole Lewis, Macky McWhirter, Braydon Westmoreland
% 11/15/19

clc;
clear all;
close all;

%% Decoder
fileID = fopen('Speech.bin');
outSizeOfEach = fread(fileID, 1, 'int32');
outSizeOfDataType = fread(fileID, 4, 'double');
outMaxAmplitude1 = fread(fileID, 1, 'double');
outMaxAmplitude2 = fread(fileID, 1, 'double');
outMaxAmplitude3 = fread(fileID, 1, 'double');
outMaxAmplitude4 = fread(fileID, 1, 'double');
outSignal1int = fread(fileID,outSizeOfEach,['ubit' num2str(outSizeOfDataType(1),'%d')]);
outSignal2int = fread(fileID,outSizeOfEach,['ubit' num2str(outSizeOfDataType(2),'%d')]);
outSignal3int = fread(fileID,outSizeOfEach,['ubit' num2str(outSizeOfDataType(3),'%d')]);
outSignal4int = fread(fileID,outSizeOfEach,['ubit' num2str(outSizeOfDataType(4),'%d')]);


outSignal1 = (outSignal1int-2^(outSizeOfDataType(1)-1)) / (2^(outSizeOfDataType(1)-1)*(1/outMaxAmplitude1)); %convert back from poitive fixed point
outSignal2 = (outSignal2int-2^(outSizeOfDataType(2)-1)) / (2^(outSizeOfDataType(2)-1)*(1/outMaxAmplitude2));
outSignal3 = (outSignal3int-2^(outSizeOfDataType(3)-1)) / (2^(outSizeOfDataType(3)-1)*(1/outMaxAmplitude3));
outSignal4 = (outSignal4int-2^(outSizeOfDataType(4)-1)) / (2^(outSizeOfDataType(4)-1)*(1/outMaxAmplitude4));
fclose(fileID);



%% Upsampling
fs = 2000;
fsup = 8000;


% Band 1
Band1_upsample = upsample(outSignal1,4);

%figure()
lpf = fir1(120,0.23);
freqz(lpf,1);
title('Band 1 Filter Frequency Response')

Band1_lpf = filter(lpf,1,Band1_upsample);

% Frequency vector
fft_size = 16000;
fd_signal = fft(Band1_lpf, fft_size);
f_step = fsup/fft_size; 
fvec = 0:f_step:(fsup-f_step);
%figure();
stem(fvec, 4*abs(fd_signal));
title("Band 1 Frequency Spectrum (after Upsampling & filtering)")
xlabel('Hz');



% Band 2
%{
% Apply reflection: (-1)^n
    for (i = 1:length(outSignal2))
      if (mod(i,2) == 0)
        band2_reflected_signal(i) = outSignal2(i);
      else 
        band2_reflected_signal(i) = -outSignal2(i);
      end
    end
  %}  
Band2_upsample = upsample(outSignal2,4);


%figure()
bpf1 = fir1(120,[0.26 .49]);
freqz(bpf1,1);
title('Band 2 Filter Frequency Response')

band2_bpf = filter(bpf1,1,Band2_upsample);

%Band2_upsample = upsample(band2_bpf,4);
    
% Frequency vector
fft_size = 16000;
fd_signal = fft(band2_bpf, fft_size);
f_step = fsup/fft_size; 
fvec = 0:f_step:(fsup-f_step);
%figure();
stem(fvec, 4*abs(fd_signal));
title("Band 2 Frequency Spectrum (after Upsampling & filtering)")
xlabel('Hz');


% Band 3
Band3_upsample = upsample(outSignal3,4);


%figure()
bpf2 = fir1(120,[0.51 .76]);
freqz(bpf2,1);
title('Band 3 Filter Frequency Response')

band3_bpf = filter(bpf2,1,Band3_upsample);


    
% Frequency vector
fft_size = 16000;
fd_signal = fft(band3_bpf, fft_size);
f_step = fsup/fft_size; 
fvec = 0:f_step:(fsup-f_step);
%figure();
stem(fvec, 4*abs(fd_signal));
title("Band 3 Frequency Spectrum (after Upsampling & filtering)")
xlabel('Hz');


% Band 4

Band4_upsample = upsample(outSignal4,4);

%figure()
b = fir1(120,0.74,'high');
freqz(b,1)
title('Band 4 Filter Frequency Response')

Band4_hpf = filter(b,1,Band4_upsample);



% Frequency vector
fft_size = 16000;
fd_signal = fft(Band4_hpf, fft_size);
f_step = fsup/fft_size; 
fvec = 0:f_step:(fsup-f_step);
%figure();
stem(fvec, 4*abs(fd_signal));
title("Band 4 Frequency Spectrum (after Upsampling & filtering)")
xlabel('Hz');


% Final
final = Band1_lpf + band2_bpf + band3_bpf + Band4_hpf;



audiowrite('output.wav',final,8000);

