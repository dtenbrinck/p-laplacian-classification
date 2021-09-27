
function fneu = gaussjacobidiffusion(falt, f0, p, lambda, G)
 %%Make sure falt, f0, fneu are |V|xsomething
 %% Jacobi iteration proposed by Elmoataz et al.
[n,m] = size(f0);
W = computeAdjacencyMatrix(G);

if (p==2)&&(m==1)
    gamma = 2*W;
else
    gamma = computeGamma(W, falt, p,n,m);
end
LR = -gamma;
Ddiag = lambda + sum(gamma,2);
b = lambda.*f0;

%jacobi:
fneu = (b-LR*falt)./Ddiag;
    
end
