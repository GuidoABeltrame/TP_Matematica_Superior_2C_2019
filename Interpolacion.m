%FINTER - TP INTERPOLACIÓN

clc %Borra el area de trabajo
clear %borra las variables almacenadas
format long %permite utilizar la máxima capacidad de la máquina

fprintf('FINTER\n\n');

%Solicito el lote de puntos:
xi=input('Ingrese los puntos pertenecientes a las x: ');
yi=input('Ingrese los puntos pertenecientes a las y: ');

%Solicito el método a utilizar
metodo=input('\nSeleccione el método de interpolacion: (L/NGP/NGR)','s');

%Lagrange
if strcmp(metodo,'L')
    fprintf('El metodo seleccionado es Lagrange\n')
    n=length(xi);
    x=sym('x'); %esta funcion nos permite dejar la variable 'x' como simbolica
    % y asi poder trabajar con ella, sin tener que asignarle un valor.
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
    disp(L(j)) %la funcion dispo nos permite visualizar varibles o texto
    % en el workspace
    end
    pn=0;
    for j=1:n
    pn=pn+L(j)*yi(j); %calculo del polinomio interpolante
    end
    fprintf('\n POLINOMIO INTERPOLANTE: \n')
    %disp(pn) % esta ejecucion la podemos utilizar cuando no necesitamos
    %simplicar la expresion
    pn = vpa(simplify(pn),10); %este comando nos permite simplificar toda la expresion
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

if strcmp(metodo,'NGP')
    fprintf('El metodo seleccionado es NGP')
end

if strcmp(metodo,'NGR')
    fprintf('El metodo seleccionado es NGR')
end