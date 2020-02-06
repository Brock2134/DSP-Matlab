% HWK 8 Part 3
% Macky Brock McWhirter
% Hidden System
% These methods are modifications of the system_identification.m file
% by Juan Carlos Rojas


close all;
clc;
clear all;


%% Frequency Sweep Method
% Method 3: frequency sweep
if (1)
    num_frequencies = 250;

    % Create the vector of normalized frequencies to sweep
    % Between 0 and Nyquist
    fstep = 0.5/num_frequencies;
    fvec = fstep:fstep:(0.5-fstep);
    
    % Assume a sampling frequency (arbitrary) and time sequence duration
    fs = 1;
    tstop = 2*num_frequencies;    % So we can complete one cycle of the lowest frequency
    ts = 1/fs;
    tvec = 0:ts:(tstop-ts);
    
    count = 1;
    for f = fvec
        % Remember f is normalized.  Convert to radians
        frad = f * fs * 2 * pi;
        
        % Create a sinusoid stimulus at this frequency
        x = sin(frad*tvec)';
        
        % Feed through hidden system
        y = hidden_system(x);

        
        
        % Compute the amplitude and phase observed in y at the frequency of
        % interest, using the Goertzel algorithm
        fidx = f/fstep;
        H(count) = goertzel(y, [fidx+1]);
        count = count+1;
    end
    
    % Plot the collection of frequency responses
    fvec_step = pi/num_frequencies;
    fvec = fvec_step:fvec_step:(pi-fvec_step);
    figure(); 
    subplot(2,1,1); plot(fvec, abs(H)); title("Frequency Sweep: H(jw)");
    subplot(2,1,2); plot(fvec, angle(H));
end

