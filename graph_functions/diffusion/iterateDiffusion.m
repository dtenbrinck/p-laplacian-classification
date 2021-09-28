function f = iterateDiffusion(G, f0, p, lambda, relDiff)
%iterateDiffusion - performs an iterative diffusive scheme for label
%propagation
%
% f = iterateDiffusion(G, f0, p, lambda, relDiff)
%
% Input:
%   G: A graph instance, with numVerts indices
%   f0: intial assignment of size (numVerts, n)
%   p: parameter of the p-Laplcian
%   lambda: controls influence of the data fidelity term
%   relDiff: the code uses this parameter for a termination crierion, if
%   the change to the last iterate in norm is smaller than this value

%
% Outputs:
%   f: a new assignemnt after information propagation of size (numVerts, n)
%
% Authors: Daniel Tenbrinck, Samira Kabri, Tim Roith, 
%          Friedrich--Alexander-Universitaet Erlangen--Nuernberg

% make sure to run into first loop
diff = relDiff + 1;

% assign f
f = f0;
%% main loop
while(diff > relDiff)
    fold = f;
    f = GaussJacobiDiffusion(G, f, f0, p, lambda);
    diff = norm(f - fold);
end
end