function [PM, PD] = calc_pd(f, xc)
    %   Inputs:
    %           x   - Timeseries
    %           N   - Amount of samples in the timeseries
    %           fs  - PDF of signal + noise (theta)
    %           xc - Threshold limit (gamma)
    %   Outputs:
    %           PM  - Probability of miss
    %           PD  - Probability of choosing correct
    %   Petter Andre Kristiansen

    PD = integral(f, xc, inf);
    PM = 1 - PD;
end