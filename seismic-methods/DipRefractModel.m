function [fwd, rvs] = DipRefractModel(model, len)
%******************************************************************
% Compute refraction data from dip velocity model.
% model(n,3)   thickness, vel., and bottom interface dip in deg.
% len          up-dip shot offset.
% fwd/rvs(m,2) slope and intercept time of forward and reverse
% n is the number of layers, m<=n
%******************************************************************
hd = model(:,1);
hu = hd;
v = model(:,2);
b = model(:,3)*pi/180.;
n = length(v);
j = 1;
vabove = 0.;
depd = 0.;
depu = 0.;
for i = 1:n
    depd = depd + hd(i);
    hu(i) = depd - len*tan(b(i)) - depu;
    if ( i<n && (hd(i)<0 || hu(i)<0.) )
        fprintf('****Negative thickness of layer %d\n' ,i);
        return;
    end
    depu = depu + hu(i);
    if ( v(i) > vabove )
        md = 1./v(1);
        mu = md;
        tid = 0.;
        tiu = 0.;
        if ( i>1 )
            % recursive from the refraction layer to the top layer
            d = 0.5*pi + b(i-1);
            u = 0.5*pi - b(i-1);
            for k = i-1:-1:1
                d = asin((v(k)/v(k+1))*sin(d-b(k)))+b(k);
                u = asin((v(k)/v(k+1))*sin(u+b(k)))-b(k);
                tmp = (cos(d)+cos(u))/v(k);
                tid = tid + tmp*hd(k);
                tiu = tiu + tmp*hu(k);
            end
            md = sin(u)/v(1);
            mu = sin(d)/v(1);
        end
        fwd(j,:) = [md, tid];
        rvs(j,:) = [mu, tiu];
        j = j + 1;
        vabove = v(i);
    end
end