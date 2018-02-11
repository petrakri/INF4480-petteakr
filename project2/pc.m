function compr = pc(s_Tx)
load('sonardata2.mat');
N_h = size(data,2);
N_t = size(data,1);
compr = zeros(N_t,N_h);
for i = 1:N_h
    s_Rx = data(:,i).';
    [corr, lag] = xcorr(s_Rx, s_Tx);
    step = corr(1,N_t:end);
    compr(:,i) = step.';
end