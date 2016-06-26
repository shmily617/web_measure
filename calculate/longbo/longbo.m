function longbo(n_l)
f=figure('visible','off'); 

% 程序输入n_l表示层数，范围层数3以上都可以
%clear all
% dat=load('luneberg_10l.txt');
global  ri_n aa
%n_l=5;
dlam=1;
 delta = floor(100/n_l)/100;%每层厚度，向下取整
 if n_l<8
     r(1) = 0.1;
 else  r(1) = 0.05;
 end
 
 for n = 2:n_l
     r(n) = r(1)+(n-1)*delta;
 end
 result=2-r.^2;
 ri_n = sqrt(result);
 %
for ka=0.5:0.1:15   % 145个
    a=ka*dlam/(2*pi);
    aa = r*a;
%     for n=2:1+n_l
%     ri_n(n-1)=sqrt(dat(n));
%     aa(n-1)=dat(n+n_l)*a ;  %ka=1, k=2*pi, dlam=1
%     end

n_layers=n_l;nterms=20000;
global rrbb rrd1 rrd2 srbb srd1 srd2 rd11 rd3x rcx d1x rbb rd1 rd2
%aa=single(1:n_l);
%xx=single(1:n_layers);d1x=single(1:nterms);
ra=(1:n_l);rb=(1:n_l);
rd11=(1:nterms)+i*(1:nterms);
x=2*pi*aa(n_l);
ax=1.0/x;

for n = 1:n_l
    xx(n) = 2*pi*aa(n);
end
num = nm(x,n_l);%调用num  !!!!num应当是个整数
ari=abs(ri_n(1));
for n = 2:n_l
    ari1=abs(ri_n(n));
    if ari1 > ari
        ari=ari1;
    end
end
num2=nm(ari*x,n_l);  %调用num
if num2 > num
    num=num2;
end
    d1x=aax(ax,num) ;      %调用aax,cd3x
    [rd3x,rcx]=cd3x(x,num,d1x,rd3x,rcx);  %第三类贝塞尔函数替换
    rd11=aa1(ri_n(1)*xx(1),num);

for j=2:n_l
        [rd1,rd2,rbb,rcc]=bcd(ri_n(j)*xx(j-1),num,rd1,rd2,rbb);%调用bcd 第一类第二类贝塞尔函数%关于bcd中的rd1有疑惑
        for n=1:num
            rrbb(n,j)=rbb(n);%二维数组先行后列
            rrd1(n,j)=rd1(n);
            rrd2(n,j)=rd2(n);
        end
        %pause
       [rd1,rd2,rbb,rcc]=bcd(ri_n(j)*xx(j),num,rd1,rd2,rbb);%调用bcd  第一类第二类贝塞尔函数   
        for n=1:num
            srbb(n,j)=rbb(n);
              srd1(n,j)=rd1(n);
              srd2(n,j)=rd2(n);
        end
end
    [ra,rb]=abn1(n_l,ri_n,num-1) ;         %调用abn1,num1=num-1
pm=[];pd=[];%arcst=[];arcsp=[];angle=[];
%for n=1:179                       %改过n和下标
%n=179;
    atheta=179.99;
    aphi=0.00001;
    asint=sin(atheta);
    x=cos(atheta);
    [pm,pd]=lpmn(1,1,num,x,pm,pd);
   % pause
    ret=0;
    rep=0;
    for n1=1:num-1
        c=(2*n1+1)/(n1*n1+n1);%float可能出问题
        ret=ret+c*(-ra(n1)*pd(n1+1,2)*asint+(rb(n1)*pm(n1+1,2))/(asint));
     rep=rep+c*((ra(n1)*pm(n1+1,2))/(asint)-rb(n1)*pd(n1+1,2)*asint);
    end
   % arcs=10.*log10(abs(ret)^2/pi)                 %调用rcs
  % arcs=abs(ret)^2/pi
   arcs=((abs(cos(aphi)*ret)^2+abs(sin(aphi)*rep)^2)*dlam^2/pi); 
  
    rcs(floor(ka*10)-4)=arcs; 
end
n=1:146;
semilogy(n/10,rcs(n));
xlabel('ka')       
ylabel('RCS (m^2)')
result
print(f,'-dpng','/Users/liumengjie/Desktop/web_measurement-master/public/pic/longbo.png')

    
    %return
%  n=1:179;
%   plot(n,arcs,'g-') 
%  hold on;
%  plot(n,arcsp,'b:')

%  legend('RCS(theta-theta)','RCS(phi-phi)')
%  text(15,-10,'Weng Cho Chew book p.517')
%  text(15,2,'PEC r=0.5m')
% % text(15,38,'coat t1=t2==0.025m')
%   text(15,0,'fre=300MHz')
%  hold on
end
