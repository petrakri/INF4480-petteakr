% Sample code slide 11. spectral 1, deterministic real signal

%% 1
figure(1);
dt = 0.001;
N = 1000;
f = 33;
t = [0:N-1] * dt;
s_t = cos(2*pi*f*t);
s_w = abs(fftshift(fft(s_t)));
faxe = [-N/2:N/2-1]/N /dt;
plot(faxe,s_w)
xlim([-50,50])
ylim([0,600])
grid on
xlabel('Frequency [Hz]');
ylabel('Amplitude');
title('Example 1, real signal');
print('example2_fourier', '-depsc');

%% 2
figure(2);
dt = 0.001;
N = 1000;
f = 33;
t = [0:N-1] * dt;
s_t = exp(j*2*pi*f*t);
s_w = abs(fftshift(fft(s_t)));
faxe = [-N/2:N/2-1]/N /dt;
plot(faxe,s_w)
xlim([-50,50])
ylim([0,1200])
grid on
xlabel('Frequency [Hz]');
ylabel('Amplitude');
title('Example 2, complex sequence');
print('example2_fourier', '-depsc');

%% 3
rng default
Fs = 1000;
t = 0:1/Fs:1-1/Fs;
x = cos(2*pi*100*t) + randn(size(t));
N = length(x);
xdft = fft(x);
%xdft = xdft(1:N/2+1);
psdx = (1/(Fs*N)) * abs(xdft).^2;
psdx(2:end-1) = 2*psdx(2:end-1);

[Rxx, lags] = xcorr(x, x, 'coeff');

x2dft = fft(Rxx);

x2dft = x2dft;

psdx2 = (1/(Fs*N)) * abs(x2dft).^2;

psdx2(2:end-1) = 2*psdx2(2:end-1);

freq = 0:Fs/length(x):Fs/2;

subplot(211);
plot(freq,10*log10(psdx));
grid on
title('Periodogram Using FFT')
xlabel('Frequency (Hz)')
ylabel('Power/Frequency (dB/Hz)')

subplot(212);
plot(freq, 10*log10(psdx2))