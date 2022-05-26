close all
clear all
V=-2:0.01:2;
Vbr=1;
n=9;
a=1;
I01=7E-6;
I02=9E-9;
Il=0.0082;
n1=1.5;
n2=10;
rs=15;
rsh=8E13;
K=8.617342e-5;  %constante de boltzman [eV/K]
T=300;      

op2= optimset('FunValCheck','on');
for i=1:length(V)
    y(i)=fzero(@IV9,0,op2,V(i),n1,n2,rs,rsh,Il,I01,I02,K,T,Vbr,n,a);
end


figure
plot(V,y)
 M = [V(:) y(:)];
 save two M -ascii