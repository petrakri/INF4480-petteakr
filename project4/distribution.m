function [data, fx, x, fx_norm, x_norm, mu, sig] = distribution(N, bins, type, v)
    
    % Generate data
    if isequal(type,'uni')
        data = rand(v,N);
    elseif isequal(type,'norm')
        data = randn(v, N);
    else
        data = type;
    end
    
    if v > 1
       data = mean(data);
    end
    
    % Mean of x_uniform
    mu = mean(data);

    % Standard deviation of x_uniform
    sig = std(data);

    % Generate histogram from data
    h = histogram(data,bins);
    
    % Obtain the y-values from histogram, representing the estimated f(x)
    fx = h.Values;
    % 1/(b-a) tbc
    

    % Obtain the binwidth of bins in histogram
    binWidth = h.BinWidth;
    
    % Create matching x-vector for bar-plotting f(x)
    if isequal(type,'uni')
        x = linspace(binWidth/2,1-binWidth/2,bins);
    elseif isequal(type,'norm')
        length = 8*sig; % 4 standard deviations, 99,7%
        x = linspace(-length, length, bins);
    else
        length = 10*sig; % 4 standard deviations, 99,7%
        x = linspace(-length, length, bins);
    end
    
    % Total area of bins
    pdf_area = sum(fx*binWidth);
    
    % Normalized histogram
    fx_norm = fx/pdf_area;
    
    % x-vector for normalized histogram
    edges = h.BinEdges;
    x_norm = linspace(edges(1,1), edges(1,end),bins);
    close(1);
end