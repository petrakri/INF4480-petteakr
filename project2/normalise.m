function [norm_fx, fx, x_norm, mu, sig] = normalise(data, bins)
h = histogram(data, bins);
fx = h.Values;
bin_width = h.BinWidth;
edges = h.BinEdges;
x_norm = linspace(edges(1,1), edges(1,end),bins);
sig = std(data);
mu = mean(data);
norm_fx = fx/sum(fx*bin_width);
end



