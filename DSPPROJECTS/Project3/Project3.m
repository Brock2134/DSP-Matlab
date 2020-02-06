% Project 3 Part 1
% This part of the project shows all the code involved in recording the
% audio needed for testing.
% Cole Lewis, Macky McWhirter, Breydon Westmoreland
close all;
clear all;

% Test Signal
if (0)
    
    fs = 44100;
    len = 60*fs;
    % White Noise input vector
    x = rand(len, 1)-0.5;
    
    audiowrite('TestSignal.wav',x,fs); 
    sound(x,fs);

    nBits = 16 ; 
    nChannels = 1 ; 
    ID = -1; % default audio input device 
    recObj = audiorecorder(fs,nBits,nChannels,ID);

    recordblocking(recObj,60);

    y = getaudiodata(recObj);
    
    audiowrite('TestSignalTest.wav',y,fs);
end
% Music
if (0)
    [x, fs] = audioread('Songbird.mp3');

    sound(x,fs);

    nBits = 16 ; 
    nChannels = 1 ; 
    ID = -1; % default audio input device 
    recObj = audiorecorder(fs,nBits,nChannels,ID);

    recordblocking(recObj,60);

    y = getaudiodata(recObj);
    
    audiowrite('SongBirdTest.wav',y,fs); 
end

% Background Noise
if (0)
    [x, fs] = audioread('Coffee Shop.mp3');

    sound(x,fs);

    nBits = 16 ; 
    nChannels = 1 ; 
    ID = -1; % default audio input device 
    recObj = audiorecorder(fs,nBits,nChannels,ID);

    recordblocking(recObj,60);

    y = getaudiodata(recObj);
    
    audiowrite('CoffeeShopTest.wav',y,fs); 
end

% Human Speech
if (0)
    [x, fs] = audioread('officeimprov.mp3');

    sound(x,fs);

    nBits = 16 ; 
    nChannels = 1 ; 
    ID = -1; % default audio input device 
    recObj = audiorecorder(fs,nBits,nChannels,ID);

    recordblocking(recObj,60);

    y = getaudiodata(recObj);
    
    audiowrite('OfficeImprovTest.wav',y,fs); 
end


