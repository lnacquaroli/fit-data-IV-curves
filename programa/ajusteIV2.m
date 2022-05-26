%programa que ajusta curva I-V con el modelo de un diodo

%ajusta n, rs

clear all
close all

global medido T K I0

%cargo los datos a ajustar
datos=load('IV1_0%_oscuras');
datos=sortrows(datos,1);
x=datos(:,1);
y=-datos(:,2);
% figureM
% plot(x,y,'.')
% xlabel('Voltaje [V]')
% ylabel('Corriente [A]')

%para no tomar todos los puntos medidos me quedo solo con una fracion de
%ellos
N=1; %tomo uno de cada N puntos
aux=1:N:floor(size(datos,1)/N)*N;
medido(:,1)=x(aux);
medido(:,2)=y(aux);

% hold on
% plot(medido(:,1),medido(:,2),'.r')

%constantes
K=8.617342e-5;  %constante de boltzman [eV/K]
T=300;          %temperatura [K]
%para la corriente de cortocircuito elegimos la corriente medida a voltaje
%cero
% Isc=y(find(min(abs(x-0))==abs(x-0)),1);

%elijo los valores iniciales para el ajuste
I0=-min(-medido(:,2));
n=5;
rs=500;

banana=@(x)Merito2(x);
[xx,fval] = fminsearch(banana,[n,rs],optimset('TolX',1e-9,'MaxFunEvals',1000000,'MaxIter',10000,'FunValCheck','on','Display','iter'));

%pone los resultados en cada parametro
n=xx(1);
rs=xx(2);

%dibuja la curva resultante del ajuste
for i=1:length(x)
    yc(i)=IV2(x(i),I0,n,T,rs);
end

%plotea resultados
figure
plot(x,yc,'r')
hold on
plot(medido(:,1),medido(:,2),'.k')
ylabel('Corriente [A]')
xlabel('Voltaje [V]')
title(['n = ' num2str(n) ', r_s = ' num2str(rs) ' [\Omega]'])
