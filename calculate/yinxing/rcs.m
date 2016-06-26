function [arcst,arcsp]=rcs(num,fre,ra,rb)
%计算雷达散射截面积
%   Detailed explanation goes here
%ra=(1:num)+i*(1:num);rb=(1:num)+i*(1:num); %!!!!!a没有用
%pm=zeros(num+1,2);pd=zeros(num+1,2);arcst=(1:69);arcsp=(1:69);angle=(1:69)
%a=ax;
pm=[];pd=[];arcst=[];arcsp=[];angle=[];
dlam=299.792458/fre;
for n=1:179                      
    atheta=n*pi/180;
    asint=sin(atheta);
    x=cos(atheta);
    [pm,pd]=lpmn(1,1,num,x,pm,pd);
    ret=0+i*0     ;      % E-THETA
    rep=0+i*0    ;       %E_phi
    for n1=1:num-1
        c=(2*n1+1)/(n1*n1+n1);
        ret=ret+c*(-ra(n1)*pd(n1+1,2)*asint+rb(n1)*pm(n1+1,2)/asint);
        %pause
        rep=rep+c*(ra(n1)*pm(n1+1,2)/asint-rb(n1)*pd(n1+1,2)*asint);
        %pause 
    end
    %angle(70-n)=180-real(n)/10
    angle(180-n)=180-n;
    arcst(180-n)=10*log10(abs(ret)^2*dlam^2/pi+10^(-10));
    arcsp(180-n)=10*log10(abs(rep)^2*dlam^2/pi+10^(-10));
end
return

end

