function [ output_args ] = qq1( a,num,qext,qsca,qbk,qpr,ra,rb )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
ra=(1:num)+i*(1:num),rb=(1:num)+i*(1:num);
b=2*a*a;
c=0,d=0;
s=0+i*0,r=0+i*0;
n=1;
for i=1:num-1
    n=n+2;
    r=r+(i+0.5)*(-1)^i*(ra(i)-rb(i));
    s=s+i*(i+2)/(i+1)*(ra(i)*conjg(ra(i+1))+rb(i)*conjg(rb(i+1)))+n/i/(i+1)*(ra(i)*conjg(rb(i)));
    c=c+n*(ra(i)+rb(i));
    d=d+n*(ra(i)*conjg(ra(i))+rb(i)*conjg(rb(i)));
    qext=b*c;
    qsca=b*d;
    qbk=2*b*r*conjg(r);
    qpr=qext-2*b*s;
    return
end
end

