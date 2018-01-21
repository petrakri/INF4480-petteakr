%% 1.2
% Estimate PDF, first order moment, second order central moment using
% histogram, mean and std.
clear; close all; clc;

% Increasing N, makes the distribution go towards the theoretical PDF
% a more accurate representation of a uniform distribution
N = 10000000;

% Number of bins in the bar plot
bins = 25;

% Creating the uniform values
x_uni = rand(1,N);

% Mean of x_uniform
mu = mean(x_uni);

% Standard deviation of x_uniform
sig = std(x_uni);

% Generate histogram
h = histogram(x_uni,bins);

% Obtain the y-values, representing the function f(x)
fx = h.Values;

% The binwidth of all the bins in histogram (binWidth = h.BinWidth)
binWidth = 1/bins;

% Create matching x-vector for bar-plotting f(x)
x = linspace(binWidth/2,1-binWidth/2,bins);

% Bar-plot (Normalized with the sum of binareas) A = grunnflate * høyde
bar(x,fx/sum(fx*binWidth));

% Theoretical PDF, straight green line at 1
hline = refline([0 1]);
hline.Color = 'g';

xlabel('Random variable X')
ylabel('Probability density function')

% Probability density function eq. 3.5

% First order moment
% Expected value (mean) Eq. 3.10/3.11
Emu = sum(x_uni(:))/N;


% We see that when N moves towards infinity, the expected
% values stables out at 0.5.

% Second order central moment
% Uses the expected value from first order moment. Eq. 3.15
% Expected value variance (x_uni - E).^2
% ??????
Evar = (sum(x_uni(:))-Emu).^2;


%% 1.3 gauss pdf

x1 = linspace(-5,5,N);

x2 = randn(1,N);
m = mean(x2);
var = (std(x2)).^2;
h = hist(x2,10);
h = h(1,:)./N;

fx = (1./sqrt(2*pi*var)) * exp(-((x1 - m).^2/(2*var)));
figure;clf
bar(h); hold on;
plot(x1,fx); hold off;
