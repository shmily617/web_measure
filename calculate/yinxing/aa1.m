function rd1 = aa1(rx,num )
%y���ڼ����ֵJ'(N)/J(N),��������
%   Detailed explanation goes here
rd1=(1:num);
s=1.0/rx;
num0=num+15;
ru0(num0)=(num0+1)*s-1.0/(num0+1)/s;
num01=num0-1;
for j=1:num01
    n=num0-j;%��i�ĳ�n
    n1=n+1;
    s1=n1*s;
    ru0(n)=s1-1.0/(ru0(n1)+s1);
end
for n=1:num
    rd1(n)=ru0(n);
end
return
end

