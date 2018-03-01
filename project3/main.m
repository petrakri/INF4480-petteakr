%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%
%#%#    Petter André Kristiansen   #%#%
%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%
%#%#%#           SETUP           #%#%#%
%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%
close all; clear; clc;
load('data/sonardata4.mat');
N_h = size(data,2);
N_t = size(data,1);
M = 1200;
N = 1024;
C = 14;
chirprate = B/T_p; 
L = T_p*fs;
t_chirp = linspace(-T_p/2, T_p/2, L);
s_Tx = exp(1i*2*pi*(chirprate/2)*t_chirp.^2);
s_Tx = [s_Tx zeros(1, N_t-ceil(L)+1)];

%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%
%#%#%#     Received signal 1A    #%#%#%
%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%
s_Rx = data(M:M+N-1,C);

% Periodogram
Pxx_hat = per(s_Rx, fs);
axis2 = linspace(0,fs/1000,N);
figure(1);
plot(axis2, 10*log10(Pxx_hat));
grid on;
xlabel('Frequency [kHz]');
ylabel('Power/dB');
title('Periodogram of recieved signal');


% The modified periodogram with a window of choice
% 1 = hamming, 2 = hanning, 3 = bartlett, 4 = blackman
figure(2);
filters = ["Hamming", "Hanning", "Bartlett", "Blackman"];
for i = 1:4
    [modPxx_hat, axis] = modper(s_Rx, i);
    subplot(4, 1, i);
    plot(axis, 10*log10(modPxx_hat)); hold on;
    plot(axis, 10*log10(Pxx_hat), '-.r'); hold off;
    grid on; 
    xlabel('Frequency [kHz]');
    ylabel('Power/dB'),
    title(filters(:,i));
    legend('Modified periodogram', 'Periodogram');
end
figure(3);
[modPxx_hat_b, axis_b] = modper(s_Rx, 3);
plot(axis_b, 10*log10(modPxx_hat_b), '-.'); hold on;
plot(axis_b, 10*log10(Pxx_hat), 'r');
grid on;
xlabel('Frequency [kHz]');
ylabel('Power/dB');
title('Bartlett modified compared to normal periodogram');
legend('Bartlett modified periodogram', 'Periodogram');

%%
% The Welch method with segment size L = 256 and overlap D = L/2
L = 256;
D = L/2;



% The multitaper spectral estimator using matlab's function pmtm. Choose
% the order of the method(shoud be larger than 3)

% Remember the questions at the end of Exercise 1A
%%
%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%
%#%#%#        Exercise 1 B       #%#%#%
%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%

