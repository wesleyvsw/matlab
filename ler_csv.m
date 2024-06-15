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
%plot(dados3.Var4,dados3.Var5)
%Ordenanando os indices o canal 1 para pegar somente um ntervalo do degrau


