% Project 2
close all; clear; clc;
load('sonardata2.mat');
%% Task 1A
C = 3;
N = 1600;
time_series = data(1:N,C);
bins = 101;


[pdf_norm_real, pdf_real, x_norm_real, mu_real, sig_real] = normalise(real(time_series), bins);
[pdf_norm_imag, pdf_imag, x_norm_imag, mu_imag, sig_imag] = normalise(imag(time_series), bins);

var_real = sig_real.^2;
var_imag = sig_imag.^2;

fx_gauss_real = (1./sqrt(2*pi*var_real)) * exp(-((x_norm_real - mu_real).^2/(2*var_real)));
fx_gauss_imag = (1./sqrt(2*pi*var_imag)) * exp(-((x_norm_imag - mu_imag).^2/(2*var_imag)));

% Real plot
figure(1); clf;
subplot(121);
plot(x_norm_real, fx_gauss_real, 'r'); hold on;
plot(x_norm_real, pdf_norm_real); hold off;
title('Real-part');
ylabel('Density');
xlabel('Data X');
legend('Gauss function', ['Data, channel = ',num2str(C)]);

% Imag plot
subplot(122);
plot(x_norm_imag, fx_gauss_imag, 'r'); hold on;
plot(x_norm_imag, pdf_norm_imag); hold off;
title('Imaginary-part');
ylabel('Density');
xlabel('Data X');
legend('Gauss function', ['Data, channel = ',num2str(C)]);


%% 1B correlation
clc; close all;

corr = corrcoef(data(1:1600,:));
figure();
subplot(121);
imagesc(real(corr));
title('Real');

subplot(122);
imagesc(imag(corr));
title('Imag');

%Pxx Power Spectral Density
%plot(lag,fftshift(fft(abs(Cv))));

