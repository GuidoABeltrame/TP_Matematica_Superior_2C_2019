inicial = input('Matriz 2 x n (x arriba y abajo)');
ancho = length(inicial);
calculos = zeros(ancho + 1,ancho);

calculos(1,:) = inicial(1,:);
calculos(2,:) = inicial(2,:);

for i=3:1:ancho + 2
    corte = ancho - i + 2;
    for j=1:1:corte
        numerador = calculos(i-1,j+1) - calculos(i-1,j);
        denominador = calculos(1,i+j-2) - calculos(1,j);
        calculos(i,j) = numerador/denominador;
    end
end

disp(calculos)