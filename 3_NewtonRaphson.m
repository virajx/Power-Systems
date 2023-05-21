// Newton Raphson

clc
clear

% Data

tic
slb = 1;
pvb = 1;
pqb = 1;
nb = slb + pvb + pqb;

Y = [-1j*19.98 1j*10 1j*10; 1j*10 -1j*19.98 1j*10; 1j*10 1j*10 -1j*19.98];
y = abs(Y);
phi = angle(Y);

v(1) = 1.0;
th(1) = 0;
v(2) = 1.05;

Psp(2) = 0.6661;
Psp(3) = -2.8653;
Qsp(3) = -1.2244;

%Initial values  for unknown theta and v
th(2) = 0;
v(3) = 1.0;
th(3) = 0;


cc = 180/pi;
THV = [0;0;1];
err = 1.0;
t = 0; % No. of iterations

while err>1e-4
    for i= (slb+1) :nb
        Px(i)=0;
        Qx(i)=0;
        for k=1:3
            Px(i) = Px(i)+v(i) *v(k) *y(i,k) *cos(th(i) -th(k)- phi (i,k));
            Qx(i) = Qx(i)+v(i) *v(k)*y(i,k) *sin(th(i) -th(k)- phi (i,k)) ;
        end
    end

% Jacobian Matrix
    % P-theta Jacobian
    JPth(1,1)=-Qx(2)-(((v(2))^2)*abs(Y(2,2))*sin(angle(Y(2,2))));
    JPth(1,2)=v(2)*v(3)*abs(Y (2,3)) *sin (th(2)-th(3)-(angle(Y(2,3))));
    JPth(2,1)=v(3)*v (2)*abs(Y(3,2)) *sin (th(3) -th(2)-(angle(Y(3,2))));
    JPth(2,2)=-Qx(3)-(((v(3))^2)*abs(Y(3,3))*sin (angle(Y(3,3))));
    
    % P-v Jacobian
    JPv(1,1)=v(2) *abs(Y (2,3))*cos (th(2)-th(3)-(angle(Y(2,3))));
    JPv(2,1)=(Px(3)/v(3))+(v(3)*abs(Y(3,3))*cos(angle(Y(3,3))));
    
    % Q-theta Jacobian
    JQth(1,1)=-v(3)*v(2)*abs(Y(3,2))*cos(th(3)-th(2)-(angle(Y(3,2))));
    JQth(1,2)=Px(3)-(((v(3))^2)*abs(Y(3,3))*cos(angle(Y(3,3))));
    
    % Q-v Jacobian
    JQv(1,1)=(Qx(3)/v(3))-(v(3)*abs(Y(3,3))*sin(angle(Y(3,3))));

    
    J=[JQth JQv; JPth JPv];
    
    for p=1:pqb
        delq(p)=Qsp(p+slb+pvb)-Qx(p+slb+pvb);
    end
    
    for p=1:(pvb+pqb)
        delp(p)=Psp(p+slb)-Px(p+slb);
    end
    
    delPQ = [delq';delp'];
    delthv = THV+(inv(J)*delPQ);
    
    for p=(slb+1):nb
        th(p)=delthv(p-1);
    end
    
    for p=(slb+pvb+1):nb
        v(p)=delthv(p+pqb-slb);
    end

    THV=delthv;
    err=max(abs(delPQ));
    t = t+1;
end

[v' cc*th']
timeElapsed = toc

