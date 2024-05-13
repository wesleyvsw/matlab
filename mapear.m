function = mapear(a)
num = [1, 0]
den = [1, 2]
%caminho descida
o1  =[1:-0.1:-1];
oi1 = o1*i +1;


%Caminho esquerda
oi2 = o1 - i;
%caminho subir
oi3 = o1*(-i) -1;
%caminho direita
oi4 = o1*i +1;
itotal = horzcat(oi1,oi2,oi3,oi4);
plot(itotal)

aaa = polyval(num,itotal)./polyval(den,itotal);
plot(aaa)
