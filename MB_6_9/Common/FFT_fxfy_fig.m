function iofxy = FFT_fxfy_fig(fx_stored,fy_stored,fxy_stored,del_t)

figure(7)
%y  = If6_stored(2,:);

count = size(fx_stored, 2);
% ss = count-2047;
% ss = count-1023;
ss = 1;

Fs = 1/del_t;
% T=1/Fs;
y1 = fx_stored(ss:end,  1);
y2 = fy_stored(ss:end,  1);
y3 = fxy_stored(ss:end, 1);

% y3  = sqrt(y1.*y1 + y2.*y2);
L = length(y1);
 

NFFT = 2^(nextpow2(L)); % Next power of 2 from length of y

Y1 = fft(y1,NFFT)/L;
% Y1=Y1.*Y1;
Y2 = fft(y2,NFFT)/L;
% Y2 = Y2.*Y2;
Y3 = fft(y3,NFFT)/L;
% Y3 = Y3.*Y3;

f = Fs/2*linspace(0,1,NFFT/2+1);

% Plot single-sided amplitude spectrum.
figure(27)

semilogy(f,2*abs(Y1(1:NFFT/2+1))) 
title('Single-Sided Amplitude Spectrum of fx')
xlabel('Frequency (Hz)')
ylabel('fx')

figure(28)

semilogy(f,2*abs(Y2(1:NFFT/2+1)))
title('Single-Sided Amplitude Spectrum of fy')
xlabel('Frequency (Hz)')
ylabel('fy')


% subplot(3,1,3)
figure(29)

semilogy(f,2*abs(Y3(1:NFFT/2+1)))
title('Single-Sided Amplitude Spectrum of f')
xlabel('Frequency (Hz)')
ylabel('f')

iofxy = 0;