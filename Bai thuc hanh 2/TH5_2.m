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
%s = awgn(s,snr,'measured'); 
%subplot(2,1,2);
%plot(t,s);

s = Ac*s.*sin(2*pi*fc*t + phi);

% low pass filter
cutoff=400; 				% cutoff frequency
[a b]=butter(1,cutoff/Fs); % Fs: sampling frequency 
% filtering
sd =filtfilt(a,b,s); 
sd = 2*sd/Ac - Ac;
subplot(2,1,1)
plot(t,sd);
rB = [];
for i=1:bitNum
    rs = sd(((i-1)*spb+1):(i*spb));
    ts  = t(((i-1)*spb+1):(i*spb));
    rE=trapz(ts,abs(rs))*pi*f/2;
      if rE > 0.5 
        rB(i) = 1;
      else
        rB(i) = 0;
      end
end
rB;
symerr(d,rB)
for i=1:L
  id = ceil(i/spb);
  r(i) = rB(id);
end
figure(1);
subplot(2,1,2);
plot(t,r);