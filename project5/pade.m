clc; clear;
x = [1, 1.5, 0.75, 0.375, 0.1875, 0.0938];% Unstable model, poles at -1.5 and 1.5
stem(x)
p = 2; q = 0;

% See page 139 Padé
x = x(:);
X = convm(x,p+1);
Xq = X(q+2:q+p+1,2:p+1);
xqplus1 = X(q+2:q+p+1,1);
a = [1; Xq\-xqplus1]; 
b0 = x(1,1);
b = X(1:q+1,1:p+1)*a; % b0 = b

x_hat = filter(1, a, [1 zeros(1,length(x)-1)]);

e = abs(x - x_hat(:)).^2;