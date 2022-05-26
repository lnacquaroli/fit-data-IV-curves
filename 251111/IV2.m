function F = IV2(z,V,x,K,T)

% funcion con dos diodos en serie enfrentados, mas un termino de avalancha

% x = [I02,I03,Il,rs,rp,n2,Vbr,n,a]
I02 = x(1);
I03 = x(2);
Il = x(3);
rs = x(4);
rp = x(5);
n2 = x(6);

%F = -z-Il-I03*((((I03/I02)+1)/((I03/I02)+(exp((V-z*rs)/(n2*K*T)))))-1)+((V-z*rs)/rp)+(a*((V-z*rs)/(rp))*(1-((V-z*rs)/(Vbr))).^(-n));
F = -z-Il-I03*((((I03/I02)+1)/((I03/I02)+(exp((V-z*rs)/(n2*K*T)))))-1)+((V-z*rs)/rp);

end
