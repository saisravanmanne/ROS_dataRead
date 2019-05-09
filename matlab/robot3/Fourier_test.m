clc
close all 
clear all 
% this code was working 
 load('prbs.mat')
 Fs=105
 Ts=1/Fs
 %x=0:Ts:1
 x = prbs.t
 L=size(x)
 L=L(1)
 f=(Fs/L)*(0:(L/2))
 fo=100
 %y=10*sin(2*pi*fo*x + pi) + 10*sin(2*pi*10*fo*x)
 y = prbs.u
 Y=fft(y)
 P2 = abs(Y/L);
 P1 = P2(1:L/2+1);
 P1(2:end-1) = 2*P1(2:end-1);
P4 = angle(Y/L);
P3 = P4(1:L/2+1);
% stem(f,P1)
% plot(f,P1,'-o')
subplot(2,1,1); 
plot(2*pi*f,P1,'r')
xlabel('Frequency(rad/sec)')
ylabel('Amplitude')
title('Frequency Domain Plot of the Actual Data')
subplot(2,1,2); 
plot(2*pi*f,P3,'g')
xlabel('Frequency(rad/sec)')
ylabel('Phase(rad)')
grid on


