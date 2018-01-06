clear all

t1b = -1; % time beginning for f1
t1e = 1;  % time ending for f1
t2b = 0;  % time beginning for f2
t2e = 3;  % time end for f2
dt = 0.005; % interval sampling
n1 = (t1e-t1b)/dt + 1; % number of points for f1
n2 = (t2e-t2b)/dt + 1; % number of points for f2
% functions f1 & f2
f1 = zeros(1,n1);
f2 = zeros(1,n2);
for i = 1:n1
    if t1b+dt*(i-1) >= -1 && t1b+dt*(i-1) <= 1
        f1(i) = 1;
    end
end
for i = 1:n2
    if t2b+dt*(i-1) >= 0 && t2b+dt*(i-1) <= 3
        f2(i) = (t2b+dt*(i-1))/2;
    end
end

f3 = conv(f1,f2); % convolution of f1*f2
t3b = t1b + t2b; % time beginning for final convolution
t3e = t1e + t2e; % time ending for final convolution
n3 = (t3e-t3b)/dt + 1; % number of points for convolution 
% plots
x1 = linspace(t1b,t1e,n1);
x2 = linspace(t2b,t2e,n2);
x3 = linspace(t3b,t3e,n3);
figure(1)
stem(x1,f1);
hold on
stem(x2,f2,'r');
axis([-2 4 0 2.5]);
figure(2)
stem(x3,f3,'g');