function [num,den] = tru(nk,dk,ng,dg)
num = conv(nk,dg);
den = soma_pol(conv(nk,ng),conv(dk,dg));