function [ra,rb]=abn1(n_l,ri_n,num)
%计算系数A(N),B(N)
%   Detailed explanation goes here
%n_layers=100;nterms=20000;
%global rrbb rrd1 rrd2 srbb srd1 srd2 rd11 rd3x rcx d1x  %关于全局变量是不是不用重新定义
%d1x=single(1:nterms);
%ra=(1:nterms)+i*(1:nterms);rb=(1:nterms)+i*(1:nterms);
%ri_n=(1:n_l)+i*(1:n_l);
%rcx=(1:nterms)+i*(1:nterms);
%rd11=(1:nterms)+i*(1:nterms);rd3x=(1:nterms)+i*(1:nterms);
%rrbb=ones(n_layers,nterms)+i*ones(n_layers,nterms);rrd1=ones(n_layers,nterms)+i*ones(n_layers,nterms);rrd2=ones(n_layers,nterms)+i*ones(n_layers,nterms);
%srbb=ones(n_layers,nterms)+i*ones(n_layers,nterms);srd1=ones(n_layers,nterms)+i*ones(n_layers,nterms);srd2=ones(n_layers,nterms)+i*ones(n_layers,nterms);
global rrbb rrd1 rrd2 srbb srd1 srd2 rd11 rd3x rcx d1x rbb rd1 rd2
sa=(1:n_l);sha=(1:n_l);
sb=(1:n_l);shb=(1:n_l);

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
%end
%return
    
        
end
end

