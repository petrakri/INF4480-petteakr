function [ac,e,I] = covpred(x, p, r)
%   COVPRED       Covariance method to predict x[n+r]
%       Usage: [a,e] = covpred(x, P, r)
%       
%           x : input signal
%           P : order of predictor ( = number of poles)
%           r : (OPTIONAL) prediction distance, i.e., predict x[n+r]
%           a : prediction error filter coefficients
%           e : prediction error signal over I
%           I : range of error signal (e.g., for covariance methid)
%               I = P:(Lx-1+r)
%           
%           Example: x = filter(1, [1 0.2 0.3], [1 zeros(1,100)]);
%                    [a,e] = covpred(x, 2, 0)
%           The returned vectoor a should be [1 0.2 0.3]
%   Function shell by   
%   "Computer-Based Exercise for Signal Processing Using MATLAB ver.5"
x = x(:);
L = length(x);
if p >= L
    error("Model order too large")
end
X = convm(x,p+1);
l = p;
u = L - 1;
I = l:u;
Xq = X(l:u, 1:l);
ac = [1; -Xq \ X(p+1:L,1)];
e = abs(X(p+1:L,1)'*X(p+1:L,:)*ac);

end