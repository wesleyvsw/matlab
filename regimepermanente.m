%Antes de utilizar o ginput, preciso plotar o gráfico antes, ou ele não irá
%mostrar o gráfico da resposta ao degrau
function [yss] = regimepermanente(t, ruido)
plot(t, ruido)
[x, y] = ginput(1);
%retornando o vetor de posicoes onde t é maior que o valor selecionado de
%regime permanente
vetor_positions = find(t>x);
%Selecionando  o valor da primeira posiçao do vetor de regime permanente
primeiro = vetor_positions(1);
%Criando um novo array de ruidos iniciando na posição de regime permanente ate o final
vetor_permanente = ruido(primeiro, end);
%yss = media
yss = mean(vetor_permanente)


    