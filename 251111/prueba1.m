clc
close all
clear all

datos = load('SPOXA.dat');
datos = sortrows(datos,1);
V = datos(:,1);
Im = datos(:,2);

I01 = 1E-3;
I02 = 3E-5;
Il = 0.008;
factor = 5;
Rs = 50;
Rp = 2E6;
n1 = 1;
n2 = 2;
a = 1.0;
K = 8.617342e-5;  %constante de boltzman [eV/K]
T = 300;  
x = [I01,I02,Il,factor,Rs,Rp,n1,n2,a];

op2 = optimset('FunValCheck','on');
for i=1:length(V)
    y(i) = fzero(@(z) IV1(z,V(i),x,K,T),0,op2);
end

figure
plot(V,y,'-k',V,Im,'-r')
