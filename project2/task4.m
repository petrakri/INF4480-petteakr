close all; clear; clc;
load('sonardata2.mat');
N = 1600;
N_h = size(data,2);
N_t = size(data,1);
% Pulse length M
M = T_p*fs;
% Pulse time vector
t_chirp = linspace(-T_p/2, T_p/2, M);
% Chirprate
chirprate = B/T_p;
s_Tx = [exp(1i*2*pi*(chirprate/2)*t_chirp.^2) zeros(1,N_t-M)];
compr = pc(s_Tx);
% Resample rate
upr = 8;

compr = abs(compr(1:N,:));
% oppsampler pulskomprimert 4-8 for 1 kanal
rscompr = resample(compr,upr,1);
p8 = rscompr(:,8);

% max(nye resamplet signalet)
[max_p8, ind_p8] = max(p8);

% se på samplene over halvparten av den maksimale (max/2)
p8_cut = p8(p8 > max_p8/2);
ax = size(p8_cut,1)/2;
% tidsvektor, tilhørende x-samples av max/2
t_s = linspace((ind_p8-ax)/fs,(ind_p8+ax)/fs,ax*2);

% t_ax = linspace(t0, N/fs +t0, upr*N) to use in plots
% Denne brukes også til observasjonsmatrisen
t_ax = linspace(t_0, N/fs +t_0, upr*N);

N_s = size(t_s,2); %antall verdier i x-aksen for +max/2
H = [ones(N_s, 1) t_s.' (t_s.^2).'];

lse_theta = H\log(p8_cut);

th0 = lse_theta(1);
th1 = lse_theta(2);
th2 = lse_theta(3);

var_T = -(1/(2*th2));
tau = -(th1/(2*th2)); % slide 48
I0 = exp(th0 - ((th1.^2)/(4*th2)));

% Putter parameterene inn i hovedligning fra slide 46
% Plotter LSE med pulsecomprimated for 1 kanal
est = I0.*exp((-(t_ax-tau).^2)./(2*var_T));
plot(t_ax,est/max(est)); hold on;
plot(t_s,p8_cut/max(p8_cut),'r'); hold off;
ylim([0.2,1.1]);
%xlim([(ind_p8-ax)/fs,(ind_p8+ax)/fs]);
xlabel('ms');
%ylabel('Intesity');
legend('LSE', 'Pulse compressed');
% 4B samme som A for alle kanaler
% Plot for alle kanaler timedelay/channels


