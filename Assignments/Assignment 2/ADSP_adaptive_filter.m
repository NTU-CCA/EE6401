clc

%obtain cos
t=0:pi/500:10*pi;
x=cos(t);
x=x(:);%cos value
sz=size(x,1);
subplot(4,2,1);
title('the desired cos wave signal');
plot(x);

xf=fft(x,1024);
subplot(4,2,2);
title('the desired cos wave signal in freq domain');
plot(abs(xf));

%white noise
z=tf('z',1);
F0=0.5-0.5*z^-1;
w=randn(size(x));
noise=lsim(F0,w);%y0
subplot(4,2,3);
title('white noise');
plot(noise);

%noise in freq domain
wf=fft(noise,1024);
subplot(4,2,4);
title('white noise in freq domain');
plot(abs(wf));

%the primal signal
d=x+noise;
subplot(4,2,5);
title('primal signal');
plot(d);

%the primal signal in freq domain
df=fft(d,1024);
subplot(4,2,6);
title('primal signal in freq domain');
plot(abs(df));

%step size
mu=0.00125;
%orignal coefficients vector
hm_0=[1;1];



[hm,ee] = LMS(mu, hm_0, w, d);

%en = dn-ee
en=d-ee;
subplot(4,2,7);
title('estimated signal');
plot(en);

subplot(4,2,8);
title('filter coefficients');
plot((1:1:5001),hm(1,:));
hold on;
plot((1:1:5001),hm(2,:));

%using stochastic gradient descent algorithm
function [hm,ee]=LMS(mu, h0, x, d)

%input signal
N=length(x);

%make sure x and d are column vector
x=x(:);
d=d(:);

%filter coefficient
M=size(h0, 1);
hm=zeros(2,1);
ee=zeros(size(x));

for n=M:N
    arr=x(n:-1:n-M+1);
    e(n)=d(n)-h0'*arr;
    h0=h0+mu*e(n)*arr;
    hm(1,n)=h0(1);
    hm(2,n)=h0(2);
    ee(n)=h0'*arr;
end

end
    