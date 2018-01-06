data = load('st9707p.dat');
t = data(:,1);
pressure = data(:,2);
N = length(pressure);

S = 1;
fnyq = 1/(2*S);
fsa = 1/(N*S);
fa = fsa*[0:N-1];

FKa = S*fft(pressure);
FKMa = sqrt(FKa.*conj(FKa);

Pa = FKMa.^2/(N*S);
PSDa = Pa(1:N/2+1); % not Pa(1:N/2) !!
PSDa(2:N/2) = PSDa(2:N/2).*2; % not  PSDa(2:N/2-1) = PSDa(2:N/2-1).*2

time_enga = S * sum(rpressure.^2);
freq_enga = sum(FKMa.^2/(N*S));

figure(1)
subplot(2,1,1)
plot(t,pressure);
title('plot of data');
xlabel('time (hr)');ylabel('V');

subplot(2,1,2)
plot(fa(1:N/2+1),PSDa, '-r');
title('1-sided PSD');
xlabel('frequency (hr^-1)');ylabel('Amplitude (V^2hr');

peakamp = max(PSDa);
q = find(PSDa==peakamp);
peakfreq = fa(a);

clear all

Npad = 256;
ftnew = [pressure, zeros(1,256-N)]; %ftnew is the value by padding to 256
ftrm(1:N) = pressure-avmean;
ftrm(N+1:256) = zeros(1,256-N); %ftrm is the ftnew without mean 

fnyq = 1/(2*S);
fs = 1/(Npad*S);
f = fs*[0:Npad-1];


freq_eng = sum(FKMr.^2/(Npad*S));

% use Hann window 
whann = hann(Npad);
ftrmh = ftrm .* whann'; 

FKh = S*fft(ftrmh);
FKMh = sqrt(FKh.*conj(FKh));

Ph = FKMh.^2/(Npad*S);
PSDh = Ph(1:Npad/2+1);
PSDh(2:Npad/2) = PSDh(2:Npad/2).*2;

figure(3)
plot(f(1:Npad/2+1),PSDh,'-r','linewidth',1.3); hold on
plot(f(1:Npad/2+1),PSDr,'linewidth',1.3);
hold off
title('1-sided PSD (using data window)');
xlabel('frequency(yr^-1)');ylabel('amplitude (deg F^2 yr)');

peakamp = max(PSDh);
a = find(PSDh==peakamp);
peakfreq = f(a);
