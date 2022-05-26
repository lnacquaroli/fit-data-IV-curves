%funcion que devuelve la corriente en una celda solar para un conjunto de
%par�metros y voltaje sobre la celda

function F=I4(x,V,n2,rs,I02,I03,rp,K,T,Il,Vbr,a,n)

F=-x-Il-I03*((((I03/I02)+1)/((I03/I02)+(exp((V-x*rs)/(n2*K*T)))))-1)+((V-x*rs)/rp)+(a*((V-x*rs)/(rp))*(1-((V-x*rs)/(Vbr))).^(-n));

end
