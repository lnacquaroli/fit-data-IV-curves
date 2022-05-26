clc
% close all
clear all

%cargo los datos a ajustar
datos = load('SPOXA.dat');
datos = sortrows(datos,1);
V = datos(:,1);
Im = datos(:,2);

I02 = 1E-3;
I03 = 3E-3;
Il = 8e-3;
n2 = 1;
rs = 50;
rp = 2E6;
K = 8.617342e-5;  %constante de boltzman [eV/K]
T = 300;  
x = [I02,I03,Il,rs,rp,n2];

op2= optimset('FunValCheck','on');
for i=1:length(V)
    y(i) = fzero(@(z) IV2(z,V(i),x,K,T),0,op2);
end

figure
plot(V,y,V,Im,'.')
