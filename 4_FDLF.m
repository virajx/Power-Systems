// Fast-decoupled Load Flow

clc
clear

% Data

tic

slb = 1;
pvb = 1;
pqb = 1; 
nb = slb + pvb + pqb;

Y = [-1j*19.98 1j*10 1j*10; 1j*10 -1j*19.98 1j*10; 1j*10 1j*10 -1j*19.98];
y = abs (Y);
phi = angle (Y);

B = imag(Y);
v(1) = 1.0;
th(1) = 0;
v(2) = 1.05;
Psp(2) = 0.6661;
Psp(3) = -2.8653;
Qsp(3) = -1.2244;

% Initial guess for unknown theta and v 

th(2) = 0;
v(3) = 1.0;
th(3) = 0;
cc = 180/pi;
TH = [0;0];
V = 1;

% Jacobian for P-theta %

Jpth_old = -B(slb+1:end, slb+1:end);

% inverse of matrix precalculated and stored before iteration loop starts %
% Jacobian for Q-v %
Jpth = inv(Jpth_old);

Jqv_old = -B(slb+pvb+1:end,slb+pvb+1:end); 

% inverse of matrix precalculated and stored before iteration loop starts %
% Program for Newton-Raphson algorithm %
Jqv = inv(Jqv_old);


err = 1.0;
t = 0; 
% t' is number of iterations of the algorithm

while err>1e-4
    for i = (slb+1):nb
        Px(i) = 0;
        for k = 1:nb
            Px(i) = Px(i) + v(i)*v(k)*y(i,k)*cos(th(i)-th(k)-phi(i,k)); 
        end
    end

    % P-theta loop
    for p = 1:(pvb+pqb)
        delp(p) = (Psp(p+slb) - Px(p+slb))/v(p+slb);
    end
    
    TH = TH+(Jpth*delp');
    
    for p = (slb+1):nb
        th(p) = TH(p-1);
    end
    
    % Q-v loop %
    
    for i = (slb+pvb+1):nb
        Qx(i) = 0;
        for k = 1:nb
            Qx(i) = Qx(i) + v(i)*v(k)*y(i,k)*sin(th(i)-th(k)-phi(i,k));
        end
    end
    
    for p=1:pqb
        delq(p)=(Qsp(p+slb+pvb) - Qx(p+slb+pvb))/v(p+slb+pvb);
    end
    
    V = V+(Jqv*delq');
    
    for p = 1:pqb
        v(slb+pvb+p) = V(p); 
    end
    
    delPQ = [delp'; delq'];
    err = max(abs(delq));
    t = t+1;
    
end
[v' cc*th']

timeElapsed = toc

