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