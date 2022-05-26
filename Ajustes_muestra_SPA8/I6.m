%funcion que devuelve la corriente en una celda solar para un conjunto de
%par�metros y voltaje sobre la celda

function F = I6(z,V,n1,n2,rs,rp,I01,I02,I03,K,T,Il2,Il1)

a=(V-z*rs)/(n2*K*T);

F =-z+((((Il2/I03)*(exp(a)))+(exp(a))-(Il1/I02)-1)/((1/I02)+((exp(a))/I03)))+((V-z*rs)/rp)+I01*(exp((V-z*rs)/(n1*K*T))-1);
end
