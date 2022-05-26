function Error=Merito1(x)

global medido T I0

I0=x(1);
n=x(2);
rs=x(3);

%calculo la cuva para cada tension medida

for i=1:length(medido(:,1))
    y(i)=IV1(medido(i,1),I0,n,T,rs);
end

%calculo el error
Error=mean(abs(y-medido(:,2)'));