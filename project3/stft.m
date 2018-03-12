function stfft = stft(x, L, D, win, fac)
    ol = D/L; n1 = 1; n0 = (1-ol)*L;
    nsec = floor((length(x) - L)/n0) + 1;
    stfft = zeros(L*fac, nsec);
    if (ol >= 1) | (ol < 0)
        error('Overlap is invalid');
    end
       
    for i = 1:nsec
        [Pxx_hat, ~] = modper(x, win, fac, n1, n1+L-1);
        stfft(:,i) = Pxx_hat(1:end)/nsec;
        n1 = n1 + n0;
    end
end