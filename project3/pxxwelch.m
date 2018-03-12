% Welch method
function [axis, Pxx_welch] = pxxwelch(x, L, D, win)
    ol = D/L; n1 = 1; n0 = (1-ol)*L;
    nsec = floor((length(x) - L)/n0) + 1;
    Pxx_welch = 0;
    if (ol >= 1) | (ol < 0)
        error('Overlap is invalid');
    end
       
    for i = 1:nsec
        [Pxx_hat, axis] = modper(x, win, 1, n1, n1+L-1);
        Pxx_welch = Pxx_welch + Pxx_hat/nsec;       
        n1 = n1 + n0;
    end
    
end