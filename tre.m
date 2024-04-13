function [num,den] = tre(nk,dk,ng,dg)
num = conv(dk,dg);
den = soma_pol(conv(nk,ng),conv(dk,dg));

