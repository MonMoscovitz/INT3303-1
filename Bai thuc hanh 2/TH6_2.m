clear
bitNum = 100;      % S? bit sinh ra 
Tsim = 0.01*bitNum;         % Kho?ng th?i gian mô ph?ng
snr = -5;           % Signal to noise ratio
ts = 0.00001;     % kho?ng th?i gian l?y m?u (s)
t = 0:ts:Tsim-ts; % th?i gian l?y m?u
L = numel(t);     % S? m?u  
spb = L/bitNum;   % S? m?u trên 1 bit
tpb = Tsim/bitNum; % Th?i gian 1 bit 
Fs = 1/ts;
NFFT=2^nextpow2(L);
s = [];
d = randi(2,1,bitNum) - 1

for i=1:L
  id = idivide(i,L/bitNum)+1;
  if id <=bitNum
    s(i) = d(id);
  else
    s(i) = d(bitNum);
  end
end
%figure(1);
%subplot(5,1,1)
%plot(t,s);
Y = fft(s,NFFT)/L;
f = Fs/2*linspace(0,1,NFFT/2+1);
% Plot single-sided amplitude spectrum.
figure(2);
plot(f,2*abs(Y(1:NFFT/2+1))) 
title('Single-Sided Amplitude Spectrum of y(t)')
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')

A = 1;		% biên d? sóng co s? 
f1 = 100;		% t?n s? f1 (Hz)
f2 = 200;   % t?n s? f2 (Hz)
phi = 0;       % pha
for i=1:L
  if s(i) == 1
    s(i) = A*sin(2*pi*f1*t(i) );
  else
    s(i) = A*sin(2*pi*f2*t(i) );
  end
end
subplot(5,1,2)
plot(t,s,'r-+');