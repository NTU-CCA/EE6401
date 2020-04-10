clc;

%LSM steepest descent search

%autocorrelation matrix
autocorrelation_matrix=[1 0.5; 0.5 1];

%crosscorrelation vector
crosscorrelation_vector=[0.25; -0.25];

%origanl filter coefficients
hm_0=[1;1];

%step size
step_size=0.35;

%identify matrix
I=eye(2);

%output matrix
output=zeros(4,1);
output(1,1)=hm_0(1);
output(2,1)=hm_0(2);

%maximum iteration number
max_ite=1000;

%minimum error
min_err=0.001;

for i=2:max_ite
    h_pre = [output(1,i-1); output(2,i-1)];%M=2
    g = 2*(autocorrelation_matrix * h_pre - crosscorrelation_vector);
    h = (I - step_size * autocorrelation_matrix) * h_pre + (step_size * crosscorrelation_vector);
    output(1,i)=h(1);
    output(2,i)=h(2);
    output(3,i)=g(1);
    output(4,i)=g(2);
    if (g(1)<min_err && g(2)<min_err)
        break;
    end
end


%plot the evolution graph
x = (1: size(output,2));
y1=output(1,:);
y2=output(2,:);

plot(x, y1);
hold on
plot(x, y2);
ylim([-1 1]);

    








