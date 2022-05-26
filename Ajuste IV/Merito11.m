function Error=Merito11(x)

global medido T

warning off MATLAB:fzero:UndeterminedSyntax;

x=exp(x);
I01=x(1);
I02=x(2);
Il=x(3);
n1=x(4);
n2=x(5);
rs=x(6);
rsh=x(7);
n=x(8);





K=8.617342e-5;  %constante de boltzman [eV/K]

%calculo la curva para cada tension medida
op2= optimset('FunValCheck','on');
for i=1:length(medido(:,1))
    y(i)=fzero(@IV11,0,op2,medido(i,1),n1,n2,rs,rsh,Il,I01,I02,K,T,n);
end

%calculo el error
Error=mean(abs(y-medido(:,2)'));

end