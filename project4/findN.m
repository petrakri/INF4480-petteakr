% Calculate PD for for all N, until PD > 0.9

close all; clear; clc;
sigma = 5;
fs_mu = 5;
lower = -10*sigma;  % lower limit
upper = 10*sigma;   % upper limit

samples = 10000;
PD = 0; N = 0; PFA = 0.01;

while 0.9 > PD
    N = N + 1;
    fn = @(x) (1/sqrt(2*pi*N*sigma.^2))*exp(-x.^2/(2*N*sigma.^2));
    fs = @(x) (1/sqrt(2*pi*N*sigma.^2))*exp(-(x - N*fs_mu).^2/(2*N*sigma.^2)); 
    x = linspace(N*lower,N*upper,samples);
    xc = cfar(x, fn, PFA);
    [~,PD] = calc_pd(fs, xc);
end

% Plotting
theta = N*fs_mu;
threshold = xc;
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
idxPFA = x>=threshold&x<10*N*sigma;
idxPM = x>-10*N*sigma & x <= threshold+0.01;
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