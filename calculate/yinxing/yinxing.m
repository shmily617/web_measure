function yinxing(choose)
f=figure('visible','off'); 
%  choose = 2;
% Ì¼ÄÉÃ× choose == 1
% ri£º ½éµç³£Êý[0,27] [0,12.3]
% aa£º ÄÚ²ãÇò°ë¾¶ [3,3.000000001]
% Í­±¡Ä¤ choose == 2
% ri£º ½éµç³£Êý[0,1.21206] [0,3.46553]
% aa£º ÄÚ²ãÇò°ë¾¶ [3,3.0005]
% clear all
%  dat=load('yinxing.txt')
% PARAMENTS
global ri_n rrbb rrd1 rrd2 srbb srd1 srd2 rd11 rd3x rcx d1x rbb rd1 rd2
 n_l=3;fre=300;
 if choose == 1 
 ri_n=[0,sqrt(27+1i*12.3),sqrt(1.0000001)];
 aa = [3,3.0005,3.001];
 else if choose == 2
     ri_n=[0,sqrt(1.21206+1i*3.46553),sqrt(1.0000001)];
     aa = [3,3.000000001,3.000000002];
     end
 end
% %aa=(1:n_l);
% for n=2:2:2*n_l
%     ri_nr(n/2)=dat(n);
%     ri_ni(n/2)=dat(n+1);
%     ri_n(n/2)=sqrt(ri_nr(n/2)+i*ri_ni(n/2));
% end
%  for n=(n_l+1)*2:n_l*3+1
%      aa(n-1-2*n_l)=dat(n);
%  end
n_layers=n_l;nterms=20000;

ra=(1:n_l);rb=(1:n_l);
rd11=(1:nterms)+i*(1:nterms);
x=2*pi*aa(n_l);
ax=1.0/x;

for n = 1:n_l
    xx(n) = 2*pi*aa(n);
end
num = nm(x,n_l);
ari=abs(ri_n(1));
for n = 2:n_l
    ari1=abs(ri_n(n));
%   pause
    if ari1 > ari
        ari=ari1;
    end
end
num2=nm(ari*x,n_l); 

if num2 > num
    num=num2;
end
    d1x=aax(ax,num) ;
    [rd3x,rcx]=cd3x(x,num,d1x,rcx);

for j=2:n_l
        [rd1,rd2,rbb,rcc]=bcd(ri_n(j)*xx(j-1),num2,rd1,rd2,rbb);
        for n=1:num
            rrbb(n,j)=rbb(n);
            rrd1(n,j)=rd1(n);
            rrd2(n,j)=rd2(n);
        end
        %pause
       [rd1,rd2,rbb,rcc]=bcd(ri_n(j)*xx(j),num,rd1,rd2,rbb);
        for n=1:num
            srbb(n,j)=rbb(n);
              srd1(n,j)=rd1(n);
              srd2(n,j)=rd2(n);
        end
end
    [ra,rb]=abn1_yx(n_l,ri_n,num,num-1,ra,rb)  ;
    [arcst,arcsp]=rcs(num-1,fre,ra,rb);        
n=1:179
 plot(n,arcst,'g-') ;
 hold on
  plot(n,arcsp,'b--') ;
 xlabel('½Ç¶È£¨degrees£©')     ;  
 ylabel('RCS (dBsm)');
 legend('theta-theta','phi-phi')
 %text(15,33,'PEC r=3m');
 %text(15,30,'fre=300MHz');
 hold on
 arcst
 arcsp
 print(f,'-dpng','/Users/liumengjie/Desktop/web_measurement-master/public/pic/yinxing.png')


end
