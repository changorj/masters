%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%          Question 1      %%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
data = load('station1time.dat');
data2 = load('station1HZ.dat');
t = data(:,1);
pressure = data2(:,1);
N = length(pressure);
S = 1;
fnyq = 1/(2*S);
fsa = 1/(N*S);
fa = fsa*[0:N-1];

avmean=mean(pressure);
vari = var(pressure);
rpressure=pressure-avmean;
enti = S * sum(rpressure.^2);  % sum energy in time domain

figure(1)
plot(t,rpressure);
title('Surface Pressure data set','FontSize',15);
xlabel('Time (hr)','FontSize',15);ylabel('Surface Pressure (hPa)','FontSize',15);
%axis([0 92064 -40 30])

Npad = 32768;
ft = [pressure', zeros(1,Npad-N)]'; % padding to 2^18
ftrm(1:N) = pressure-avmean;
ftrm(N+1:Npad) = zeros(1,Npad-N); % removing mean 

% use Hann window 
fs = 1/(Npad*S);
f = fs*[0:Npad-1];
whann = hann(Npad);
ftrmh = ftrm .* whann'; 

fwe = sum(ftrmh.^2); % sum energy after windowing
wfc = sqrt(enti/fwe); % window correction factor
g = ftrmh*wfc; % data compensantion 

wind2=parzenwin(262144);
FKh=g.*wind2';

FKh = S*fft(FKh);
FKMh = sqrt(FKh.*conj(FKh));
Ph = FKMh.^2/(Npad*S);
PSDh = Ph(1:Npad/2+1);
PSDh(2:Npad/2) = PSDh(2:Npad/2).*2;

figure(2)
plot(f(1:Npad/2+1),PSDh,'-bs','markerfacecolor','b'); hold on
title('1-sided PSD (Smooth using Method B)','FontSize',15);
xlabel('Ftrue (hr^-1)','FontSize',15);ylabel('1-sided PSD (hPa^2 / cph)','FontSize',15);
[auto,lags]=xcorr(rpressure,'unbiased');
lags=abs(lags);
w=1-(lags/Npad);
fauto=w(1:Npad/2+1).*PSDh;
plot(f(1:Npad/2+1),fauto,'-rs','markerfacecolor','r'); hold on

%PSDf=fft(PSDh);
wind2=parzenwin(131073);
%PSDf=abs(PSDf);
PSDlast=PSDh.*wind2';
figure(2)
plot(f(1:Npad/2+1),PSDlast,'-bs','markerfacecolor','b');