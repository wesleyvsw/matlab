a = [0:0.3:5];
b =[5:0.5:20];
v_sugerido = [a b];
v_medido1 = [0 0.341 0.740 0.885 1.25 1.59 1.82 2.16 2.37 2.74 3.03 3.37 3.6 3.82 4.2 4.55 4.86 5.12 5.47 6.01 6.59 7.06 7.55 8.14 8.60 9.10 9.58];
v_medido2 = [10.1 10.7 11.1 11.6 12.2 12.7 12.7 13.1 14.2 14.6 15.2 15.7 16.2 16.6 17.2 17.6 18.4 18.8 19.3 19.8 20.4];
v_medido = [v_medido1 v_medido2];
v_tacografo1 = [0 0 0 0 0 0 0 0 0 1.07 1.4 1.93 2.42 2.7 3.10 3.77 3.99 4.23 4.83 5.43 6.01 6.72 7.21 8.15 8.76 9.55 10.2 10.9 11.6 12.1 12.8 13.6 14.2];
v_tacografo2 = [14.2 14.9 16.4 17.1 17.8 18.4 18.9 19.6 20.2 21.2 21.9 22.6 23.2 24.2 24.9];
v_tacografo =[v_tacografo1 v_tacografo2];
w_rpm1 = [0 0 0 0 0 0 0 0 0 75 90.5 130 149.6 168 195 229 252.2 265.1 305 346 378 419.9 447 510 558 597.5 645 683 730 765 811 860 905];
w_rpm2 = [904 946 1039 1090 1133 1166 1210 1251 1294 1345 1397 1437 1484 1540 1588];
w_rpm = [w_rpm1 w_rpm2];

b =v_tacografo

%Vetor de "1" no matlab
v_um = ones(1,48);
%matriz A para uma função linear
A = [v_medido(:),v_um(:)];
%A_2 para uma função quadratica
v_medido_quad = v_medido.^2;
A_2 = [v_medido_quad(:),v_medido(:),v_um(:)];
%Resultado funcao linear
resultado = inv(A'*A)*A'*b';
%Resultado2 funcao quadratica
resultado2 = inv(A_2'*A_2)*A_2'*b';

%scatter(v_medido,v_tacografo)
%Não ajustei para a região não linear. Preciso renover os vetores elementos
%com zero
