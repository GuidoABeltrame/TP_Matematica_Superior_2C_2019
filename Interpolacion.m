%FINTER - TP INTERPOLACIÓN
clc %Borra el area de trabajo
clear %borra las variables almacenadas
fin='no';
while fin == "no"
clc %Borra el area de trabajo
clear %borra las variables almacenadas
format long %permite utilizar la máxima capacidad de la máquina

fprintf('FINTER\n\n');

%Solicito el lote de puntos:
xi=input('Ingrese los puntos pertenecientes a las x: ');
yi=input('Ingrese los puntos pertenecientes a las y: ');

x=sym('x'); %Variable 'x' como simbolica

%Solicito el método a utilizar
metodo=input('\nSeleccione el método de interpolacion: (L/NG)','s');

%Lagrange
if strcmp(metodo,'L')
    fprintf('El metodo seleccionado es Lagrange\n')
    n=length(xi);
    for j=1:n
    producto=1;
    for i=1:j-1
    producto=producto*(x-xi(i)); %calculo del producto 1 superior de L
    end
    producto2=1;
    for i=j+1:n
    producto2=producto2*(x-xi(i)); %calculo del producto 2 superior de L
    end
    producto3=1;
    for i=1:j-1
    producto3=producto3*(xi(j)-xi(i)); %calculo del producto 3 inferior de L
    end
    producto4=1;
    for i=j+1:n
    producto4=producto4*(xi(j)-xi(i)); %calculo del producto 4 inferior de L
    end
    L(j)=(producto*producto2)/(producto3*producto4); %calculos de las L para
    fprintf('\n L%d:\n',j-1) %poder hallar el polinomio
    disp(L(j)) %visualizar varibles o texto en el workspace
    end
    pn=0;
    for j=1:n
    pn=pn+L(j)*yi(j); %calculo del polinomio interpolante
    end
    fprintf('\n POLINOMIO INTERPOLANTE: \n')
    pn = vpa(simplify(pn),10); %simplifico la expresion
    disp(pn)
    
    %Especializar el polinomio en un punto K:
    opc=input('\nDesea aproximar un valor (si/no): ','s');
    if strcmp(opc,'si')
     x=input('\nIngrese el punto a aproximar: ');
     y=eval(pn); %evaluar el punto en el polinomio
     fprintf('La aproximacion a f(x) es:')
     disp(y)
    end
end

%Newton Gregory
if strcmp(metodo,'NG')
    fprintf('\nEl metodo seleccionado es NG')
    
n=length(xi)-1;
prog_o_reg=input('\nIngrese 1 para newton progresivo o 0 para newton regresivo');
DD=zeros(n+1);
DD(:,1)=yi;
for k=2:n+1
    for J=k:n+1
        DD(J,k)=[DD(J,k-1)-DD(J-1,k-1)]/[xi(J)-xi(J-k+1)];
    end
end
disp('La matriz de diferencias divididas es:');
disp(DD);
disp('El polinomio de newton es');
alto=length(DD(:,1));
polnew=DD(1,1);
P=1;
for i=1:n
    P=P*(x-xi(i));
    if prog_o_reg == 1
        mult = DD(i+1,i+1);
    end
    if prog_o_reg == 0
        mult = DD(alto,i+1);
    end
    polnew=polnew+P*mult;
end
polnew=expand(polnew);
%grado=length(polnew);
pretty(polnew);

%Me fijo si los puntos son equidistantes
%Por ejemplo: si tomás 5 puntos, x1-x0=x2-x1=x3-x2=x4-x3

    %Especializar el polinomio en un punto K:
    opc=input('\nDesea aproximar un valor (si/no): ','s');
    if strcmp(opc,'si')
     x=input('\nIngrese el punto a aproximar: ');
     y=eval(polnew); %evaluar el punto en el polinomio
     fprintf('La aproximacion a f(x) es:')
     disp(y)
    end
end

%Finalizar
fin=input('\nDesea finalizar (si/no): ','s');
end