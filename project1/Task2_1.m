% Task 2.1
close all; clear; clc;
M = 4;
N = 100;

v1 = rp1(M,N).';
v2 = rp2(M,N).';
v3 = rp3(M,N).';

figure(1);
subplot(311);
plot(v1);

subplot(312);
plot(v2);
ylabel(['M = ', num2str(M)]);

subplot(313);
plot(v3);
xlabel(['N = ', num2str(N)]);

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