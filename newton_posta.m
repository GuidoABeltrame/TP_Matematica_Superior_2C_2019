%Interpolacion de newton
clear;clc;
n=input('ingrese la cantidad de puntos:, n=')-1;
prog_o_reg=input('ingrese 1 para newton progresivo o 0 para newton regresivo, prog_o_reg=');
fprintf('Ingrese los %.0f puntos\n',n+1);
for i=1:n+1
    fprintf('x%.0f=',i-1);
    X(i)=input(' ');
    fprintf('y%.0f=',i-1);
    Y(i)=input(' ');
end
DD=zeros(n+1);
DD(:,1)=Y;
for k=2:n+1
    for J=k:n+1
        DD(J,k)=[DD(J,k-1)-DD(J-1,k-1)]/[X(J)-X(J-k+1)];
    end
end
disp('La matriz de diferencias divididas es:');
disp(DD);
disp('El polinomio de newton es');
syms x;
alto=length(DD(:,1));
polnew=DD(1,1);
P=1;
for i=1:n
    P=P*(x-X(i));
    if prog_o_reg == 1
        mult = DD(i+1,i+1);
    end
    if prog_o_reg == 0
        mult = DD(alto,i+1);
    end
    polnew=polnew+P*mult;
end
polnew=expand(polnew);
pretty(polnew);
%x=input('ingrese el valor de x a interpolar,x=');
%vi=eval(polnew);
%fprintf('el valor interpolado es %.2f\n',vi);

    %Especializar el polinomio en un punto K:
    opc=input('\nDesea aproximar un valor (si/no): ','s');
    if strcmp(opc,'si')
     x=input('\nIngrese el punto a aproximar: ');
     y=eval(polnew); %evaluar el punto en el polinomio
     fprintf('La aproximacion a f(x) es:')
     disp(y)
    end

