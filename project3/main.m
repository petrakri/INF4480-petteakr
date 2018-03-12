%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%
%#%#    Petter André Kristiansen   #%#%
%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%
%#%#%#           SETUP           #%#%#%
%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%
close all; clear; clc;
load('data/sonardata4.mat');
N_h = size(data,2);
N_t = size(data,1);
M_A = 1200;
N_A = 1024;
C_A = 14;
chirprate = B/T_p; 
L = T_p*fs;
t_chirp = linspace(-T_p/2, T_p/2, L);
s_Tx = exp(1i*2*pi*(chirprate/2)*t_chirp.^2);
s_Tx = [s_Tx zeros(1, N_t-ceil(L)+1)];

%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%
%#%#%#     Received signal 1A    #%#%#%
%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%
s_Rx_A = data(M_A:M_A+N_A-1,C_A);

% Periodogram
Pxx_hat = per(s_Rx_A, fs, 1);
axis2 = linspace(0,fs/1000,N_A);
figure(1);
plot(axis2, 10*log10(Pxx_hat)-1);
grid on;
xlabel('Frequency [kHz]');
ylabel('Power/dB');
title('Periodogram of recieved signal');


% The modified periodogram with a window of choice
% 1 = hamming, 2 = hanning, 3 = bartlett, 4 = blackman
figure(2);
filters = ["Hamming", "Hanning", "Bartlett", "Blackman"];
for i = 1:4
    [modPxx_hat, axis] = modper(s_Rx_A, i, 1);
    subplot(4, 1, i);
    plot(axis, 10*log10(modPxx_hat)-1); hold on;
    plot(axis, 10*log10(Pxx_hat)-1, '-.r'); hold off;
    grid on; 
    xlabel('Frequency [kHz]');
    ylabel('Power/dB'),
    title(filters(:,i));
    legend('Modified periodogram', 'Periodogram');
end
figure(3);
[modPxx_hat_b, axis_b] = modper(s_Rx_A, 3, 1);
plot(axis_b, 10*log10(modPxx_hat_b), '-.'); hold on;
plot(axis_b, 10*log10(Pxx_hat), 'r');
grid on;
xlabel('Frequency [kHz]');
ylabel('Power/dB');
title('Bartlett modified compared to normal periodogram');
legend('Bartlett modified periodogram', 'Periodogram');
xlim([15, 20]);
%%
% The Welch method with segment size L = 256 and overlap D = L/2
L = 256;
D = L/2;
figure(4);
[axis_w, Pxxwelch_b] = pxxwelch(s_Rx_A, L, D, 3);
plot(axis_w, 10*log10(Pxxwelch_b)-1);
grid on;
xlabel('Frequency [kHz]');
ylabel('Power/dB');
title('Modified periodogram with Welch method');

% The multitaper spectral estimator using matlab's function pmtm. Choose
% the order of the method(shoud be larger than 3)
figure(5);
[Pxx_mt3, axis_mt3] = pmtm(s_Rx_A, 3, fs);
[Pxx_mt35, axis_mt35] = pmtm(s_Rx_A, 3.5, fs);
[Pxx_mt4, axis_mt4] = pmtm(s_Rx_A, 4, fs);
[Pxx_mt6, axis_mt6] = pmtm(s_Rx_A, 6, fs);
plot(40*axis_mt3/(2*pi), 10*log10(Pxx_mt3)); hold on;
plot(40*axis_mt35/(2*pi), 10*log10(Pxx_mt35)); hold on;
plot(40*axis_mt4/(2*pi), 10*log10(Pxx_mt4)); hold on;
plot(40*axis_mt6/(2*pi), 10*log10(Pxx_mt6)); hold on;
plot(axis2, 10*log10(Pxx_hat)-1, ':');
legend('Order 3', 'Order 3.5', 'Order 4', 'Order 6', 'Original periodogram');
grid on;
xlabel('Frequency [kHz]');
ylabel('Power/dB');
title('Modified periodogram with Multitaper "pmtm"');

% Remember the questions at the end of Exercise 1A
%%
%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%
%#%#%#        Exercise 1 B       #%#%#%
%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%

M_B = 7000;
N_B = 2048;
C_B = 9;
s_Rx_B = data(M_B:M_B+N_B-1,C_B);

% Periodogram
figure(6);
Pxx_hat_B = per(s_Rx_B, fs, 1);
axis2 = linspace(0,fs/1000,N_B);
figure(6);
plot(axis2, 10*log10(Pxx_hat_B)-1);
grid on;
xlabel('Frequency [kHz]');
ylabel('Power/dB');
title('Periodogram of recieved signal 1B');

% Modified periodogram
figure(7);
[modPxx_hat_B, axis_mp] = modper(s_Rx_B, 3, 1);
plot(axis_mp, 10*log10(Pxx_hat_B)-1, ':g'); hold on;
plot(axis_mp, 10*log10(modPxx_hat_B)-1); hold off;
grid on; 
xlabel('Frequency [kHz]');
ylabel('Power/dB'),
title(filters(:,3));
legend('Periodogram','Modified periodogram');


%% The Welch method with segment size L = 256 and overlap D = L/2
figure(8);
L = 256;
D = L/2;
[axis_B_w, Pxxwelch_B_b] = pxxwelch(s_Rx_B, L, D, 3);
plot(axis_B_w, 10*log10(Pxxwelch_B_b)-1);
grid on;
xlabel('Frequency [kHz]');
ylabel('Power/dB');
title('Modified periodogram with Welch method');

%% Multitaper pmtm
figure(9);
[Pxx_mt, axis_mt] = pmtm(s_Rx_B, 3, fs);
plot(40*axis_mt/(2*pi), 10*log10(Pxx_mt));
grid on;
xlabel('Frequency [kHz]');
ylabel('Power/dB');
title('Modified periodogram with Multitaper "pmtm"');

%%
%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%
%#%#%#        Exercise 2 A       #%#%#%
%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%
figure(10);
M_2A = 400;
N_2A = 8192;
C_2A = 14;
s_Rx_2A = data(M_2A:M_2A+N_2A-1,C_2A);
Ls = [64, 128, 256, 512];

[modPxx_2A, axis_2A] = modper(s_Rx_2A, 3, 1);
plot(axis_2A, 10*log10(modPxx_2A)-1);
grid on;
xlabel('Frequency [kHz]');
ylabel('Power/dB');
title('Modified periodogram with tapering of choice, Bartlett');


t_axis = linspace(M_2A/fs,(M_2A+N_2A)/fs)*1000;
f_axis = linspace(fc-fs/2,fc+fs/2)/1000;

figure(11);    
for i = 1:length(Ls)
    L = Ls(i);
    D = L/2;
    stfft = stft(s_Rx_2A, L, D, 3, 4);
    subplot(length(Ls),1,i);
    imagesc(t_axis,f_axis,10*log10(stfft));
    xlabel('ms')
    ylabel('Frequency [kHz]')
    title(['L = ', num2str(Ls(i)), ' Bartlett window']);
    caxis([-2 55])
    colorbar
end

