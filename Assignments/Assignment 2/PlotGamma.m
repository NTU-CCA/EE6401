f=-0.5:0.01:0.5;

R=zeros(size(f));
Gamma=zeros(size(f));
for i=1:101
    M=0.02946;
    N=(abs(1+(-1.5387*exp(-1i*2*pi*f(i)))+(0.9169*exp(-1i*4*pi*f(i)))))^2;
    R(i)=M/N;
    M2=2.1962*((abs(1-0.2732*exp(-1i*2*pi*f(i))))^2);
    N2=(abs(1-0.6*exp(-1i*2*pi*f(i))))^2;
    Gamma(i)=M2/N2;
end

plot(f,R);
hold on;
plot(f,Gamma);
