% 1.3
clear; close all; clc;
N = 100000;
bins = 77;

v = 12;
[data, fx, x, fx_norm, x_norm, mu, sig] = distribution(N, bins, 'uni', v);
var = sig.^2;



% Gauss function ( Theoretical PDF )
% This is the random variable X superimposed as gauss
fx_gauss = (1./sqrt(2*pi*var)) * exp(-((x - mu).^2/(2*var)));



% Verification that the integral of the gauss is equal to 1
f = @(x) (1./sqrt(2*pi*var)) * exp(-((x - mu).^2/(2*var)));
Q = integral(f,-Inf,Inf);


figure(1);clf;
bar(x_norm, fx_norm); hold on;
plot(x, fx_gauss, 'r');
title(['Task 1.3, rand(', num2str(v), ',', num2str(N), ')']);
ylabel('Density');
xlabel('Values x');
legend('Normalized PDF', 'Gauss function'); hold off;

% Comment:
% We can see that the ensemble average of the 'v' variables, is the same
% as the convolution of them. Looking at v = 2, it compares to a
% convolution of two rectangulare pulses, where as around 7-12 variables
% the total sum is a complete normal distribution.


