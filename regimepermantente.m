%Antes de utilizar o ginput, preciso plotar o gráfico antes, ou ele não irá
%mostrar o gráfico da resposta ao degrau
function [yss] = regimepermatente(t, ruido)
plot(t, ruido)
[x, y] = ginput(1);
yss = y;

    