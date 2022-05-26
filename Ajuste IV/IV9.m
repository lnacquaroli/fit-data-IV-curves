%funcion que devuelve la corriente en una celda solar para un conjunto de
%par�metros y voltaje sobre la celda

function F=IV9(x,V,n1,n2,rs,rsh,Il,I01,I02,K,T,Vbr,n,a)

% if V<0
    
F=-x+Il-I01*(exp((V+x*rs)/(n1*K*T))-1)-I02*(exp((V+x*rs)/(n2*K*T))-1)-((V+x*rs)/(rsh))-(a*((V+x*rs)/(rsh))*(1-((V+x*rs)/(Vbr)))^n)*(1-exp((V-x*rs)/(K*T)));

% else 
% F= -x+I02*(exp((V+x*rs)/(n2*K*T))-1);
end
