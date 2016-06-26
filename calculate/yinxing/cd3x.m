function [ rd3x,rcx ]=cd3x( x,num,d1x,rcx)
%��bessel��������zeta'(N)/zeta(N)�ͱ�ֵpsi(N)/zata(N)
%   Detailed explanation goes here

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

