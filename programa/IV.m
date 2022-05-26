%funcion que devuelve la corriente en una celda solar para un conjunto de
%par�metros y voltaje sobre la celda

function [I]=IV(V,I0,n,T,rs,rp)

K=8.617342e-5;  %constante de boltzman [eV/K]

I = fzero(@(I)(-I-I0*(exp((V+I*rs)/(n*K*T))-1)-(V+I*rs)/rp),0);
%I = fzero(@(I)(-I+Isc+I0*(exp((V-I*rs)/(n*K*T))-1)+(V-I*rs)/rp),0);