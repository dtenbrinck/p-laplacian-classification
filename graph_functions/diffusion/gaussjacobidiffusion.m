function f = GaussJacobiDiffusion(G, fold, f0, p, lambda)
%GaussJacobiDiffusion - applies GauussJacobi schme for label propagation
%and diffusion
%
% f = GaussJacobiDiffusion(G, fold, f0, p, lambda)
%
% Input:
%   G: A graph instance, with numVerts indices
%   fold: last iterate of size (numVerts, n)
%   f0: initial iterate of size (numVerts, n)
%   p: parameter of the p-Laplcian
%   lambda: controls influence of the data fidelity term
%
% Outputs:
%   f: new iterate of size (numVerts, n)
%
% Authors: Daniel Tenbrinck, Samira Kabri, Tim Roith, 
%          Friedrich--Alexander-Universitaet Erlangen--Nuernberg

 %% Jacobi iteration proposed by Elmoataz et al.
[n,m] = size(f0);
W = G.adjacencyMatrix;

if (p==2)&&(m==1)
    gamma = 2*W;
else
    gamma = computeGamma(W, fold, p,n,m);
end
LR = -gamma;
Ddiag = lambda + sum(gamma,2);
b = lambda.*f0;

%jacobi step
f = (b-LR*fold)./Ddiag;   
end

function gamma = computeGamma(W, falt, p, n,m)
  ngrad = computeNormedGradient(W,falt,p,n,m);
  nGGrid = repmat(ngrad,1,n);
  gamma = W.*(nGGrid+nGGrid');
end
