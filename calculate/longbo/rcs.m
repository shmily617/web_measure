function arcs=rcs(a,num,ra,rb)
%计算雷达散射截面积
%   Detailed explanation goes here
%ra=(1:num)+i*(1:num);rb=(1:num)+i*(1:num); %!!!!!a没有用
%pm=zeros(num+1,2);pd=zeros(num+1,2);arcst=(1:69);arcsp=(1:69);angle=(1:69)
%a=ax
pm=[];pd=[];%arcst=[];arcsp=[];angle=[];
dlam=1;
%for n=1:179                       %改过n和下标
%n=179;
    atheta=0.00001;
    aphi=0.00001;
    asint=sin(atheta);
    x=cos(atheta);
    [pm,pd]=lpmn(1,1,num,x,pm,pd);
   % pause
    ret=0;
    rep=0;
    for n1=1:num-1
        c=(2*n1+1)/(n1*n1+n1)%float可能出问题
        ret=ret+c*(-ra(n1)*pd(n1+1,2)*asint+(rb(n1)*pm(n1+1,2))/(asint))
        %pause
        rep=rep+c*((ra(n1)*pm(n1+1,2)+eps)/(asint+eps)-rb(n1)*pd(n1+1,2)*asint)
        %pause 
    end
    %angle(70-n)=180-real(n)/10
%    angle(180-n)=180-n
 %    et=-exp(i)*i*cos(aphi)*ret;
  %  ep=-exp(i)*i*sin(aphi)*rep;
  %  es=abs(et).^2+abs(ep).^2
   % ei=abs(exp(i)).^2
%    arcs=10.*log10(abs(ret)^2/pi)
      arcs=10.*log10((abs(cos(aphi)*ret)^2+abs(sin(aphi)*rep)^2)/pi)
 %   st=10*log10(abs(ret)^2*dlam^2/pi+10^(-10))
 %   sp=10*log10(abs(rep)^2*dlam^2/pi+10^(-10))
 %   rcs=(4*pi/(2*pi)^2)*st^2
return

end

