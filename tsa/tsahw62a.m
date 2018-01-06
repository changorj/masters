%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%       Question 2(a)&(b)  %%%%%%%
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

[auto,lags]=xcorr(rpressure,'unbiased');

figure(1); hold on
plot(lags,auto,'linewidth',1.3)
title('Autocorrelation of the Surface Pressure data set','FontSize',15);
xlabel('Lags','FontSize',15);ylabel('Autocorrelation (hPa^2)','FontSize',15);

%auto=auto*0.15;
lags=lags*0.15;
wind=lagwind(184127,'parzen');
wind2=parzenwin(184127);
%fauto=auto.*wind;
%fauto2=auto.*wind2';
flags=lags.*wind;
flags2=lags.*wind2';
plot(flags2,auto,'k')
%plot(lags,fauto,'r')
plot(lags,fauto2,'k')
figure(2); hold on
%plot(wind,'r','linewidth',1.3)
plot(wind2,'k')
title('Parzen Window','FontSize',15);
xlabel('Lags','FontSize',15);ylabel('Amplitude','FontSize',15);
%figure(3)
%plot(flags,auto,'r')
figure(4)
plot(flags2,auto,'k')
title('Lag Window for 15% of data','FontSize',15);
xlabel('Lags','FontSize',15);ylabel('Autocorrelation (hPa^2)','FontSize',15);
fsa=1/(184127*S);
fa = fsa*[0:184127-1];