clc
clear all
% close all

% warning off MATLAB:fzero:UndeterminedSyntax;

%cargo los datos a ajustar
datos = load('0.5 OD.dat');
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
% x0 = [Il1,Il2]
x0 = [2e-5,15E-9];
x1 = log(x0);
lb = log(0.001*x0);
ub = log(10*x0);
I01= 5.57E-7;
n1=2.2;
I02=6.86E-6;
rp=5e5;
I03=3.57E-6;
rs=48;
n2=3.5;

opciones1 = saoptimset('InitialTemperature',.1,'Display','iter','MaxIter',500);
[r1,fval1,exitflag1] = simulannealbnd(@(x) Merito12fb(x,K,T,medido,I01,n1,I02,rp,I03,rs,n2),x1,lb,ub,opciones1);

opciones2 = optimset('Display','iter','MaxIter',1500,'MaxFunEvals',5000);
[r2,fval2,exitflag2] = fminsearchbnd(@(x) Merito12fb(x,K,T,medido,I01,n1,I02,rp,I03,rs,n2),r1,lb,ub,opciones2);

% opciones=optimset('TolX',1e-9,'MaxFunEvals',1000000,'MaxIter',10000,'Display','iter');
% [xx,fval] = fminsearch(@Merito12,log([I02;I03;Il;Vbr;n;a;n2;rs;rp]),opciones);
%pone los resultados en cada parametro
r2 = exp(r2);


%dibuja la curva resultante del ajuste
op2 = optimset('FunValCheck','on');
for i=1:length(x)
   yc2(i) = fzero(@(z) IV12fb(z,medido(i,1),r1,K,T,I01,n1,I02,rp,I03,rs,n2),0,op2); 
   yc(i) = fzero(@(z) IV12fb(z,medido(i,1),r2,K,T,I01,n1,I02,rp,I03,rs,n2),0,op2);
end

%plotea resultados
figure
plot(x,yc,'r')
hold on
plot(medido(:,1),medido(:,2),'b')
ylabel('Corriente [A]')
xlabel('Voltaje [V]')
legend('ajuste','medida')


% M = [x(:) medido(:,2) yc(:)];
% save SPD1k_10OD.dat M -ascii