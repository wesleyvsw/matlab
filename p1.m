%Questão 1
t = [0:0.01:5];
fun_transf = tf([1],[0.5 1]);
% degrau da função
step(fun_transf, t);
array_step = step(fun_transf, t);% resposta ao degrau da função de transferencia

%Questão 2

m = length(t);
%Chamando y de array step para utilizar os dados da questão 1
y_noise = array_step +0.1*rand(m,1) - 0.05;

%Questão 4
%preciso plot do gráfico
plot(t,y_noise)
regimepermanente(t,y_noise)




