function [ rd3x,rcx ]=cd3x( x,num,d1x,rd3x,rcx)
%求bessel对数导数zeta'(N)/zeta(N)和比值psi(N)/zata(N)
%   Detailed explanation goes here
%d1x=1:num;
%rd3x=(1:num)+i*(1:num);
%rcx=(1:num)+i*(1:num);
%rd3x=(1:num);rcx(1:num);
%原程序有疑惑，关于s1
s1=0+i;
ax=1.0/x;
rd30=s1;
rxy=cos(2.0*x)+s1*sin(2.0*x);
rc0=-(1.0-rxy)/(2.0*rxy);
rd3x(1)= -ax + 1d0 / (ax - rd30);
%pause
rcx(1)=rc0*(ax+rd3x(1))/(ax+d1x(1));
for n=2:num
   
        a1=n*ax;
    %pause
        rd3x(n)=-a1+1.0/(a1-rd3x(n-1));
        rcx(n)=rcx(n-1)*(a1+rd3x(n))/(a1+d1x(n));
    
    %pause   
end
return

end

