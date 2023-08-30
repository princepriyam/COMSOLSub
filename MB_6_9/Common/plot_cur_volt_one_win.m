function iok = plot_cur_volt_one_win(time_stored,If6_stored,Uf6_stored,del_t)

figure(11)
clf
subplot(3,2,3)
plot(time_stored,If6_stored(1,:),'r')
hold on;
plot(time_stored,If6_stored(3,:),'b')
plot(time_stored,If6_stored(5,:),'g')
% Ifp_sum = If6_stored(1,:) + If6_stored(3,:) + If6_stored(5,:);
% plot(time_stored,Ifp_sum,'y')
xlabel('Time in sec');
ylabel('Phase Supply Current in Amps');
legend('PhaseA','PhaseB','PhaseC')
hold off


subplot(3,2,5)
plot(time_stored,If6_stored(2,:),'r')
hold on;
plot(time_stored,If6_stored(4,:),'b')
plot(time_stored,If6_stored(6,:),'g')
% Ifl_sum = If6_stored(2,:) + If6_stored(4,:) + If6_stored(6,:);
% plot(time_stored,Ifl_sum,'y')
xlabel('Time in sec');
ylabel('Equalizing Current or Levitation Current in Amps');
legend('phaseA','phaseB','phaseC')
hold off

subplot(3,2,1)
plot(time_stored,Uf6_stored(1,:),'r')
hold on;
plot(time_stored,Uf6_stored(3,:),'b')
plot(time_stored,Uf6_stored(5,:),'g')
% Ufp_sum = Uf6_stored(1,:) + Uf6_stored(3,:) + Uf6_stored(5,:);
% plot(time_stored,Ufp_sum,'y')
xlabel('Time in sec');
ylabel('Phase Supply Voltage in Volts');
legend('phaseA','phaseB','phaseC')
hold off    
    
%******************************** FFT *******************************

count = size(If6_stored,2);
ss = count- 1024;

Fs = 1/del_t;

u   = Uf6_stored(1,ss:end);
y1  = If6_stored(1,ss:end);

y4  = If6_stored(2,ss:end);

L = length(y1);
 

NFFT = 2^(nextpow2(L)); % Next power of 2 from length of y

U = fft(u,NFFT)/L;
Y1 = fft(y1,NFFT)/L;


Y4 = fft(y4,NFFT)/L;


f = Fs/2*linspace(0,1,NFFT/2+1);

% Plot single-sided amplitude spectrum.
subplot(3,2,2)
plot(f,2*abs(U(1:NFFT/2+1)),'r') 
title('Single-Sided Amplitude Spectrum of Supply Voltage PhaseA')
xlabel('Frequency (Hz)')
ylabel('Supply Voltage PhaseA')


subplot(3,2,4)
plot(f,2*abs(Y1(1:NFFT/2+1)),'r') 
title('Single-Sided Amplitude Spectrum of Supply Current PhaseA')
xlabel('Frequency (Hz)')
ylabel('Supply Current PhaseA')

% IePA  = 2*abs(Y4(1:NFFT/2+1));
% IePA  = IePA(:,1:100);
% f     = f(:,1:100);

subplot(3,2,6)
plot(f,2*abs(Y4(1:NFFT/2+1)),'r')
title('Single-Sided Amplitude Spectrum of Equilizing Current PhaseA')
xlabel('Frequency (Hz)')
ylabel('Equilizing Current PhaseA')


iok = 0;