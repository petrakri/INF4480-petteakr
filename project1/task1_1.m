% 1.2 uniform distribution
% Estimate PDF, first order moment, second order central moment using
% histogram, mean and std.
clear; close all; clc;

% Increasing N, makes the distribution go towards the theoretical PDF
% a more accurate representation of a uniform distribution
N = 10000000;

% Number of bins in the bar plot
bins = 37;

% Generate functions
[data, fx, x, fx_norm, x_norm, mu, sig] = distribution(N, bins, 'uni', 1);

% Second order central moment ( Variance )
var = sig.^2;

% Theoretical PDF
x_vert=[0:0.1:10];
x1=0;
x2=1;
y1=0:1;

% Plot
figure(1);
% Bar-plot (Normalized with the sum of binareas) A = grunnflate * høyde
bar(x,fx_norm); hold on;
plot([x1 x1],y1,'r','LineWidth',1.5);
plot([x2 x2],y1,'r','LineWidth',1.5); hold off;
hline = refline([0,1]);
hline.Color = 'r';

title('Estimated and Theoretical PDF of Uniform Distribution');
xlabel('Values x')
ylabel('Density')
xlim([x(1,1)-0.2, x(1,end)+0.2]);
ylim([0.2 1.1]);
legend('Estimated PDF, manual normalization', 'Theoretical PDF');

% We see that when N moves towards infinity, the expected
% values stables out at 0.5.
