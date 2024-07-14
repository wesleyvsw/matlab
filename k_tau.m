clear
clc

% mudar o path e os nomes dos arquivos
%path = 'I:\My Drive\Eng_Eletrica_2022_1\6º Período\EEE332 - Lab Sistemas de Controle I\controlador_motor_cc_experimental';
%fig_name = 'figuras\02_resposta_ao_degrau.png';
data_name = 'dados\dados_osciloscopio.CSV';

% ler o arquivo .csv contendo os dados experimentais
dados=readtable(fullfile(path, data_name));

% como foi usado um gerador de sinais para simular o degrau
% foi preciso fazer uma analise previa dos dados para garantir 
% que so exista um degrau nos vetores que serao trabalhados.
% apos analise foi notado que existe um pulso proximo de 0.5s 
% e a largura do pulso era de menos de 1 segundo
ini = find(dados.tempo==0.4);
fim = find(dados.tempo==1.5);

% amplitude do degrau
amplitude_degrau = 1;

% fatiamento 
tempo = dados.tempo(ini:fim);
va = dados.va(ini:fim);
vt = dados.vt(ini:fim);

% pegar o indice do exato instante onde ocorre o degrau
inicio_degrau = 2; % contador que sera armazenado o indice
while abs(va(inicio_degrau) - va(inicio_degrau-1))<0.5
    inicio_degrau = inicio_degrau+1;
end

% pegar o indice do exato momento onde o sinal alto do degrau deixa de existir
fim_degrau = inicio_degrau; % contador que sera armazenado o indice
while abs(va(fim_degrau+1) - va(fim_degrau))<0.5
    fim_degrau = fim_degrau+1;
end

% fatiamento dos vetores para pegar apenas o periodo desejado dados os
% indices obtidos anteriormente
tempo = tempo(inicio_degrau:fim_degrau);
va = va(inicio_degrau:fim_degrau);
vt = vt(inicio_degrau:fim_degrau);

% levando os vetores para a origem
va = va - va(1);
vt = vt - vt(1);
tempo = tempo - tempo(1);

% valor de regime permanente y(∞)
final_value = mean(vt(end-100:end));

% calculo da area A0
area_retangulo = tempo(end)*final_value; % calcula a area do retangulo que a resposta esta contida
area_resp = trapz(tempo,vt);             % calcula a area sob a curva da resposta
a0 = area_retangulo - area_resp;         % subtrai a area sob a curva do retangulo para pegar area A0

% calculo dos parametros
K = final_value/amplitude_degrau; % calculo do ganho
tau = a0/final_value;             % calculo da constante de tempo


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PLOT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if exist(fullfile(path, fig_name), 'file') ~= 2
    
    fig = figure('Visible', 'off');

    hold on 
    grid on
    plot(tempo,vt, 'DisplayName', 'Dados reais')
    plot(tempo,amplitude_degrau*K*(1-exp(-tempo/tau)),...
        'DisplayName', '$A \cdot K \cdot (1 - e^{-\frac{t}{\tau}})$');
    txt = ['Resposta dado degrau de amplitude A = ', num2str(amplitude_degrau)];
    title(txt, 'Interpreter', 'latex', 'FontSize', 14)
    xlabel('Tempo [s]', 'Interpreter', 'latex', 'FontSize', 12)
    ylabel('$V_{t}$ [V]', 'Interpreter', 'latex', 'FontSize', 12)
    leg = legend('Location', 'southeast', 'Interpreter', 'latex', 'FontSize', 12);
    
    % adiciona o valor do ganho K
    txt = ['Ganho $K$: ', num2str(K)];
    text(0.405, 0.15, txt,'Interpreter', 'latex', 'FontSize', 12);
      
    % adiciona o valor da constante de tempo tau
    txt = ['Constante $\tau$: ', num2str(tau)];
    text(0.405, 0.05, txt,'Interpreter', 'latex', 'FontSize', 12);

    % salva a figura no diretorio especificado na primeira linha deste arquivo
    saveas(fig, fullfile(path, fig_name))

    % fecha a figura
    close(fig);
end


