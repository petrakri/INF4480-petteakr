close all; clear; clc;
xx = complex( randn(100,1), randn(100,1) );
x = [xx ; complex(zeros(200,1))] + 1;
y = [complex(zeros(50,1)) ; xx ; complex(zeros(150,1))] - 1;
n1 = complex(randn(size(x)), randn(size(x)))/10;
n2 = complex(randn(size(x)), randn(size(x)))/10;
x = x + n1;
y = y + n2;
[Cv,lag] = xcov( y, x, 'coeff' );
figure
subplot(1,2,1);
plot( real(x) ); hold on; plot( real(y) );
subplot(1,2,2);
plot(lag,abs(Cv));