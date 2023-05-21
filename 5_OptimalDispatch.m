// Optimal Dispatch

clear all
clc

a=[0.003124 0 0 -1;0 .00388 0 -1;0 0 .00964 -1;1 1 1 01];

pd=850; 
% pd stands for total demand

b=[-7.92;-7.85;-7.97;pd];

x=inv(a)*b;

lam=x(end); 
% lam stands for lambda

err=100;
t=0;

while err>=1.75
    
    a1=[0.003124+0.00006*lam 0 0;0 0.00388+0.00018*lam 0;0 0 0.00964+0.00024*lam];

    b1=[lam-7.92;lam-7.85;lam-7.97];

    pg=inv(a1)*b1;

    ploss=0.00003*(pg(1)^2)+0.00009*(pg(2)^2)+0.00012*(pg(3)^2);

    if sum (pg)-ploss-pd>=0
        lam=lam-0.01;
    else
        lam=lam+0.01;
    end
    
    err=abs(sum(pg)-ploss-pd);
    
end
pg
