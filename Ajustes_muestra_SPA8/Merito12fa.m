function Error = Merito12fa(x,K,T,medido,Il1,Il2)

% global medido T

% warning off MATLAB:fzero:UndeterminedSyntax;

% x = [I02,I03,Il,rs,rp,n2,Vbr,n,a]
x = exp(x);

% calculo la curva para cada tension medida
op2 = optimset('FunValCheck','on');
for i=1:length(medido(:,1))
    y(i) = fzero(@(z) IV12fa(z,medido(i,1),x,K,T,Il1,Il2),0,op2);
end

%calculo el error
Error = mean(abs(y-medido(:,2)'));
% Error = sum((y-medido(:,2)').^2);
% Error = mean(abs(y-medido(:,2)')./y);

end