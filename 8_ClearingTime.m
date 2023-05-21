clc
clear

p = 0.9;
q = 0.436;
et = 1;
pm = p;

xddash = 0.
xt = 0.15;
xl1 = 0.5;
xl2 = 0.93;
xleq = (xl1*xl2)/(xl1+xl2);

alpha = 160*pi/180;
i1 = (p-1j*q)/conj(et);
eb = et-1j*(xt+xleq)*i1;
edash = et+1j*xddash*i1;
del0 = angle(edash)-angle(eb);

xlbf = xleq+xt+xddash;
xldf = xt+xddash;
xlaf = xl1+xt+xddash;

% Tc is here %
tc = 0.2;
t0 = 1;
tfinal = 5;
delt = 0.001;

n0 = t0/delt;
arr1 = linspace(t0,t0+tc,100);
n1 = length(arr1);
delt1 = tc/100;

arr2 = linspace(t0+tc, tfinal,10000);
n2 = length(arr2);
delt2 = (tfinal-t0-tc)/10000;

del1(1) = del0;
delw1(1) = 0;
H = 3.5;

for i = 1:n1-1  
    del1(i+1) = del1(i)+377*delw1(i)*delt1;
    delw1(i+1) = delw1(i)+(pm/(2*H))*delt1;
    %during fault from t0 to t0+tc, pe = 0   
end

del2(1) = del1(end);
delw2(1) = delw1(end);

for i = 1:n2-1
    del2(i+1) = del2(i)+377*delw2(i)*delt2;
    peaf = abs(edash)*abs(eb)*sin(del2(i+1))/xlaf;
    delw2(i+1) = delw2(i)+((pm-peaf)/(2*H))*delt2; 
    %during fault from t0+tc to t0+tc+5, pe+0
end

delin = del0*ones(1,n0);
del = [delin del1 del2]* 180/pi;
t1 = (0:n0-1)*delt;
t2 = t1(end)+(0:n1-1)*delt1;
t3 = t2(end)+(0:n2- 1)*delt2;
t = [t1 t2 t3];
plot(t,del),grid



