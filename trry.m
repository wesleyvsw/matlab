%(Quando chamar a função, utilizar [v1,v2] = trry(.....) --> resolve o problema do Ans)%
function [nume,deno] = trry(nk,dk,ng,dg)
nume = conv(nk,ng);
deno = soma_pol(conv(nk,ng),conv(dk,dg));



