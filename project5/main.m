clear; clc; close all;
load("DJIAdata.mat");
poles = [1 0.2 0.3];
p = length(poles)-1;
%

% Covariance method
figure();
[a_cov, e_cov, I_cov] = covpred(dow3, p, 5);
zplane(0, a_cov);

% Autocorrelation method
figure();
[a_ac, e_ac, I_ac] = acorpred(dow3, p, 5);
zplane(0, a_ac);

x_hat_cov = filter(1, a_cov, [1 zeros(1,length(dow3)-1)]);
x_hat_cov = x_hat_cov(:);

plot(dow3); hold on; plot(x_hat_cov); legend('dow3', 'x_hat')