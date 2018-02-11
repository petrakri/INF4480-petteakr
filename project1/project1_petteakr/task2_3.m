% Task 2.3
close all; clear; clc;
M = 4;
N = 1000;

v1 = rp1(M,N).';
v2 = rp2(M,N).';
v3 = rp3(M,N).';

% Time average, using eq. 3.58
% Process 2
A_2_1 = sum(v2(:,1))/N;
A_2_2 = sum(v2(:,2))/N;
A_2_3 = sum(v2(:,3))/N;
A_2_4 = sum(v2(:,4))/N;

% Process 3
A_3_1 = sum(v3(:,1))/N;
A_3_2 = sum(v3(:,2))/N;
A_3_3 = sum(v3(:,3))/N;
A_3_4 = sum(v3(:,4))/N;

imagesc(v3([end-100:end],:)')
xlabel('N');
ylabel('M');
colormap jet
%figure(1);
%subplot(311);
%plot();

%subplot(312);
%plot(v2);
%ylabel(['M = ', num2str(M)]);

%subplot(313);
%plot(v3);
%xlabel(['N = ', num2str(N)]);

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