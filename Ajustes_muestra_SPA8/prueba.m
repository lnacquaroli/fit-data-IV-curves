
clear all

clc
close all
clear all

%cargo los datos a ajustar
datos=load('infOD.dat');
datos=sortrows(datos,1);
x=datos(:,1);
y=datos(:,2);

%para no tomar todos los puntos medidos me quedo solo con una fracion de
%ellos
N=1; %tomo uno de cada N puntos
aux=1:N:floor(size(datos,1)/N)*N;
V=x(aux);
medido(:,2)=y(aux);
I01=5.57E-7;
I02=6.86E-6;
I03=3.57E-6;
rs=48;
n1=2.2;
n2=3.5;
rp=5E5;
Il2=0;
Il1=0;
K=8.617342e-5;  %constante de boltzman [eV/K]
T=300;  
% Vbr = 1.3;
% a = 2;
% n=8;


op2= optimset('FunValCheck','on');
for i=1:length(V)
    y(i)=fzero(@I6,0,op2,V(i),n1,n2,rs,rp,I01,I02,I03,K,T,Il2,Il1);
end



figure
plot(V,y,V,medido(:,2))