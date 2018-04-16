function [ac,e,I] = acorpred(x,p,r)
x = x(:);
L = length(x);
if p >= L
    error("Model order too large")
end
X = convm(x,p+1);
l = 1;
u = L - 1 + p;
%Xq = X(lb:hb,1:P);
Xq = X(l:u,1:p);

I = l:(L-1+r);
ac = [1; -Xq \ X(2:L+p,1)];
e = abs(X(1:L+p,1)'*X*ac);
end