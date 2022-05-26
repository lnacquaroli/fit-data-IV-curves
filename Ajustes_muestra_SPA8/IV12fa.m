function F = IV12fa(z,V,x,K,T,Il1,Il2)

% funcion con dos diodos en serie enfrentados, mas un termino de avalancha

% x = [rs,rp,n1,n2,I01,I02,I03]

I01=x(1);
I02=x(2);
I03=x(3);
rs=x(4);
n1=x(5);
n2=x(6);
rp=x(7);


a=(V-z*rs)/(n2*K*T);
% F = -z-Il-I03*((((I03/I02)+1)/((I03/I02)+(exp((V-z*rs)/(n2*K*T)))))-1)+((V-z*rs)/rp)+I01*(exp((V-z*rs)/(n1*K*T))-1);
% F = -z-Il-I03*((((I03/I02)+1)/((I03/I02)+(exp((V-z*rs)/(n2*K*T)))))-1)+(a*((V-z*rs)/(rp))*(1-((V-z*rs)/(Vbr))).^(-n));
% F = -z-Il-I03*((((I03/I02)+1)/((I03/I02)+(exp((V-z*rs)/(n2*K*T)))))-1)+((V-z*rs)/rp)+I01*(exp((V-z*rs)/(n1*K*T))-1);
%F = -z-Il-I03*((((I03/I02)+1)/((I03/I02)+(exp((V*(1+(rs/rp))-z*rs)/(n2*K*T)))))-1)+(V/rp)+I01*(exp((V-z*rs)/(n1*K*T))-1);


%%%Fuente de corriente independiente para cada diodo enfrentado
F =-z+((((Il2/I03)*(exp(a)))+(exp(a))-(Il1/I02)-1)/((1/I02)+((exp(a))/I03)))+((V-z*rs)/rp)+I01*(exp((V-z*rs)/(n1*K*T))-1);
end