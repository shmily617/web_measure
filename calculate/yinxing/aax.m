function d1x=aax(a,num)

d1x=(1:num);
num0=num+15;
ru0(num0)=(num0+1)*a-1.0/(num0+1)/a;
num01=num0-1;

for j=1:num01
    n=num0-j  ;
    n1=n+1;
    s1=n1*a;
    ru0(n)=s1-1.0/(ru0(n1)+s1);
end
for n=1:num
       d1x(n)=ru0(n);
end
return
end

