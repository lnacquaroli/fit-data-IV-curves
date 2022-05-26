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

I01=7E-6;
I02=9E-9;
Il=0.0082;
n1=1.5;
n2=9;
rs=15;
rsh=80000000000000;
n=9;

opciones=optimset('TolX',1e-9,'MaxFunEvals',1000000,'MaxIter',10000,'Display','iter');
[xx,fval] = fminsearch(@Merito11,log([I01;I02;Il;n1;n2;rs;rsh;n]),opciones);
%pone los resultados en cada parametro
xx=exp(xx)
I01=xx(1)
I02=xx(2)
Il=xx(3)
n1=xx(4)
n2=xx(5)
rs=xx(6)
rsh=xx(7)
n=xx(8)


%dibuja la curva resultante del ajuste
op2= optimset('FunValCheck','on');
for i=1:length(x)
   yc(i)=fzero(@IV11,0,op2,medido(i,1),n1,n2,rs,rsh,Il,I01,I02,K,T,n);
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