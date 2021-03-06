% Task 3
clear; close all; clc;
load('sonardata2.mat');
% Samples
N = 1600;
N_h = size(data,2);
N_t = size(data,1);
s_Rx = @(N, C) (data(1:N,C).');
% CRLB function
CRLB = @(SNR, f_0) (1/(SNR*(2*pi)^2 * f_0^2));
% Pulse length M
M = T_p*fs;
% Pulse time vector
t_chirp = linspace(-T_p/2, T_p/2, M);
% Chirprate
chirprate = B/T_p;
% Transmitted signal (chirp):
s_Tx = exp(1i*2*pi*(chirprate/2)*t_chirp.^2);
s_Tx = [s_Tx zeros(1, N-M)];
%% Exercise 3A
% CRLB
C = 6;
f_0 = 100000;
s_Rx_c6 = s_Rx(N,C);
% Cross-correlation ( From Maximum Likelihood Estimator )
[Cn6,lag6] = xcorr(s_Rx_c6, s_Tx);
Cn6 = Cn6(N:end);
lag6 = lag6(N:end)/fs + t_0;
% Max value and index, peak detection
[max_val6, ind6] = max(Cn6);
avg_val6 = mean(Cn6);
SNR6 = max_val6/avg_val6;
CRLB_c6 = CRLB(SNR6, f_0);
% The limit of variance from the true value
limit_c6 = sqrt(abs(CRLB_c6));

C = 32;
f_0 = 100000;
s_Rx_c32 = s_Rx(N,C);
% Cross-correlation ( From Maximum Likelihood Estimator )
[Cn32,lag32] = xcorr(s_Rx_c32, s_Tx);
Cn32 = Cn32(N:end);
lag32 = lag32(N:end)/fs + t_0;
% Max value and index, peak detection
[max_val32, ind32] = max(Cn32);
avg_val32 = mean(Cn32);
SNR32 = max_val32/avg_val32;

CRLB_c32 = CRLB(SNR32, f_0);
% The limit of variance from the true value
limit_c32 = sqrt(abs(CRLB_c32));

%% Exercise 3B
clc;
td_c32 = ind32/fs + t_0;
s_Tx = [exp(1i*2*pi*(chirprate/2)*t_chirp.^2) zeros(1,N_t-M)];
compr = pc(s_Tx);

[peaks, channels] = max(abs(compr(1:N,:)));
[~, channel] = max(peaks);
max_index = channels(1,channel);
td_max = (max_index/fs + t_0)*1e3;

td_all = (channels./fs + t_0)*1e3;
plot(1:N_h, td_all);
xlabel('Channels');
ylabel('ms');
title('Time delay estimation on all channels');