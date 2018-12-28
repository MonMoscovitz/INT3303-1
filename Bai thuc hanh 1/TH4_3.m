clear;
Tsim = 1;         
bitNum = 10;      
ts = 0.00001;     
t = 0:ts:Tsim-ts;  
L = numel(t);      
spb = L/bitNum;   
tpb = Tsim/bitNum; 
Fs = 1/ts;           
snr = 0.001;           
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
%subplot(5,1,1);
%plot(t,s);

Ac = 3;		
fc = 1000;		
phi = 0;       
s = (Ac + s).*sin(2*pi*fc*t + phi);
An = 2;					
s = s + An*randn(size(t));    
s = awgn(s,snr,'measured'); 
subplot(2,1,2);
plot(t,s);

Y = fft(s,NFFT)/L;
f = Fs/2*linspace(0,1,NFFT/2+1);
% Plot single-sided amplitude spectrum.
figure(2);
plot(f,2*abs(Y(1:NFFT/2+1))) 
title('Single-Sided Amplitude Spectrum of y(t)')
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')	

