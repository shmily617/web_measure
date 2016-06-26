function [ra,rb]=abn1(n_l,ri_n,num)
%计算系数A(N),B(N)
global rrbb rrd1 rrd2 srbb srd1 srd2 rd11 rd3x rcx d1x rbb rd1 rd2 
ra=[];rb=[];
if ri_n(1)==0 %金属球
for n=1:num     
    sa(1)=0;
    sha(1)=0;
    sb(1)=0;
    shb(1)=0;
 for j=2:n_l
        if(j==2) 
          sa(j)=rrbb(n,j)*rrd1(n,j)/rrd2(n,j);
          sb(j)=rrbb(n,j);
        else
          if(abs(ri_n(j)*sha(j-1)-ri_n(j-1)*rrd2(n,j))==0) 
            sa(j)=rrbb(n,j)*(ri_n(j)*sha(j-1)-ri_n(j-1)*rrd1(n,j))/(ri_n(j)*sha(j-1)-ri_n(j-1)*rrd2(n,j)+10^(-50));
          else
            sa(j)=rrbb(n,j)*(ri_n(j)*sha(j-1)-ri_n(j-1)*rrd1(n,j))/(ri_n(j)*sha(j-1)-ri_n(j-1)*rrd2(n,j));
          end
          if(abs(ri_n(j)*shb(j-1)-ri_n(j-1)*rrd2(n,j))==0) 
            sb(j)=rrbb(n,j)*(ri_n(j-1)*shb(j-1)-ri_n(j)*rrd1(n,j))/(ri_n(j-1)*shb(j-1)-ri_n(j)*rrd2(n,j)+10^(-50));
          else
            sb(j)=rrbb(n,j)*(ri_n(j-1)*shb(j-1)-ri_n(j)*rrd1(n,j))/(ri_n(j-1)*shb(j-1)-ri_n(j)*rrd2(n,j));
          end
        end
        if(abs(srbb(n,j)-sa(j))==0)
          sha(j)=srbb(n,j)*srd1(n,j)/(srbb(n,j)-sa(j))-sa(j)*srd2(n,j)/(srbb(n,j)-sa(j)+10^(-50));
        else
          sha(j)=srbb(n,j)*srd1(n,j)/(srbb(n,j)-sa(j)) -sa(j)*srd2(n,j)/(srbb(n,j)-sa(j));
        end
        if(abs(srbb(n,j)-sb(j))==0) 
		         shb(j)=srbb(n,j)*srd1(n,j)/(srbb(n,j)-sb(j))-sb(j)*srd2(n,j)/(srbb(n,j)-sb(j)+10^(-50));
        else
          shb(j)=srbb(n,j)*srd1(n,j)/(srbb(n,j)-sb(j))-sb(j)*srd2(n,j)/(srbb(n,j)-sb(j));
        end
 end

ra(n)=rcx(n)*(sha(n_l)-ri_n(n_l)*d1x(n))/(sha(n_l)-ri_n(n_l)*rd3x(n));
rb(n)=rcx(n)*(shb(n_l)*ri_n(n_l)-d1x(n))/(shb(n_l)*ri_n(n_l)-rd3x(n));
%关于1D-40的问题
 if abs(ra(n))+abs(rb(n)) <= 1.0*10^(-40)
     num1=n;
 end
%end
%return           
end

else  %介质球
for n=1:num     %源程序有疑惑  %i改成n ,行列调换顺序
    sa(1)=0;
    sha(1)=rd11(n);
    sb(1)=0;
    shb(1)=rd11(n);
    for j = 2:n_l
       if(abs(ri_n(j)*sha(j-1)-ri_n(j-1)*rrd2(n,j))==0) 
        sa(j) = rrbb(n,j) * (ri_n(j) * sha(j-1) - ri_n(j-1) * rrd1(n,j)) / (ri_n(j) * sha(j-1) - ri_n(j-1) * rrd2(n,j) +10^(-30));
        else
        sa(j) = rrbb(n,j) * (ri_n(j) * sha(j-1) - ri_n(j-1) * rrd1(n,j)) / (ri_n(j) * sha(j-1) - ri_n(j-1) * rrd2(n,j));
        end 
		
        if(abs(ri_n(j)*shb(j-1)-ri_n(j-1)*rrd2(n,j))==0) 
        sb(j) = rrbb(n,j) * (ri_n(j-1) * shb(j-1) - ri_n(j) * rrd1(n,j)) / (ri_n(j-1) * shb(j-1) - ri_n(j) * rrd2(n,j) + 10^(-30));
        else
        sb(j) = rrbb(n,j) * (ri_n(j-1) * shb(j-1) - ri_n(j) * rrd1(n,j)) / (ri_n(j-1) * shb(j-1) - ri_n(j) * rrd2(n,j));
        end 

        if(abs(srbb(n,j) - sa(j))==0) 
         sha(j) = srbb(n,j) * srd1(n,j) / (srbb(n,j) - sa(j))- sa(j) * srd2(n,j) / (srbb(n,j) - sa(j) +10^(-30));
         else
         sha(j) = srbb(n,j) * srd1(n,j) / (srbb(n,j) - sa(j)) - sa(j) * srd2(n,j) / (srbb(n,j) - sa(j));
        end 
	

        if(abs(srbb(n,j) - sb(j))==0) 
         shb(j) = srbb(n,j) * srd1(n,j) / (srbb(n,j) - sb(j))- sb(j) * srd2(n,j) / (srbb(n,j) - sb(j) + 10^(-30));
         else
         shb(j) = srbb(n,j) * srd1(n,j) / (srbb(n,j) - sb(j)) - sb(j) * srd2(n,j) / (srbb(n,j) - sb(j));
        end 


       end 

ra(n)=rcx(n)*(sha(n_l)-ri_n(n_l)*d1x(n))/(sha(n_l)-ri_n(n_l)*rd3x(n));
rb(n)=rcx(n)*(shb(n_l)*ri_n(n_l)-d1x(n))/(shb(n_l)*ri_n(n_l)-rd3x(n));

%关于1D-40的问题
if abs(ra(n))+abs(rb(n)) <= 1.0*10^(-40)
    num1=n;
end     
end
end
end
