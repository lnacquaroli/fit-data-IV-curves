clc
% close all
clear all

%cargo los datos a ajustar
datos = load('SPOXA.dat');
datos = sortrows(datos,1);
V = datos(:,1);
Im = datos(:,2);

I01 = 1e-2;
I02 = 1E-5;
I03 = 3E-3;
Il = 8e-3;
n1 = 3;
n2 = 2;
n3 = 4;
rs = 50;
rp = 2E6;
K = 8.617342e-5;  %constante de boltzman [eV/K]
T = 300;  
x = [I01,I02,I03,Il,rs,rp,n1,n2,n3];

op2= optimset('FunValCheck','on');
for i=1:length(V)
    y(i) = fzero(@(z) IV3(z,V(i),x,K,T),0,op2);
end

figure
plot(V,y,V,Im,'.')
