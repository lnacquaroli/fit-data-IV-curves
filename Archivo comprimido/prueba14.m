clc
% close all
clear all

%cargo los datos a ajustar
datos = load('SPOXA.dat');
datos = sortrows(datos,1);
V = datos(:,1);
Im = datos(:,2);

% parametros optimos
I02 = 9E-3;
I03 = 1E-3;
Il = 0.008;
n2 = 2.3;
rs = 1;
rp = 2E4;
Vbr = 5;
a = 10;

K = 8.617342e-5;  %constante de boltzman [eV/K]
T = 300;


% n = 0:0.5:10;
n = 4;
op2= optimset('FunValCheck','on');
for j=1:length(n)
    x = [I02,I03,Il,rs,rp,n2,Vbr,a,n(j)];
    for i=1:length(V)
        y(i) = fzero(@(z) IV14(z,V(i),x,K,T),0,op2);
    end
%     Error(j) = mean(abs(y-Im));
end

figure
plot(V,y,V,Im,'.')
