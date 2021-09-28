function f = GaussJacobiDiffusion(G, fOld, f0, p, lambda)
%GaussJacobiDiffusion - applies GauussJacobi scheme for label propagation
%and diffusion as proposed in [1].
%
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
% -------------------------------------------------------------------------
% References:
% [1]: Nonlocal Discrete Regularization on Weighted Graphs: 
%      A Framework for Image and Manifold Processing, IEEE 2008,
%      Abderrahim Elmoataz; Olivier Lezoray; Sebastien Bougleux

 %% Jacobi iteration proposed by Elmoataz et al.
W = G.adjacencyMatrix;

if (p==2)
    gamma = 2*W;
else
    gamma = computeGamma(W, fOld, p);
end
Ddiag = lambda + sum(gamma, 2);
b = lambda .* f0;

%jacobi step
f = (b + gamma * fOld)./Ddiag;   
end

function gamma = computeGamma(W, fOld, p)
  ngrad = computeNormedGradient(W,fOld, p);
  nGGrid = repmat(ngrad,1, size(fOld, 1));
  gamma = W.*(nGGrid+nGGrid');
end
