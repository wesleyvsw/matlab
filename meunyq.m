function gjw = meunyq(n,d,w)
modulo = abs(polyval(n,w)./polyval(d,w));
fase = angle(polyval(n,w)./polyval(d,w));
gjw = plot(modulo,fase)
