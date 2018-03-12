% Modified periodogram
function [Pxx_hat, axis] = modper(x, win, fac, n1, n2)
    load('data/sonardata4.mat');
    x = x(:);
    if nargin == 3
        n1 = 1;
        n2 = length(x);
    end
    L = n2 - n1 + 1;
    w = ones(L, 1);
    if (win == 1); w = hamming(L);
    elseif (win == 2); w = hanning(L);
    elseif (win == 3); w = bartlett(L);
    elseif (win == 4); w = blackman(L);
    end
    wx = x(n1:n2).*w/norm(w);
    Pxx_hat = L*per(wx, fs, fac);
    axis = linspace(0,fs/1000,L);
end