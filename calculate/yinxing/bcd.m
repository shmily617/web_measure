function [rd1,rd2,rbb,rcc]=bcd(rx,num,rd1,rd2,rbb )
%计算贝塞尔对数导数psi'（N）/psi(N),khi'(N)/khi(N),以及比值psi/khi
%   Detailed explanation goes here
rd3=(1:num);rcc=(1:num);

s1=0+i*1.0;
x=real(rx);
y=imag(rx);
rx1=1.0/rx;        
rd1=aa1(rx,num) ;
rd30=s1;
rxy=(cos(2.0*x)+s1*sin(2.0*x))*exp(-2.0*y);
rc0=-(1.0-rxy)/(2.0*rxy);
rb0=s1*(1.0-rxy)/(1.0+rxy);
rd3(1)=-rx1+1.0/(rx1-rd30);
rcc(1)=rc0*(rx1+rd3(1))/(rx1+rd1(1));
rd2(1)=(rcc(1)*rd1(1)-rd3(1))/(rcc(1)-1.0);
rbb(1)=rb0*(rx1+rd2(1))/(rx1+rd1(1));

for n=2:num
    r1=n*rx1;
    rd3(n)=-r1+1.0/(r1-rd3(n-1));
    rcc(n)=rcc(n-1)*(r1+rd3(n))/(r1+rd1(n));
    rd2(n)=(rcc(n)*rd1(n)-rd3(n))/(rcc(n)-1.0);
    rbb(n)=rbb(n-1) * (r1 + rd2(n)) / (r1 + rd1(n));
end
return
end

