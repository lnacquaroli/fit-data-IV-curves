function Error=Merito2(x)

global medido T I0

n=x(1);
rs=x(2);

%calculo la cuva para cada tension medida

for i=1:length(medido(:,1))
    y(i)=IV2(medido(i,1),I0,n,T,rs);
end

%calculo el error
Error=mean(abs(y-medido(:,2)'));