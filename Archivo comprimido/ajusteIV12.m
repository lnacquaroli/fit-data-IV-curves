%programa que ajusta curva I-V con el modelo de un diodo

%ajusta I0, n, rs

clear all
close all

global medido T K

warning off MATLAB:fzero:UndeterminedSyntax;

%cargo los datos a ajustar
datos=load('SPOXA.dat');
datos=sortrows(datos,1);
x=datos(:,1);
y=-datos(:,2);
figure
plot(x,y,'.')
xlabel('Voltaje [V]')
ylabel('Corriente [A]')

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
 %Isc=y(find(min(abs(x-0))==abs(x-0)),1);

%elijo los valores iniciales para el ajuste

I02=1E-2;
I03=1E-3;
Il=0.008;
n2=2;
Vbr=1.5;
n=4;
a=1;
rs=50;
rp=7E4;

opciones=optimset('TolX',1e-9,'MaxFunEvals',1000000,'MaxIter',10000,'Display','iter');
[xx,fval] = fminsearch(@Merito12,log([I02;I03;Il;Vbr;n;a;n2;rs;rp]),opciones);
%pone los resultados en cada parametro

xx=exp(xx);
I02=xx(1);
I03=xx(2);
Il=xx(3);
Vbr=xx(4);
a=xx(5);
n=xx(6);
n2=xx(7);
rs=xx(8);
rp=xx(9);



%dibuja la curva resultante del ajuste
op2= optimset('FunValCheck','on');
for i=1:length(x)
   yc(i)=fzero(@IV12,0,op2,medido(i,1),n2,rs,I02,I03,rp,K,T,Il,Vbr,a,n);
end

%plotea resultados
figure
plot(x,yc,'r')
hold on
plot(medido(:,1),medido(:,2),'.k')
ylabel('Corriente [A]')
xlabel('Voltaje [V]')
% title(['n = ' num2str(n) ', I_0 = ' num2str(I0) ' [A], r_s = '  num2str(rs) ' [\Omega] I_l = ' num2str(Il) ' [A]'])

% M = [x(:) medido(:,2) yc(:)];
% save OX.dat M -ascii