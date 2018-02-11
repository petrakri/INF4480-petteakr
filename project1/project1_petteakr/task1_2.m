% 1.2 gauss distribution
close all; clear; clc;

N = 1000000;
bins = 125;

[data, fx, x, fx_norm, x_norm, mu, sig] = distribution(N, bins, 'norm', 1);

var = sig.^2;

% Gauss function ( Theoretical PDF )
fx_gauss = (1./sqrt(2*pi*var)) * exp(-((x - mu).^2/(2*var)));

% Verification that the integral of the gauss is equal to 1
f = @(x) (1./sqrt(2*pi*var)) * exp(-((x - mu).^2/(2*var)));
Q = integral(f,-Inf,Inf);

% Comment: The values of after normalization doesn't compare the original
% PDF. Since we are considering the area and width of the bars before plotting.
% Comparing the sum of the areas with histogram(data,'Normalization','pdf')
% with our sum of the normalized with area, we see that the results are
% identical. Meaning that our manual normalization method is correct. Why
% the sum isn't 1, can be explained with that we are using a quadratic
% integral approximation, which has errors in accuary of the area.
% PS: The bar placement is random and might appear on different locations
% for each run of new values N.

figure(1);clf;
q = histogram(data, bins, 'Normalization', 'pdf'); hold on;
q_vals = q.Values;
sum_norm_q = sum(q_vals);
sum_norm_fx = sum(fx_norm);
bar(x_norm, fx_norm, 'y');
plot(x, fx_gauss,'r', 'LineWidth',2); hold off;
title('Comparison of Gauss function, and normalized PDF')
ylabel('Density');
xlabel('Values x');
legend(strcat('Histogram default normalization, sum of area: ', num2str(sum_norm_q)), strcat('Histogram manual normalization, sum of area: ', num2str(sum_norm_fx)), 'Gauss function');
