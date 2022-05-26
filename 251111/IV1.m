function F = IV1(z,V,x,K,T)

I01 = x(1);
I02 = x(2);
Il = x(3);
factor = x(4);
Rs = x(5);
Rp = x(6);
n1 = x(7);
n2 = x(8);
a = x(9);

Vp = V/(1+factor);

F = - z - Il + I01*exp((Vp-z*Rs)/(n1*K*T)-1) + I02*exp((V-z*Rs)/(n2*K*T)-1) + (V-z*Rs)/Rp;

end
