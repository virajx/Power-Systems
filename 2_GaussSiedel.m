% GAUSS SIEDEL

clc
clear

% Data

tic
slb = 1;
pvb = 1;
pqb = 1;
nb = slb + pvb + pqb;

Y=[-1j*19.98 1j*10 1j*10;1j*10 -1j*19.98 1j*10;1j*10 1j*10 -1j*19.98]; 

y=abs(Y);

phi=angle(Y);
v(1)=1.0;
th(1)=0;
v(2)=1.05;
Psp (2)=0.6661;
Psp(3)=-2.8653;
Qsp (3)=-1.2244; 

% Initial guess for unknown theta and v &

th(2)=0;
v(3)=1.0;
th (3)=0;
m=180/pi;

% Program for Gauss Siedel algorithm %

err=1.0; 
t=0;

% t' is the number of iterations of the algorithm 

while err>1e-4
    for i=2:3
        Px(i)=0;
        Qx(i)=0;
        for k=1:3
            Px(i)= Px(i)+v(i)*v(k)*y(i,k) * cos(th(i)-th(k)-phi(i,k));
            Qx(i)= Qx(i)+v(i)*v(k)*y(i,k) * sin(th(i)-th(k)-phi(i,k));
        end
    end
    for i=1:3
        V(i)=v(i)*(cos(th(i))+1j*sin(th(i))); 
    end
    for i=2:3 
        vint(i)=0; 
        for k=1:3 
            if k~=i
                vint(i)= vint(i)+Y(i,k)*V(k);
            end
        end
    end
    for i=2:nb
        if i<=(slb+pvb)
            V(i)=((Psp(i)-1j*Qx(i))/conj(V(i))-vint(i))/Y(i,i);
        else
            V(i)=((Psp(i)-1j*Qsp(i))/conj(V(i))-vint(i))/Y(i,i);
    end
    end
    for i=2:nb
        if i<=(slb+pvb)
            th(i)=angle(V(i));
        else
            v(i)=abs(V(i));
            th(i)=angle(V(i));
        end
        delp=Psp-Px;
        delq=Qsp-Qx;
        delpqx=[delp'; delq'];
        err=abs(max(delpqx));
        t=t+1;
    end
end
[v' m*th']
timeElapsed = toc;

timeElapsed
