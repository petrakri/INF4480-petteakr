% Task 2.2
close all; clear; clc;
M = 80;
N = 100;

v1 = rp1(M,N);
v2 = rp2(M,N);
v3 = rp3(M,N);
m1 = mean(v1,1);
m2 = mean(v2,1);
m3 = mean(v3,1);
sig1 = std(v1);
sig2 = std(v2);
sig3 = std(v3);

figure(1);
subplot(211);
plot(m1); hold on;
plot(m2); plot(m3); hold off;
title(['N = ', num2str(N), ', M = ', num2str(M)]);
ylabel('Ensemble mean plot');
xlabel('N');
legend('\mu_1','\mu_2','\mu_3');

subplot(212);
plot(sig1); hold on;
plot(sig2); plot(sig3); hold off;
ylabel('Standard deviation plot');
xlabel('N');
legend('\sigma_1','\sigma_2','\sigma_3');

function [ v ] = rp1(M, N) %<<------ RANDOM PROCESS #1
a = 0.02;
b = 5;
Mc = ones(M, 1)*b*sin((1:N)*pi/N);
Ac = a * ones(M, 1)*[1:N];
v = (rand(M, N) - 0.5).*Mc + Ac;
end

function [ v ] = rp2(M, N) %<<------ RANDOM PROCESS #2
Ar = rand(M, 1)*ones(1, N);
Mr = rand(M, 1)*ones(1, N);
v = (rand(M, N) - 0.5).*Mr + Ar;
end

function [ v ] = rp3(M, N) %<<------ RANDOM PROCESS #3
a = 0.5;
m = 3;
v = (rand(M, N) - 0.5)*m + a;
end