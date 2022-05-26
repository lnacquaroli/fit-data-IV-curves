function Error=Merito12(x)

global medido T

warning off MATLAB:fzero:UndeterminedSyntax;

x=exp(x);
I02=x(1);
I03=x(2);
Il=x(3);
Vbr=x(4);
a=x(5);
n=x(6);
n2=x(7);
rs=x(8);
rp=x(9);

%n=x(8);


K=8.617342e-5;  %constante de boltzman [eV/K]
% a = 1;
% n = 4;

%calculo la curva para cada tension medida
op2= optimset('FunValCheck','on');
for i=1:length(medido(:,1))
    y(i)=fzero(@IV12,0,op2,medido(i,1),n2,rs,I02,I03,rp,K,T,Il,Vbr,a,n);
end

%calculo el error
% Error=mean(abs(y-medido(:,2)'));
Error=sum((y-medido(:,2)').^2);

end