
%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%
%#%#%#           SETUP           #%#%#%
%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%
close all; clear; clc;
load('data/sonardata4.mat');
N_h = size(data,2);
N_t = size(data,1);
M = 1200;
N = 1024;
C = 14;

%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%
%#%#%#     Transmitted signal    #%#%#%
%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%
chirprate = B/T_p; 
L = T_p*fs;
t_chirp = linspace(-T_p/2, T_p/2, L);
s_Tx = exp(1i*2*pi*(chirprate/2)*t_chirp.^2);
s_Tx = [s_Tx zeros(1, N_t-ceil(L)+1)];

%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%
%#%#%#     Received signal 1A    #%#%#%
%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%
s_Rx = data(M:M+N,C);
a = asd(12);


