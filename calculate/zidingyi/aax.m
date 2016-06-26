function d1x=aax(a,num)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%ru=(1:num)+i*(1:num);
%ru0=(1:num+15)+i*(1:num+15);
%a=ax;
num0=num+15;
    ru0(num0)=2.5512691274840495 ;%(num0+1)*a-1/(num0+1)/a
    ru0(num0-1)= 2.6584953240862559;
    num01=num0-1;
    for j=1:num01
      i=num0-j;
      i1=i+1;
      s1=i1*a;
      ru0(i)=s1-1.0/(ru0(i1)+s1);
    end

    for i=1:num
      d1x(i)=ru0(i);
    end
return
end

