%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%          Question 2 (d)     %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fs = 1; % Sampling in hr
S = 1/fs; % Sampling interval (cph)
N = 742;
N1 = 2048; % N to the second next power of 2, 2^11
data=load('test1m.dat');
sample=data(:,1);
grav=data(:,2);
fnyq=N/2+1;
avmean=mean(grav);
vari = var(grav);
rgrav=grav-avmean;
%figure(1)
%plot(sample,grav);
figure(2)
plot(sample,rgrav);
title('Gravity Time Series (mean removed)','FontSize',15);
xlabel('Time (hr)','FontSize',15);
ylabel('Acceleration (uGal)','FontSize',15);
axis([0 742 -0.6 0.8])
enti = (sum(rgrav.^2))*S;  % sum energy in time domain
rgrav = rgrav.'; % transpose of time series 
rgrav = rgrav.*hanning(length(rgrav))'; % han window
%X = fft(rgrav); % Fast Fourier transform of the function, no padding 
X = fft(rgrav,N1); % Fast Fourier transform of the function, padding up to 2^11
NumUniquePts = ceil((N1+1)/2); % Calculate the numberof unique points
fftx = X(1:NumUniquePts); % FFT is symmetric, throw away second half 
mx = abs(fftx); % Take the magnitude of fft 
mx = (mx.^2)/(N*S); % Take the square of the magnitude of fft 
% Since we dropped half the FFT, we multiply mx by 2 to keep the same energy.
% The DC component and Nyquist component, if it exists, are unique and should not be multiplied by 2.
if rem(N1, 2) % odd nfft excludes Nyquist point
  mx(2:end) = mx(2:end)*2;
else
  mx(2:end -1) = mx(2:end -1)*2;
end
enfr = sum(mx); % sum energy in the frequency domain
%wp = enfr/N;
 
for i = 1:N1/2+1
    f(i) = ((i-1)/(N1*S));
end
figure(3)
plot(f, mx)
%axis([0 0.5 0 256000])
title('1-sided PSD of Gravity time Series','FontSize',15);
xlabel('Ftrue (hr^-1)','FontSize',15);
ylabel('1-sided PSd (uGal^2/cph)','FontSize',15);