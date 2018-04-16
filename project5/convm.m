function X = convm(x,p)
% Appendix A.2 creating convolution matrix, or use convmtx from matlab
N = length(x) + 2*p-2;
x = x(:);
xpad = [zeros(p-1, 1); x; zeros(p-1,1)];
for i = 1:p
   X(:,i) = xpad(p-i+1:N-i+1); 
end
end