function zidingyi(n_l,aa,ri_nr, ri_ni)
f=figure('visible','off'); 
% 层数  n_l=1;
% 介电常数 ri_nr=0 ;ri_ni=0;
% 内层球半径  aa=36; %m
% global n_l fre ri_n aa
global rrbb rrd1 rrd2 srbb srd1 srd2 rd11 rd3x rcx d1x rbb rd1 rd2
if n_l ==1
n_l = n_l+2;
ri_nr(n_l) = 1.0000001;
ri_ni(n_l) = 0;
ri_nr(n_l-1) = 1.0000001;
ri_ni(n_l-1) = 0;
aa(n_l) = aa(1)+aa(1)/100;
aa(n_l-1)=aa(n_l);
end

if round(ri_nr) ~= 1
n_l = n_l+1;
ri_nr(n_l) = 1.0000001;
ri_ni(n_l) = 0;
aa(n_l) = 2*aa(n_l-1)-aa(n_l-2);
end
fre=300;%MHz
ri_n=sqrt(ri_nr+i*ri_ni);

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
    [ra,rb]=abn1(n_l,ri_n,num)  ;
    %[arcst,arcsp]=rcs(num-1,fre,ra,rb);     
     [arcst,arcsp]=rcs(num,fre,ra,rb)  ;
n=1:179
 plot(n,arcst,'g-') ;
 hold on
  plot(n,arcsp,'b--') ;
 xlabel('角度（degrees）')     ;  
 ylabel('RCS (dBsm)');
 legend('RCS(theta-theta)','RCS(phi-phi)')
 
 hold on
 arcst
 arcsp
 
print(f,'-dpng','/Users/liumengjie/Desktop/web_measurement-master/public/pic/zidingyi.png')

end
