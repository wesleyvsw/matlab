function som = soma_pol(x,y)
intervalo1 = length(x);
intervalo2 = length(y);
maximo = max(intervalo1, intervalo2)
minimo = min(intervalo1, intervalo2)


if intervalo2 == intervalo1
    som = x+y;
else
    ze = zeros(1,maximo-minimo)
    if intervalo2 > intervalo1
        som = [ze,x] + y;
    else
        som = [ze,y] + x;
    end
end



