% Periodogram

function Pxx_hat = per(x, fs, fac)
    X = fft(x, length(x)*fac);
    N = length(X);
    X(2:N-1) = X(2:N-1).*2;
    Pxx_hat = ((abs(X).^2)).*(2/fs); % Remember to use 10*log10 in plot because we square it here
end