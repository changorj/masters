function model = ReflectSolve(rms)
%********************************************************
% Input: rms(n, 2)  vrms and intercept times.
% Output: model(n, 2) thicknesses and velocities
% n is the number of layers
%*******************************************************
vr = rms(:,1);
to = rms(:,2);
n = length(vr);
model = zeros(n,2);
model(1,2) = vr(1,1);
model(1,1) = ((vr(1)*to(1))/2);
for i = 2:n
    model(i,2) = ((((vr(i).^2)*to(i))-((vr(i-1).^2)*to(i-1)))/(to(i)-to(i-1)));
    if model(i,2) < 0
       model(i,2)= model(i,2)*(-1);
    end
    model(i,2) = sqrt(model(i,2));
    model(i,1) = ((model(i,2)*(to(i)-to(i-1)))/2);
end
