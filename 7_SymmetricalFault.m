clc
clear all

V=1;
zf=1j*0.15;

y_bus=[-1j*9.5454 1j*1.666 1j*3.333; 1j*1.666 -1j*8.333 1j*3.333; 1j*3.333 1j*3.333 -1j*6.666];

zbus=inv(y_bus);

i=[0;0;0];

for i=1:3
    I(i,1)=V/(zbus(i,i)+zf);
    deltaV=-zbus*I
    I
    I=[0;0;0];
    i=i+1;
end
