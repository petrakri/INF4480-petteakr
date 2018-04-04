% Exercise 2
close all; clear; clc;
sigma = 3/13;
theta = 1;
N = 10000;

fn = @(x) (1./sqrt(2*pi*sigma.^2)) * exp(-(x.^2/(2*sigma.^2)));
fs = @(x) (1./sqrt(2*pi*sigma.^2)) * exp(-((x - theta).^2/(2*sigma.^2)));

x = linspace(-8*sigma, 8*sigma, N);

Lambda = fs(x) / fn(x);

mid = (0 + theta)/2;
threshold = mid;

[PM, PD] = calc_pd(fs, threshold);

% Plotting
f1 = fs(x);
f0 = fn(x);
pks = max(f1);
figure(2);
plot(x, f0, 'm', 'LineWidth', 1.5); hold on;
plot(x, f1, 'b', 'LineWidth', 1.5);

if threshold > theta
    labels = {0, theta, threshold};
    set(gca,'xtick',[0,theta,threshold],'xticklabel',labels);
else
    labels = {0, threshold, theta};
    set(gca,'xtick',[0,threshold,theta],'xticklabel',labels);
end


% Color the areas
idxPFA = x >= threshold-0.001 & x < 10*sigma;
idxPM = x > -10*sigma & x <= threshold;
idxPD = idxPFA;
idxPR = idxPM;
HPD = area(x(idxPD), f1(idxPD));
HPFA = area(x(idxPFA), f0(idxPFA));
%HPR = area(x(idxPR), f0(idxPR));
HPM = area(x(idxPM), f1(idxPM));

% Lines for threshold and means

plot([threshold threshold], [0 pks], 'LineWidth', 1.5, 'Color', [0, 0.2, 0.2]);
line([0 0], [0 pks]);
line([theta theta], [0 pks]);
set(HPFA(1),'FaceColor',[0.7 1 0.5]);
set(HPD(1),'FaceColor',[0 1 0]);
%set(HPR(1),'FaceColor',[0.5 0.2 0.2]);
set(HPM(1),'FaceColor',[1 0 0]);
legend('PDF: noise', 'PDF: signal + noise', 'P_{D}', 'P_{FA}', 'P_{M}', 'Threshold x_c');
title('Representation of False Alarm and Decision');

%%

%noise
sigma = 3/13;
signal = signalfromname('petter', 500);
nn = sigma*randn(length(signal),1);
% ns = mean(signal) + sigma*randn(length(signal),1);
signal = signal+nn;

[~, ~, ~, fn, xn, fn_mu, fn_sig] = distribution(length(nn), length(nn)/60, nn, 1);
[~, ~, ~, fs, xs, fs_mu, fs_sig] = distribution(length(signal), length(signal)/60, signal, 1);
%[data, fx, x, fx_norm, x_norm, mu, sig] = distribution(N, bins, type, v)

figure();
plot(xn, fn); hold on;
plot(xs, fs);
mid = (0 + fs_mu)/2;
line([mid mid], [0, max(fn)]);
legend('f_n - noise','f_s - signal + noise');

