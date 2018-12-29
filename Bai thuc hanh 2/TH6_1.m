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
%subplot(5,1,2)
%plot(t,s,'r-+');


Ac = 3;		% biên d? 
fc = 2000;		% t?n s? (Hz)
phi = 0;       % pha
s = (Ac + s).*sin(2*pi*fc*t + phi);
An = 2;					% noise amplitude
%s = s + An*randn(size(t));    
s = awgn(s,snr,'measured');   
subplot(2,1,1);
plot(t,s);