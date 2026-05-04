%%
% Example and evaluation of generating time series from PSD
% 

N = 100; % Length of timeseries [samples] - make it even
fs = 25; % Sample rate of timeseries [Hz]


% Derived
T = N/fs;  % Length of timeseries [s]
dt = 1/fs;  % Delta time [s]
df = 1/T;   % Delta freq [Hz]
dw = df*(2*pi);  % Delta freq [rad/s]
% Double sided freq. vector
ff_pos = linspace(0,fs/2,(N/2)+1)';% Includes Nyquist freq and zero
ff_neg = flip(-1*ff_pos(2:end-1));  % Doesn't include either
ff = [ff_pos; ff_neg];

time = (0:N-1)*dt;                    % Time vector

%% Method 1 - Multiply in freq. domain, then IFFT
% Generate white noise in freq. domain with random phase
rms_level = 1;
% Random number generator with specific seed
s = rng(42);

% Random phase for positive freq;
randphase_pos = rand(N/2+1,1)*2*pi;
% For negative freq;
randphase_neg = randphase_pos(2:end-1);
% Combine and express as complex number with unit intensity
noiseLinSpec = exp(1i*[randphase_pos; randphase_neg]);

% Sample the spectrum and make it double sided
psd_onesided = harris_psd(ff_pos*2*pi);  % From zero to Nyquist, inclusive
% Scale inverting https://www.mathworks.com/help/signal/ug/power-spectral-density-estimates-using-fft.html
% Positive frequencies
psd_pos = psd_onesided;
psd_pos(2:end-1) = psd_pos(2:end-1)/2;
% Double sided
psd_doublesided = ([ psd_pos;  flip(conj(psd_pos(2:end-1)))]);

figure(1);
clf()
subplot(211)
plot(ff,psd_doublesided)
hold on
plot(ff_pos,psd_onesided)
legend('Two-sided','One-sided')
subplot(212)
semilogx(ff,psd_doublesided)
xlabel('Freq [hz]')
ylabel('Sxx')

% Generate the two-sided PSD by introducing the random phase, with unity
% magnitude
psd_complex = sqrt(psd_doublesided).*noiseLinSpec;  
% See scaleing at https://www.mathworks.com/help/signal/ug/power-spectral-density-estimates-using-fft.html
timeseries = real(ifft(psd_complex,'symmetric')*sqrt(N*fs));


figure(2);
clf()
subplot(211)
plot(time,timeseries);
subplot(212)
plot(time,timeseries,'.-');
xlim([0 5])

%% Method 2: Multiply by amplitudes in time Domain Method


% Sampling of one-sided spectrum - doesn't have to be the same as before,
% but for now we'll use same spacing
M = N/2 + 1;

% Frequencies for evaluation of spectrum
df = (fs/2)/(M-1);  % or (fs/2)/N
ff = (df-df/2 : df : (M-1)*df)';
% Random phase
pp = randphase_pos;
yy = zeros(length(timeseries),1);
for ii = 1:length(ff)
    % Seems theoretically correct
    AA = sqrt(2*harris_psd(ff(ii)*2*pi)*df*2*pi);
    % But this agrees better
    AA = sqrt(harris_psd(ff(ii)*2*pi)/1.5*df*2*pi/2);
    
    % THIS WORKS
    AA = sqrt(2)*sqrt(1/(2*pi)*harris_psd(ff(ii)*2*pi)*df*2*pi);
    %AA = sqrt(2)*sqrt(2*harris_psd(ff(ii)*2*pi)*(df*2*pi));
    yy = yy+ AA*cos(ff(ii)*2*pi*time + pp(ii))';
end

% From paper
zz = zeros(length(timeseries),1);
fu = fs/2;
df = fu/M;
dw = df*2*pi;
for ii = 1:M-1
    fn = ii*df;
    wn = fn*2*pi;
    AA = sqrt(2)*sqrt(1/(2*pi)*harris_psd(wn)*dw);
    zz = zz+ AA*cos(wn*time + pp(ii))';
end



figure(3)
clf()
subplot(211)
plot(time,yy,'r');
subplot(212)
plot(time,yy,'r.-');
xlim([0 5])

    
%% PSD

%[pxx,f]=pspectrum(timeseries,fs);
%[pxx2,f2]=pspectrum(yy,fs);

% [pxx,f]=periodogram(timeseries);
% [pxx2,f2]=periodogram(yy);

Nx = length(timeseries);
nsc = floor(Nx/4.5);
nov = floor(nsc/2);
nff = max(256,2^nextpow2(nsc));

[pxx,f]=pwelch(timeseries,hamming(nsc),nov,nff,fs);
[pxx2,f2]=pwelch(yy,hamming(nsc),nov,nff,fs);
[pxx3,f3]=pwelch(zz,hamming(nsc),nov,nff,fs);

figure(4)
clf()
subplot(211)
plot(f,pxx)
hold on
plot(f2,pxx2,'r')
plot(f3,pxx3,'g')
plot(ff_pos,psd_onesided,'k--')
legend('ifft','time-domain','time-domain2','One-sided PSD')
subplot(212)
semilogx(f,pxx)
hold on
semilogx(f2,pxx2,'r')
semilogx(f3,pxx3,'g')
semilogx(ff_pos,psd_onesided,'k--')


%pwelch(timeseries)
%pwelch(yy)

%%
figure(10)
clf()
%plot(yy - timeseries)
plot(pxx-pxx2)
grid on;

mean(yy./timeseries)

median(yy./timeseries)
median(yy./timeseries)^2
sqrt(median(yy./timeseries))




