%%%%%%%%%% NO PADDING 
fs = 3600; % sampling time in sec %%% change from 1 hr to 10 hr for next example
S = 1/fs; % sampling interval (Hz)
N = 8; % length 
t = (1:N)*S; % time length
enti = sum(sum(x.^2));  % sum energy in time domain
x = [1 2 5 3 0 4 1 7]; % function
X = fft(x,N); % Fast Fourier transform of the function
mx = X(1:N/2);
mx = abs(mx); % Magnitude of the FFT, takes imaginary values out
phaX = angle(mx)*180/pi; % Phase of the FFT
f1 = mx/fs; % F1 
f = (0:N/2-1)*S; 
peri = mx.^2; % one-sided PSD
enfr = sum(peri/N); % sum energy in the frequency domain
plot(f(1:4),mx(1:4),'LineWidth',3)
hold on
plot(f(5:9),mx(5:9),'r','LineWidth',3)
plot(f(4:5),mx(4:5),'--k','LineWidth',2)
axis([-0.0011 0.0013 0 25])
title('Power Spectrum of Fk','FontSize',15);
xlabel('Frequency (Hz)','FontSize',15);
ylabel('Power','FontSize',15);


%%%%%% PADDING 
fs = 3600; % sampling time in sec %%% change from 1 hr to 10 hr for next example
S = 1/fs; % sampling interval (Hz)
x = [1 2 5 3 0 4 1 7]; % function
x = [x zeros(1, 32)]; % padding up to 32 points
N = 32; % length 
t = (1:N)*S; % time length
enti = sum(sum(x.^2));  % sum energy in time domain
X = fft(x,N); % Fast Fourier transform of the function
mx = X(1:N/2);
mx = abs(mx); % Magnitude of the FFT, takes imaginary values out
phaX = angle(X)*180/pi; % Phase of the FFT
f1 = mx/fs; % F1
f = (0:N/2-1)*S;
peri = mx.^2; % one-sided PSD
nfr = sum(peri/N); % sum energy in the frequency domain
figure(1)
loglog(f,peri,'LineWidth',3); hold on
title('One-sided PSD for (d)','FontSize',15);
xlabel('Frequency (Hz)','FontSize',15);
ylabel('Power/Hz','FontSize',15);
figure(2)
plot(f(1:4),mx(1:4),'LineWidth',3)
hold on
plot(f(5:9),mx(5:9),'r','LineWidth',3)
plot(f(4:5),mx(4:5),'--k','LineWidth',2)
axis([-0.0011 0.0013 0 25])
title('Power Spectrum of Fk','FontSize',15);
xlabel('Frequency (Hz)','FontSize',15);
ylabel('Power','FontSize',15);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%          Question 2         %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% first let's see the PSD with padding
fs = 10; % 170 years of data 
S = 1/fs;
x = [55.825 56.3833 58.075 56.525 56.2833 56.8167 58.2583 55.475 56.0667 56.3667 54.025 54.425 54.6667 55.0667 56.425 59.0167 56.1583 58];
x = [x zeros(1, 20)]; % padding up to 32 points
N = 20;
t = (1:N)*S;
enti = sum(sum(x.^2));
X = fft(x,N);
mx = X(1:N/2);
mx = abs(mx);
phaX = angle(X)*180/pi;
f1 = mx/fs;
f = (0:N/2-1)*S;
peri = mx.^2; 
enfr = sum(peri/N);
figure(1)
loglog(f,peri,'LineWidth',3); hold on
title('One-sided PSD for decadal temperatures','FontSize',15);
xlabel('Frequency (Hz)','FontSize',15);
ylabel('Power/Hz','FontSize',15);

% Now, let's multiply by han window
fs = 10; % 170 years of data 
S = 1/fs;
x = [55.825 56.3833 58.075 56.525 56.2833 56.8167 58.2583 55.475 56.0667 56.3667 54.025 54.425 54.6667 55.0667 56.425 59.0167 56.1583 58];
%x1 = x.*hanning(length(x))'; % han window
x = [x1 zeros(1, 20)]; % padding up to 32 points
N = 20;
t = (1:N)*S;
enti = sum(sum(x.^2));
X = fft(x1,N);
mx = X(1:N/2);
mx = abs(mx);
phaX = angle(X)*180/pi;
f1 = mx/fs;
f = (0:N/2-1)*S;
peri = mx.^2; 
enfr = sum(peri/N);
figure(1)
loglog(f,peri,'LineWidth',3); hold on
title('One-sided PSD for decadal temperatures','FontSize',15);
xlabel('Frequency (Hz)','FontSize',15);
ylabel('Power/Hz','FontSize',15);