%Leitura dos csv's do osciloscópio
f2ch1 = readtable('F2CH1.csv');
f2ch2 = readtable('F2CH2.csv');
f3ch1 = readtable('F3CH1.csv');
f3ch2 = readtable('F3CH2.csv');
%Coletando somente as colunas comm os dados
dados21 = f2ch1(:,[4:5]);
dados22 = f2ch2(:,[4:5]);
%dados21 = renamevars(dados22,'Var5','Canal_1');
dados22 = renamevars(dados22,'Var5','Canal_2');
dados31 = f3ch1(:,[4:5]);
dados32 = f3ch2(:,[4:5]);
%dados31 = renamevars(dados32,'Var5','Canal_1');
dados32 = renamevars(dados32,'Var5','Canal_2');
%adicionando a nova coluna a matriz
dados2 = [dados21 dados22(:, 2)];
dados3 = [dados31 dados32(:, 2)];
%Plot dos graficos(Tirar os comentários)
dados22 = dados2(600:1500, :);
dados32 = dados3(1101:1800, :);

vetor_temp = (dados22(:, 1) - 9.23);
tabela2_Ysubtraido = [vetor_temp dados22(:, 2:end)];

%para o calculo da media
tabela2_calculo_media_superior = tabela2_Ysubtraido(250:end, :);
tabela2_calculo_media_inferior = tabela2_Ysubtraido(26:270, :);
media_superior_canal1 = mean(tabela2_calculo_media_superior.Var5);
media_superior_canal2 = mean(tabela2_calculo_media_superior.Canal_2);
media_inferior_canal1 = mean(tabela2_calculo_media_inferior.Var5);
media_inferior_canal2 = mean(tabela2_calculo_media_inferior.Canal_2);

%subtraindo a media pra matar o offset:

tabela2_SemOffset = [tabela2_Ysubtraido(:, 1:1) tabela2_Ysubtraido(:, 2:2)-media_inferior_canal1 tabela2_Ysubtraido(:, 3:3)-media_inferior_canal2];

%ganho DC:

ganhoDC = (media_superior_canal2 - media_inferior_canal2)/(media_superior_canal1 - media_inferior_canal1)

%t de regime permanente e t inicial para achar a area do transitorio:
t_inicial = 0;
indice_t0 = find(tabela2_SemOffset.Var4 == t_inicial);
t_regime_permanente = 0.195;
indice_tPermanente = find(tabela2_SemOffset.Var4 >= t_regime_permanente);
indice_tPermanente = indice_tPermanente(1);

tabela2_entreT0eRegime = tabela2_SemOffset(indice_t0:indice_tPermanente, :);

area_transitorio = trapz(tabela2_entreT0eRegime.Var4, tabela2_entreT0eRegime.Canal_2);

tau = area_transitorio/(media_superior_canal2- media_inferior_canal2)

%teorico
eixo_x = tabela2_Ysubtraido.Var4(indice_t0:end, :);
eixo_y = 1*ganhoDC*(1-exp(-eixo_x/tau));

alvo = dados22;
alvo = tabela2_Ysubtraido;
alvo = tabela2_calculo_media_inferior;
alvo = tabela2_SemOffset;
%alvo = tabela2_entreT0eRegime;
alvo = tabela2_SemOffset;
coluna_input = [alvo.Var4 alvo.Var5];
coluna_output = [alvo.Var4 alvo.Canal_2];
plot(alvo.Var4, alvo.Var5, 'b', 'DisplayName', 'y1 vs t'); % Curva azul para y1 vs t
hold on;
plot(alvo.Var4, alvo.Canal_2, 'r', 'DisplayName', 'y2 vs t'); % Curva laranja para y2 vs t
plot(eixo_x, eixo_y, 'g', 'DisplayName', 'teorico');
xlabel('tempo(s)');
ylabel('Tensão(V)');
title('Curvas de y1 e y2 vs t');
legend('show');
grid on;
hold off;
tabela_extra = alvo(:,2);
tabela_extra =tabela_extra(325:end,:)
tabela_extra = table2timetable(tabela_extra,'SampleRate',100)

%root locus
sys = tf([ganhoDC],[tau 1 0]);
%modelo ki critimamente amortecido =1.86578
modelo_ki = tf([ganhoDC*1.86578],[tau 1 1.86578*ganhoDC]);
%Tempo de acomodacao para ki = 1.86578
stepinfo(modelo_ki)
%Para 0.9KI
modelo_ki2 = tf([ganhoDC*0.9*1.86578],[tau 1 1.686578*ganhoDC*0.9]);
stepinfo(modelo_ki2)
%Subamortecido com 0.05 de OS
modelo_ki3 = tf([ganhoDC*3.91776],[tau 1 3.91776*ganhoDC]);
stepinfo(modelo_ki3)
%Subamrtecido 0.9Ka
modelo_ki4 = tf([ganhoDC*3.91776*0.9],[tau 1 3.91776*ganhoDC*0.9]);
stepinfo(modelo_ki4)


