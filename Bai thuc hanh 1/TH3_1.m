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
A = 1;		
f = 100;		
phi = 0;       
s = A*s.*sin(2*pi*f*t - phi);
subplot(2,1,1)
plot(t,s,'r-+');