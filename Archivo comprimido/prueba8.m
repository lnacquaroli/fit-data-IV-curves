close all
clear all

clc
close all
clear all

%cargo los datos a ajustar
datos=load('SPOXA.dat');
datos=sortrows(datos,1);
x=datos(:,1);
y=datos(:,2);

%para no tomar todos los puntos medidos me quedo solo con una fracion de
%ellos
N=1; %tomo uno de cada N puntos
aux=1:N:floor(size(datos,1)/N)*N;
V=x(aux);
medido(:,2)=y(aux);

I02=9E-3;
I03=1E-3;
Il=0.008;
n2=2.3;
rs=49;
rp=2E4;
Vbr=1.7;
a=1;
n=4;
K=8.617342e-5;  %constante de boltzman [eV/K]
T=300;  


op2= optimset('FunValCheck','on');
for i=1:length(V)
    y(i)=fzero(@I4,0,op2,V(i),n2,rs,I02,I03,rp,K,T,Il,Vbr,a,n);
end



figure
plot(V,y,V,medido(:,2),'.')