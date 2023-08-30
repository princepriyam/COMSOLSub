function [Y1m, Y2m] = FFT_fxfy_mod(fx_stored,fy_stored,del_t)
% --------------------------- FFT_fxfy_mod ------------------------

NFFT = 2048; 

count = size(fx_stored, 1);
ss    = count-(NFFT-1)    ;

Fs = 1/del_t;

y1 = fx_stored( ss:end, 1);
y2 = fy_stored( ss:end, 1);


Y1 = fft(y1,NFFT)/NFFT;
Y2 = fft(y2,NFFT)/NFFT;

f = Fs/2*linspace(0,1,NFFT/2+1);

Y1m = Y1 ;
Y1m(2:end) = 2*Y1m(2:end) ;

Y2m = Y2 ;
Y2m(2:end) = 2*Y2m(2:end) ;

% Plot single-sided amplitude spectrum.
figure( 1 )
semilogy(f, abs(Y1m(1:NFFT/2+1))) 
title('Single-Sided Amplitude Spectrum of fx')
xlabel('Frequency (Hz)')
ylabel('fx')

figure( 2 )
semilogy(f, abs(Y2m(1:NFFT/2+1)))
title('Single-Sided Amplitude Spectrum of fy')
xlabel('Frequency (Hz)')
ylabel('fy')

end