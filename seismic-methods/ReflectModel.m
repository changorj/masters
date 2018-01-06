function t = ReflectModel(model,x)
%***********************************************************
% Compute reflection time of a flat velocity model
% Inputs: model(n,2)    thicknesses and velocities
%         x(nx)         offsets
%***********************************************************
h = model(:,1);
v = model(:,2);
n = length(v);
m = 200;
da = 0.5*pi/m;
a = 0.;
xr = zeros(m,n);
tr = zeros(m,n);
for i = 1:m
    p = sin(a)/v(1);
    xx = 0.;
    tt = 0.;
    for j = 1:n
        eta = 1/v(j)/v(j)-p*p;
        if eta<0.
            break
        end
        eta = sqrt(eta);
        xr(i,j) = xx + 2*h(j)*p/eta;
        tr(i,j) = tt + 2*h(j)*eta;
        xx = xr(i,j);
        tt = tr(i,j);
    end
    tr(i,:) = tr(i,:) + p*xr(i,:);
    a = a + da;
end
% do interpolation
nx = length(x);
t = zeros(nx, n);
for i = 1:nx
    xx = abs(x(i));
    for j = 1:n
        for k = 1:m-1
            if xx<xr(k+1,j)
                break
            end
        end
        a = (tr(k+1,j)-tr(k,j))/(xr(k+1,j)-xr(k,j));
        t(i,j) = tr(k,j) + a*(xx-xr(k,j));
    end
end