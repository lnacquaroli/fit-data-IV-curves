function F = IV3(z,V,x,K,T)

% funcion con dos diodos en serie enfrentados, mas un termino de avalancha

% x = [I02,I03,Il,rs,rp,n2,Vbr,n,a]
I01 = x(1);
I02 = x(2);
I03 = x(3);
Il = x(4);
rs = x(5);
rp = x(6);
n1 = x(7);
n2 = x(8);
n3 = x(9);

%F = -z-Il-I03*((((I03/I02)+1)/((I03/I02)+(exp((V-z*rs)/(n2*K*T)))))-1)+((V-z*rs)/rp)+(a*((V-z*rs)/(rp))*(1-((V-z*rs)/(Vbr))).^(-n));
%F = -z-Il-I03*((((I03/I02)+1)/((I03/I02)+(exp((V-z*rs)/(n2*K*T)))))-1)+((V-z*rs)/rp);
F = -z -Il +I03*exp((V-z*rs)/(n3*K*T)-1) + I01*exp(((V-z*rs-n2*K*T*log(I01/I02))/(n1*K*T+n2*K*T))-1)+((V-z*rs)/rp);

end
