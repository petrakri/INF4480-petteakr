function xc = cfar(x, f, pfa)
%   f - has to be a function f(x)
%
%
%
    dx = (x(1,end)-x(1,1))/length(x);
    xc = x(1,1);
    
for i = 1:length(x)
    Q = integral(f,-inf,xc);
    if Q <= 1 - pfa
        xc = xc + dx;
    else
        break;
    end
end
%PFA = integral(f, xc, inf)
end