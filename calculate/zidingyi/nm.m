function nm = nm( x ,n_l)
%AA1和BESSEL函数的辅助函数
%   Detailed explanation goes here

nm=single(1:n_l);
if x < 1
    nm=floor(7.5*x+9.0);
end
if x > 100
        nm=floor(1.0625*x+28.5);
end
if (1<x)&(x<100)
    nm=floor(1.25*x+15.5);
end
return 
end




