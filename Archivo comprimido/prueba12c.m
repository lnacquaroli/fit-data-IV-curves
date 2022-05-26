clc
% close all
clear all

%cargo los datos a ajustar
datos = load('SPOXA.dat');
datos = sortrows(datos,1);
V = datos(:,1);
Im = datos(:,2);

I02 = 9E-3;
I03 = 1E-3;
Il = 0.008;
n2 = 2.3;
rs = 55;
rp = 2E4;
Vbr = 0.1:0.5:10;
a = 1;
n = 4;
K = 8.617342e-5;  %constante de boltzman [eV/K]
T = 300;

op2 = optimset('FunValCheck','on');

for j=1:length(Vbr)
    x = [I02,I03,Il,rs,rp,n2,Vbr(j),n,a];
    for i=1:length(V)
        yVbr(i,j) = fzero(@(z) IV12c(z,V(i),x,K,T),0,op2);
    end
end

Vbr = 2;
n = 0:10;
for j=1:length(n)
    x = [I02,I03,Il,rs,rp,n2,Vbr,n(j),a];
    for i=1:length(V)
        yn(i,j) = fzero(@(z) IV12c(z,V(i),x,K,T),0,op2);
    end
end

n = 4;
a = 0:10;
for j=1:length(a)
    x = [I02,I03,Il,rs,rp,n2,Vbr,n,a(j)];
    for i=1:length(V)
        ya(i,j) = fzero(@(z) IV12c(z,V(i),x,K,T),0,op2);
    end
end
