function [pm,pd]=lpmn( mm,m,n,x,pm,pd )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
pm=zeros(n+1,mm+1);pd=zeros(n+1,mm+1);
%double precision是什么？如何定义
for v=0:n       % 将i改写成v,数组下标都要加1,这里的n是num
    for j=0:m   %第一个for 全赋零
    %do 10的意思是do在某行结束
    pm(v+1,j+1)=0;
    pd(v+1,j+1)=0;
    end
end%源程序有疑惑
pm(1,1)=1;
%pause
        if abs(x)==1.0
            for v=1:n
                pm(v+1,1)=x^v;
                 pd(v+1,1)=0.5*v*(v+1.0)*x^(v+1);
            end
            for j=1:n
                    for v=1:m
                        if v == 1
                            pd(j+1,v+1)=1.0*10^3;%1.0D+300
                        else if v == 2
                                pd(j+1,v+1)=-0.25*(j+2)*(j+1)*j*(j-1)*x^(j+1);
                            end 
                        end
                        continue
                    end
            end
            return
        end
       % pause
ls=1;
if abs(x) > 1
    ls=-1;
end
    
    xq=sqrt(ls*(1-x.*x));
    xs=ls*(1-x.*x);
    for v=1:m
         pm(v+1,v+1)=-ls*((2*v)-1)*xq*pm(v,v);
    end
   % pause
    for v=0:m
        pm(v+2,v+1)=(2*v+1)*x*pm(v+1,v+1);
    end
    %pause
    for v=0:m            %  do  40
        for j=v+2:n
            pm(j+1,v+1)=((2*j-1)*x*pm(j,v+1)-(v+j-1)*pm(j-1,v+1))/(j-v) ;    
        continue
        end
    end   %end do 40
    pd(1,1)=0;
    for j=1:n
        pd(j+1,1)=ls*j*(pm(j,1)-x*pm(j+1,1))/xs;
    end
    for v=1:m
        for j=v:n
            pd(j+1,v+1)=ls*v*x*pm(j+1,v+1)/xs+(j+v)*(j-v+1)/xq*pm(j+1,v);
        continue
        end
    end   %  end do 50
    return
end

