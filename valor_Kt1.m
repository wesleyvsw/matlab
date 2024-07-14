% Substitua pelo caminho para um diretório em que você tenha permissão de gravação
%caminho_para_diretorio = 'I:\My Drive\Eng_Eletrica_2022_1\6º Período\EEE332 - Lab Sistemas de Controle I\controlador_motor_cc_experimental\figuras';
%nome_fig_1 = '03_Vt_x_Va_e_derivada.png';
%nome_fig_2 = '04_regiao_linear_Vt_x_Va.png';

run('dadosexp.m');  % carrega as variaveis va_exp, va_sug, vt e w

grau = 6;                          % grau do polinomio ajsutado dos dados
x = 0:0.01:va_exp(end);            % valores discretos para calculos dos polinomios
coef = polyfit(va_exp, vt, grau);  % coeficientes do polinomio ajustado a partir dos minimos quadrados
grau_deriv = length(coef)-1;       % define o grau da derivada (n-1)
coef_deriv = (grau_deriv:-1:1).*coef(1:grau_deriv);  % coeficientes da derivada do polinomio ajustado

% apos analise, foi notado que a regiao linear comeca quando va_exp == 4.2
inicio_linear = find(va_exp == 4.2);        % busca a posicao do valor 4.2 no vetor va_exp
new_va_exp = va_exp(inicio_linear-1:end);   % cria um novo vetor va_exp apenas com os dados da regiao linear de va_exp
new_vt = vt(inicio_linear-1:end);           % cria um novo vetor vt apenas com os dados da regiao linear de va_exp

new_va_exp = new_va_exp - new_va_exp(1);    % leva o new_va_exp para a origem
new_vt     = new_vt - new_vt(1);            % leva o new_vt para a origem
new_coef   = polyfit(new_va_exp,new_vt,1);  % cria um polinomio linear que ajusta os novos dados

Kt = new_coef(1); % VALOR DE Kt -> INCLINACAO DA RETA

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PLOT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% caso as imagens ja estejam salvas, pular esta etapa
%if exist(fullfile(caminho_para_diretorio, nome_fig_1), 'file') ~= 2 || ...
        %exist(fullfile(caminho_para_diretorio, nome_fig_2), 'file') ~=2

    %%%%%%%%%% CONFIGURACOES DA FIGURA 1 %%%%%%%%%%
    % cria a figura 1 sem exibi-la
    fig1 = figure('Visible', 'off');

    % divide a figura em duas linha e uma coluna e vai plotar na primeira linha
    subplot(2,1,1)

    hold on
    plot(va_exp,vt,'x', 'DisplayName', 'Tensão Va experimental')
    plot(x,polyval(coef,x), 'DisplayName', 'Polinômio ajustado')
    title('$V_{t}$ em funcao de $V_{a}$', 'Interpreter', 'latex', 'FontSize', 14)
    xlabel('$Va_{exp} \,\, [V]$', 'Interpreter', 'latex', 'FontSize', 12)
    ylabel('$Vt \,\, [V]$', 'Interpreter', 'latex', 'FontSize', 12)
    leg11 = legend('Location', 'southeast');
    grid on

    % divide a figura em duas linha e uma coluna e vai plotar na segunda linha
    subplot(2,1,2)

    plot(x, polyval(coef_deriv,x), 'DisplayName', 'Derivada do polinômio ajustado')
    title('Derivada de $V_{t}$ em relacao a $V_{a}$', 'Interpreter', 'latex', 'FontSize', 14)
    xlabel('$Va_{exp} \,\, [V]$', 'Interpreter', 'latex', 'FontSize', 12)
    ylabel('$\frac{d}{dVa_{exp}}(Vt)$', 'Interpreter', 'latex', 'FontSize', 12)
    leg21 = legend('Location', 'southeast');
    grid on

    % salva a figura no diretorio especificado na primeira linha deste arquivo
    %saveas(fig1, fullfile(caminho_para_diretorio, nome_fig_1));

    % fecha a figura 1
    %close(fig1);


    %%%%%%%%%% CONFIGURACOES DA FIGURA 2 %%%%%%%%%%
    % cria a figura 2 sem exibi-la
    fig2 = figure('Visible', 'off');

    hold on
    plot(new_va_exp,new_vt,'x', 'DisplayName', 'Tensão Va experimental')
    plot(x,polyval(new_coef,x), 'DisplayName', 'Polinômio linear ajustado')
    title('Regiao linear de $V_{t}$ em funcao de $V_{a}$', 'Interpreter', 'latex', 'FontSize', 14)
    xlabel('$Va_{exp} \,\, [V]$', 'Interpreter', 'latex', 'FontSize', 12)
    ylabel('$Vt \,\, [V]$', 'Interpreter', 'latex', 'FontSize', 12)
    leg2 = legend('Location', 'southeast');
    grid on

    % adiciona o valor da inclinacao da reta
    txt = ['Inclinacao $K_{t}$: ', num2str(Kt)];
    text(7, 8, txt,'Interpreter', 'latex', 'FontSize', 12);

    % salva a figura no diretorio especificado na primeira linha deste arquivo
    %saveas(fig2, fullfile(caminho_para_diretorio, nome_fig_2))

    % fecha a figura 2
    %close(fig2);
