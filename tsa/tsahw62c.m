%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%       Question 2(c)      %%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
data = load('st9707p.dat');
t = data(:,1)';
pressure = data(:,2)';
N = length(pressure);
S = 1;
fnyq = 1/(2*S);
fsa = 1/(N*S);
fa = fsa*[0:N-1];

avmean=mean(pressure);
vari = var(pressure);
rpressure=pressure-avmean;
enti = S * sum(rpressure.^2); 

[auto,lags]=xcorr(rpressure,'unbiased');
Npad = 262144;
N = length(auto);

ft = [auto, zeros(1,Npad-N)]; % padding to 2^18
ftrm(1:N) = auto;
ftrm(N+1:Npad) = zeros(1,Npad-N); 

fs = 1/(Npad*S);
f = fs*[0:Npad-1];

FKh = S*fft(ftrm);
FKMh = sqrt(FKh.*conj(FKh));
Ph = FKMh.^2*(1/(Npad*S));
PSDh = Ph(1:Npad/2+1);
PSDh(2:Npad/2) = PSDh(2:Npad/2).*2;

figure(2)
plot(f(1:Npad/2+1),PSDh,'-bs','markerfacecolor','b'); hold on
title('1-sided PSD (using Hann window))','FontSize',15);
xlabel('Ftrue (hr^-1)','FontSize',15);ylabel('1-sided PSD (hPa^2 / cph)','FontSize',15);
