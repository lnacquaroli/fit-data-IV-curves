function F = IV14(z,V,x,K,T)

% funcion con dos diodos en serie enfrentados, mas un termino de avalancha

% x = [I02,I03,Il,rs,rp,n2,Vbr,a,n]
I02 = x(1);
I03 = x(2);
Il = x(3);
rs = x(4);
rp = x(5);
n2 = x(6);
Vbr = x(7);
a = x(8);
n = x(9);

F = -z-Il-I03*((((I03/I02)+1)/((I03/I02)+(exp((V-z*rs)/(n2*K*T)))))-1)+(a*((V-z*rs)/(rp))*(1/(1-((V-z*rs)/Vbr)).^n));

end
