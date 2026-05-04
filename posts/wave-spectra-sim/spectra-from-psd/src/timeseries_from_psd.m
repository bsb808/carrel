%% Start with two-sided PSD from Shinozuka and Deodatis
clear
Omega = linspace(-15,15,1000);
Gyy = shin(Omega);

figure(1);
clf()
plot(Omega,Gyy);
title('Two-Sided PSD')
ylabel ('G_{yy}(\omega) [units/(rad/s)')
xlabel('\omega [rad/s]')
grid on

%% Parameters

% Cut-off frequency
omega_u = 4*pi;  %15; % 12.6;  % rad/s

% Frequency sampling
% Number of frequency samples, determines \Delta\omega
%N = 128*20;
% For FFT : M must be \geq 2*N
%M = 2*N;
% ee = 4:14;
% for e = 1:length(ee)
%     MM(e) = 2^ee(e);
% end
% 
% for jj = 1:length(MM)
%M = MM(jj);

M = 2^12;
N = M;

% Derived values
domega = 2*omega_u/N;  %4*pi/N;

% dt_lim = 2*pi/(2*omega_u);
% dt = 0.25; %dt_lim; % Must be less than dt_lim

%% Sum of Cosines Method - using left Reimann sum

% Number of time steps
% Using the FFT sampling so both timeseries have same sampling
nt = M;
T0 = 2*pi/domega;
dt = T0/M;
tt1 = (0:dt:(M-1)*dt)';
% Generate phases for each summation
% Random number generator with specific seed
s = rng(42);
phases = rand(N,1)*2*pi;
% Summation, left Reimann sum
tic;
yy1 = zeros(length(tt1),1);
for n = 0:N-1
    % Sample the PSD
    omegan = n*domega;
    An = sqrt(2*shin(omegan)*domega);
    yy1 = yy1 + sqrt(2)*An *cos(omegan*tt1+phases(n+1));
end
soc_time = toc

% Try middle Riemann sum
yy3 = zeros(length(tt1),1);
tt3 = tt1;
for n = 0:N-1
    % Sample the PSD
    omegan = n*domega+domega/2;
    An = sqrt(2*shin(omegan)*domega);
    yy3 = yy3 + sqrt(2)*An *cos(omegan*tt1+phases(n+1));
end

tlim = 50;
figure(2);
clf()
subplot(211)
plot(tt1,yy1);
hold on
grid on
subplot(212)
plot(tt1,yy1,'.-');
hold on
xlim([0 tlim])
grid on

figure(20);
clf()
subplot(211)
plot(tt1,yy1);
hold on
plot(tt1,yy3,'g:');
grid on
subplot(212)
plot(tt1,yy1,'.-');
hold on
plot(tt1,yy3,'r:o');
xlim([0 tlim])
grid on
    


%% FFT Method
s = rng(42);
phases = rand(M,1)*2*pi;
% Resample so we get a similar timeseries
%phases = interp(phases,M/N);
% Generate series in frequency space
dt = T0/M;
tt2 = 0:dt:(M-1)*dt;

tic;
Bn = zeros(M,1);
for n = 0:N-1 %M-1
    omegan = n*domega;
    An = sqrt(2*shin(omegan)*domega);
    % Note the negative 1!
    Bn(n+1) = sqrt(2)*An*exp(-1i*phases(n+1));
end
yy2 = real(fft(Bn));
fft_time = toc

%timeratio(jj) = soc_time/fft_time
%end

figure(3);
clf()
subplot(211)
plot(tt2,yy2);
grid on
subplot(212)
plot(tt2,yy2,'.-');
xlim([0 tlim])
grid on


figure(2);
subplot(211)
title(sprintf('Simulated Timeseries y(t), N=M=%d',M));
plot(tt2,yy2,'r:');
ylabel('Amplitude [units]')
subplot(212)
plot(tt2,yy2,'r:o');
legend('Sum of Cosines','FFT')
ylabel('Amplitude [units]')
xlabel('Time [s]')
xlim([0 tlim])


% Trying to find the scaling
% figure(4)
% plot(yy1./yy2,'.')
% grid on
median(yy1./yy2)

%% Check by finding PSD from timeseries

% Estimated PSD for summation of cosines
Nx = length(yy1);
nsc = floor(Nx/4.5);
nov = floor(nsc/2);
nff = max(256,2^nextpow2(nsc));
fs1 = 1/median(diff(tt1));
[Sig1,f1]=pwelch(yy1,hamming(nsc),nov,nff,fs1);
% Transform to rad/s
w1 = f1*2*pi;  % Freq [rad/s]
Gamma1 = 1/(2*pi)*Sig1;  % Spectrum in units of rad/s, preserving expected power

Nx = length(yy2);
nsc = floor(Nx/4.5);
nov = floor(nsc/2);
nff = max(256,2^nextpow2(nsc));
fs2= 1/median(diff(tt2));
[Sig2,f2]=pwelch(yy2,hamming(nsc),nov,nff,fs2);
w2 = f2*2*pi;  % Freq [rad/s]
Gamma2 = 1/(2*pi)*Sig2;  % Spectrum in units of rad/s, preserving expected power

Nx = length(yy3);
nsc = floor(Nx/4.5);
nov = floor(nsc/2);
nff = max(256,2^nextpow2(nsc));
fs3= 1/median(diff(tt3));
[Sig3,f3]=pwelch(yy3,hamming(nsc),nov,nff,fs3);
w3 = f3*2*pi;  % Freq [rad/s]
Gamma3 = 1/(2*pi)*Sig3;  % Spectrum in units of rad/s, preserving expected power

% For comparison, calculated one-sided PSD at similar frequencies
ww = w2;
% Two-sided PSD values from function
yy = shin(ww);
% Convert to one-sided 
Gammayy = yy*2;



figure(4)
clf()
plot(w1,Gamma1)
hold on
plot(w2,Gamma2,'r.')
plot(ww,Gammayy,'k--','linewidth',2)
%plot(f3,pxx3,'g')
%plot(ff_pos,psd_onesided,'k--')
legend('Est. PSD, Sum Of Cosines','Est. PSD, FFT','Target One-Sided PSD')
grid on
ylabel ('\Gamma_{yy}(\omega) [units/(rad/s)')
title('One-Sided PSD')
xlabel('\omega [rad/s]')


figure(21)
clf()
plot(w1,Gamma1)
hold on
plot(w3,Gamma3,'r.')
plot(ww,Gammayy,'k--','linewidth',2)
%plot(f3,pxx3,'g')
%plot(ff_pos,psd_onesided,'k--')
legend('Est. PSD, Left','Est. PSD, Middle','Target One-Sided PSD')
grid on
ylabel ('\Gamma_{yy}(\omega) [units/(rad/s)')
title('One-Sided PSD')
xlabel('\omega [rad/s]')

%%
% figure(100)
% clf()
% plot(MM,timeratio,'-o')
% plot(MM,timeratio./MM,'-o')
