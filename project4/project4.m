% Project 4
clear; clc; close all;

% 1B
N = 10000;
sigma = 5;
fn_mu = 0;
fs_mu = 5;

theta = 5;
mid = (0 + theta)/2;

% pdfs
fn = @(x) (1./sqrt(2*pi*sigma.^2)) * exp(-((x - fn_mu).^2/(2*sigma.^2)));
fs = @(x) (1./sqrt(2*pi*sigma.^2)) * exp(-((x - fs_mu).^2/(2*sigma.^2)));
x = linspace(-8*sigma, 8*sigma, N);
xc = cfar(x, fn, 0.1);


% lambda
%threshold = qinv(0.1,0,sigma);
threshold = xc;


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

%% Calculate P_D 1C
fn = @(x) (1./sqrt(2*pi*sigma.^2)) * exp(-((x - fn_mu).^2/(2*sigma.^2)));
fs = @(x) (1./sqrt(2*pi*sigma.^2)) * exp(-((x - fs_mu).^2/(2*sigma.^2)));
x = linspace(-8*sigma, 8*sigma, N);
[PM, PD] = calc_pd(fs, xc);


%% 1D ratio PD/PFA
close all; clear; clc;
sigmas = [1, 3, 5, 10, 15];
N = 1000;
M = 300;
PMs = zeros(size(sigmas,2),M);
PDs = zeros(size(sigmas,2),M);
xPFA = linspace(0,1,M);
fn_mu = 0;
fs_mu = 5;
for i = 1:size(sigmas,2)
    sigma = sigmas(i);
    fn = @(x) (1./sqrt(2*pi*sigma.^2)) * exp(-((x - fn_mu).^2/(2*sigma.^2)));
    fs = @(x) (1./sqrt(2*pi*sigma.^2)) * exp(-((x - fs_mu).^2/(2*sigma.^2)));
    x = linspace(-10*sigma, 10*sigma, N);
    for j = 1:M
        %threshold = qinv(xPFA(j),0,sigmas(i));
        xc = cfar(x, fn, xPFA(j));
        [~, PDs(i,j)] = calc_pd(fs, xc);
        %PDs(i,j) = PD;
        
    end
    plot(xPFA, PDs(i,:), 'LineWidth', 2); hold on;
    ds(i) = fs_mu/sigmas(i);
end

legend(['\sigma = 1,   d = ',num2str(ds(1))], ['\sigma = 3,   d = ',...
    num2str(ds(2))], ['\sigma = 5,   d = ', num2str(ds(3))],...
    ['\sigma = 10, d = ', num2str(ds(4))], ['\sigma = 15, d = ', num2str(ds(5))], 'Location', 'southeast');
title('ROC curves of the detector');
xlabel('P(FA|N)');
ylabel('P(D|S)');
grid on; hold off;


%% 1F find N where PFA = 0.01

threshold = xc;
pks = findpeaks(f1,x);
figure(2);
plot(x, f0, 'm', 'LineWidth', 1.5); hold on;
plot(x, f1, 'b', 'LineWidth', 1.5);

if threshold > mu
    labels = {0, mu, threshold};
    set(gca,'xtick',[0,mu,threshold],'xticklabel',labels);
else
    labels = {0, threshold, mu};
    set(gca,'xtick',[0,threshold,mu],'xticklabel',labels);
end


% Color the areas
idxPFA = x >= threshold-0.001 & x < N*10*sqrt(var/N);
idxPM = x > -10*N*sqrt(var/N) & x <= threshold;
idxPD = idxPFA;
idxPR = idxPM;
HPD = area(x(idxPD), f1(idxPD));
HPFA = area(x(idxPFA), f0(idxPFA));
%HPR = area(x(idxPR), f0(idxPR));
HPM = area(x(idxPM), f1(idxPM));

% Lines for threshold and means

plot([threshold threshold], [0 pks], 'LineWidth', 1.5, 'Color', [0, 0.2, 0.2]);
line([0 0], [0 pks]);
line([mu mu], [0 pks]);
set(HPFA(1),'FaceColor',[0.7 1 0.5]);
set(HPD(1),'FaceColor',[0 1 0]);
%set(HPR(1),'FaceColor',[0.5 0.2 0.2]);
set(HPM(1),'FaceColor',[1 0 0]);
legend('PDF: noise', 'PDF: signal + noise', 'P_{D}', 'P_{FA}', 'P_{M}', 'Threshold x_c');
title('Representation of False Alarm and Decision');

%%


%% Test
clear; clc;
N = 10000;
sigma = 5;
fn_mu = 0;
fs_mu = 5;
fn = @(x) (1./sqrt(2*pi*sigma.^2)) * exp(-((x - fn_mu).^2/(2*sigma.^2)));
fs = @(x) (1./sqrt(2*pi*sigma.^2)) * exp(-((x - fs_mu).^2/(2*sigma.^2)));
x = linspace(-8*sigma, 8*sigma, N);
xc = cfar(x, fn, 0.1);
[PM, PD] = calc_pd(fs, xc);


