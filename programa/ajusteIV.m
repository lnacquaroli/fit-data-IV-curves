%programa que ajusta curva I-V con el modelo de un diodo

%ajusta I0, n, rs, rp

clear all
close all

global medido T K I0

%cargo los datos a ajustar
datos=load('iv18vuelta.dat');
datos=sortrows(datos,1);
x=datos(:,1);
y=datos(:,2);
figure
plot(x,y,'.')

%para no tomar todos los puntos medidos me quedo solo con una fracion de
%ellos
N=1; %tomo uno de cada N puntos
aux=1:N:floor(size(datos,1)/N)*N;
medido(:,1)=x(aux);
medido(:,2)=y(aux);

hold on
plot(medido(:,1),medido(:,2),'.r')

%constantes
K=8.617342e-5;  %constante de boltzman [eV/K]
T=300;          %temperatura [K]
%para la corriente de cortocircuito elegimos la corriente medida a voltaje
%cero
% Isc=y(find(min(abs(x-0))==abs(x-0)),1);

%elijo los valores iniciales para el ajuste
I0=7.7e-7;
n=5;
rs=500;
rp=1e5;

% Isc=Isc/(1-rs/rp);

banana=@(x)Merito(x);
[xx,fval] = fminsearch(banana,[n,rs,rp],optimset('TolX',1e-9,'MaxFunEvals',1000000,'MaxIter',10000,'FunValCheck','on','Display','iter'));

%pone los resultados en cada parametro
%I0=xx(1);
n=xx(1)
rs=xx(2)
rp=xx(3)

%dibuja la curva resultante del ajuste
for i=1:length(x)
yc(i)=IV(x(i),I0,n,T,rs,rp);
end
% plot(x,yc,'k')

figure
plot(x,y'-yc,'r')
hold on
plot(medido(:,1),medido(:,2),'.k')
