function model = RefractSolveLU(refr)
%********************************************************
% determine flat velocity model from refraction data
% Input: refr(n, 2)  slopes and intercept times.
%                    require: p(i)>p(i+1), otherwise
%                    ti(i+1) is the thickness of layer i
% Output: model(n, 2) thicknesses and velocities
% n is the number of layers
%*******************************************************
p = refr(:,1);
ti = refr(:,2);
n = length(p);
model = zeros(n,2);
model(:,2) = 1 ./ p;
for i = 1:n-1
    if ( p(i+1)<p(i) )
        t0 = 0.5*ti(i+1);
        for k = 1:i-1
            t0 = t0-model(k,1)*sqrt(p(k)^2-p(i+1)^2);
        end
        if (t0>0.)
            model(i,1) = t0/sqrt(p(i)^2-p(i+1)^2);
        else
            fprintf('**Warning: intercept time too small %d\nm' ,i+1);
        end
    else
        fprintf('**Warning: LVZ for layer %d\n' ,i+1);
        model(i,1) = ti(i+1); % thickness fixed using the input.
    end
end