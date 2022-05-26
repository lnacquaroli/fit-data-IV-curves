clc
clear all
% close all

% warning off MATLAB:fzero:UndeterminedSyntax;

%cargo los datos a ajustar
datos = load('SPOXA.dat');
datos = sortrows(datos,1);
x = datos(:,1);
y = datos(:,2);
% figure
% plot(x,y,'.')
% xlabel('Voltaje [V]')
% ylabel('Corriente [A]')

% para no tomar todos los puntos medidos me quedo solo con una fracion de
% ellos
N = 1; %tomo uno de cada N puntos
aux = 1:N:floor(size(datos,1)/N)*N;
medido = [x(aux),y(aux)];
% hold on
% plot(medido(:,1),medido(:,2),'.r')

% constante de boltzman [eV/K]
K = 8.617342e-5;
% temperatura [K]
T = 300;          

%para la corriente de cortocircuito elegimos la corriente medida a voltaje
%cero
%Isc=y(find(min(abs(x-0))==abs(x-0)),1);

% elijo los valores iniciales para el ajuste
% x0 = [I02,I03,Il,rs,rp,n2,Vbr,n,a]
% x0 = [1e-2,1e-3,8e-3,50,7e4,2,1.5,4,1];
x0 = [1e-2,1e-3,8e-3,50,7e4,2,1.5,1];
lb = 0.1*x0;
ub = 10*x0;

opciones1 = saoptimset('InitialTemperature',.1,'Display','iter','MaxIter',500);
[r1,fval1,exitflag1] = simulannealbnd(@(x) Merito12b(x,K,T,medido),x0,lb,ub,opciones1);

opciones2 = optimset('Display','iter');
[r2,fval2,exitflag2] = fminsearchbnd(@(x) Merito12b(x,K,T,medido),r1,lb,ub,opciones2);

% opciones=optimset('TolX',1e-9,'MaxFunEvals',1000000,'MaxIter',10000,'Display','iter');
% [xx,fval] = fminsearch(@Merito12,log([I02;I03;Il;Vbr;n;a;n2;rs;rp]),opciones);
%pone los resultados en cada parametro
% xx=exp(xx);
I02 = r1(1);
I03 = r1(2);
Il = r1(3);
rs = r1(4);
rp = r1(5);
n2 = r1(6);
Vbr = r1(7);
% n = r1(8);
a = r1(8);

%dibuja la curva resultante del ajuste
op2 = optimset('FunValCheck','on');
for i=1:length(x)
   yc2(i) = fzero(@(z) IV12b(z,medido(i,1),r1,K,T),0,op2); 
   yc(i) = fzero(@(z) IV12b(z,medido(i,1),r2,K,T),0,op2);
end

%plotea resultados
figure
plot(x,yc,'r')
hold on
plot(medido(:,1),medido(:,2),'.k')
plot(x,yc2,'m')
ylabel('Corriente [A]')
xlabel('Voltaje [V]')

% M = [x(:) medido(:,2) yc(:)];
% save OX.dat M -ascii