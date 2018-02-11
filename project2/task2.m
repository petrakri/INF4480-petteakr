% Task 2A
close all; clear; clc;
load('sonardata2.mat');
%%
% Samples
N = 1600;
% Channel
C = 3;
N_h = size(data,2);
N_t = size(data,1);
s_Rx = data(1:N,C).';
% Pulse length M
M = T_p*fs;
% Pulse time vector
t_chirp = linspace(-T_p/2, T_p/2, M);
% Chirprate
chirprate = B/T_p;
% Transmitted signal (chirp):
s_Tx = exp(1i*2*pi*(chirprate/2)*t_chirp.^2);
s_Tx = [s_Tx zeros(1, N-M)];

% Cross-correlation ( From Maximum Likelihood Estimator )
[Cn,lag] = xcorr(s_Rx, s_Tx);
Cn = Cn(N:end);
lag = lag(N:end)/fs + t_0;

% Max value and index, peak detection
[val, ind] = max(abs(Cn));

% Fish located at milliseconds
fish = ind/fs + t_0;

% Plot of cross-correlation with chirp
figure;
subplot(121);
plot((1:1600)/fs*1e3,real(s_Tx));
title('Chirp s_{Tx} transmitted signal');
xlabel('ms');
ylabel('Amplitude');
xlim([0,10]);
subplot(122);
plot(lag*1e3,abs(Cn));
xlabel('ms');
ylabel('Magnitude');
title('Cross-correlation on Transmitted and Recieved signal');

%% Exercise 2C 
clc;
s_Tx = [exp(1i*2*pi*(chirprate/2)*t_chirp.^2) zeros(1,N_t-M)];
compr = zeros(N_t,N_h);
for i = 1:N_h
    s_Rx = data(:,i).';
    [corr, lag] = xcorr(s_Rx, s_Tx);
    step = corr(1,N_t:end);
    compr(:,i) = step.';
end

c3 = abs(compr(1:N,3));
c17 = abs(compr(1:N,17));
lag = lag(N_t:end).';

figure();
subplot(211);
plot(lag(1:N),c3./max(c3)); hold on;
plot(lag(1:N),abs(data(1:N,3).')/max(abs(data(:,3).'))); hold off;
ylim([-0.1,1.1]);
legend('Pulse compressed signal', 'Raw data');
title('Channel 3 comparison');

subplot(212);
plot(lag(1:N),c17./max(c17)); hold on;
plot(lag(1:N),abs(data(1:N,17).')/max(abs(data(:,17).'))); hold off;
ylim([-0.1,1.1]);
legend('Pulse compressed signal', 'Raw data');
title('Channel 17 comparison');
%% Exercise 2D
close all; clc;
C = 3;
bins = 301;
c3 = compr(1:N,C);

[npdf_i, pdf_i, nx_i, mu_i, sig_i] = normalise(real(c3), bins);
[npdf_r, pdf_r, nx_r, mu_r, sig_r] = normalise(imag(c3), bins);

varr = sig_r.^2;
vari = sig_i.^2;

gr = (1./sqrt(2*pi*varr)) * exp(-((nx_r - mu_r).^2/(2*varr)));
gi = (1./sqrt(2*pi*vari)) * exp(-((nx_i - mu_i).^2/(2*vari)));

time_interval = 1:1600;
time_series = data(time_interval,C);


[pdf_norm_real, pdf_real, x_norm_real, mu_real, sig_real] = normalise(real(data(1:N,3)), bins);
[pdf_norm_imag, pdf_imag, x_norm_imag, mu_imag, sig_imag] = normalise(imag(data(1:N,3)), bins);

var_real = sig_real.^2;
var_imag = sig_imag.^2;

fx_gauss_real = (1./sqrt(2*pi*var_real)) * exp(-((x_norm_real - mu_real).^2/(2*var_real)));
fx_gauss_imag = (1./sqrt(2*pi*var_imag)) * exp(-((x_norm_imag - mu_imag).^2/(2*var_imag)));

% Real plot
figure(1); clf;
subplot(221);
plot(nx_r, gr, 'r'); hold on;
plot(nx_r, npdf_r); hold off;
title('Real-part, after pulse compression');
ylabel('Density');
xlabel('Data');
legend('Gauss function', ['Data, channel = ', num2str(C)]);
xlim([-sig_r*4,sig_r*4]);

% Imag plot
subplot(222);
plot(nx_i, gi, 'r'); hold on;
plot(nx_i, npdf_i); hold off;
title('Imag-part, after pulse compression');
ylabel('Density');
xlabel('Data');
legend('Gauss function', ['Data, channel = ', num2str(C)]);
xlim([-sig_i*4,sig_i*4]);

% Real plot
subplot(223);
plot(x_norm_real, fx_gauss_real, 'r'); hold on;
plot(x_norm_real, pdf_norm_real); hold off;
title('Real-part, before pulse compression');
ylabel('Density');
xlabel('Data');
legend('Gauss function', ['Data, channel = ',num2str(C)]);
xlim([-sig_real*4,sig_real*4]);

% Imag plot
subplot(224);
plot(x_norm_imag, fx_gauss_imag, 'r'); hold on;
plot(x_norm_imag, pdf_norm_imag); hold off;
title('Imaginary-part, before pulse compression');
ylabel('Density');
xlabel('Data');
legend('Gauss function', ['Data, channel = ',num2str(C)]);
xlim([-sig_imag*4,sig_imag*4]);




