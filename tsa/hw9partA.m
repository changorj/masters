% Parametric Trend Estimation

% Step 1: Load the Data

% Step 2: Fit Quadratix Trend
% fit the polynomial to the observed series

T = length(river2);
t = (1:T)';
X = [ones(T,1) t t.^2];
b = X\river2;
tH = X*b;

% Step 3: Detrend Original Series
% subtract hte fitted quadratic line from the original data

xt = river2 - tH;

% Step 5: Estimate Seasonal Indicator Variables
% create indicator(dummy) variables for each 28 days. The first indicator
% is equal to one for day-1 observations, and zero otherwise. The second
% indicator is equal to one for day-2 obervations, and zero otherwise. A
% total of 28 indicator variables are created for the 28 day period.
% Regress the detrended series against the seasonal indicators.

mo = repmat((1:28)',14,1);
sX = dummyvar(mo);
bS = sX\xt;
st = sX*bS;

% Step 6: Deseasonalize Original Series
% subtract the estimated seasonal component from the original series

dt = river2 - st;

% Step 6: Estimate irregular component (residuals) 
% subtract the trend and seasonal estimates from the original series. The
% reminder is an estimate of the irregular component

bt = river2 - tH - st;

