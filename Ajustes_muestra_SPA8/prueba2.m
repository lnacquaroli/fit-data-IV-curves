
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
x1=1.0e5 *[0.000000000005019
   0.000000000081953
   0.000000000041188
   0.000422963753936
   0.000026381437695
   0.000031004105206
   5.222807693903548];
I01=x1(1);
I02=x1(2);
I03=x1(3);
rs=x1(4);
n1=x1(5);
n2=x1(6);
rp=x1(7);
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