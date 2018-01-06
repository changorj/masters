function model = DipRefractSolve(fwd,rvs)
%***************************************************************************
% determine flat velocity model from refraction data
%   fwd(n,2)     slopes and intercept times of forward 
%   rvs(n,2)     slopes and intercept times of reverse.
%   model(n,3)   thickness, vel.m and bottom interface dip in degs.
% n is the number of layers
%***************************************************************************
md = fwd(:,1);
tid = fwd(:,2);
mu = rvs(:,1);
n = length(tid);
v(1) = 2./(md(1)+mu(1));
for i = 1:n-1
    % recursive from the top layer to the i-th layer.
    d = asin(v(1)*mu(i+1));
    u = asin(v(1)*md(i+1));
    t0 = tid(i+1);
    for k = 1:i-1
        t0 = t0 - hd(k)*(cos(d)+cos(u))/v(k);
        d = asin((v(k+1)/v(k))*sin(d-b(k)))+b(k);
        u = asin((v(k+1)/v(k))*sin(u+b(k)))-b(k);
    end
    if ( t0<0.  ||  cos(d)<0.  ||  cos(u)<0. )
        fprintf('**** LVZ or negative thickness of layer %d\n' ,i);
        return;
    end
    hd(i) = t0*v(i)/(cos(d)+cos(u));
    b(i) = 0.5*(d-u);
    v(i+1) = v(i)/sin(0.5*(d+u));
    model(i,:) = [hd(i), v(i), b(i)*180./pi];
end
model(n,:) = [0,v(n),0];