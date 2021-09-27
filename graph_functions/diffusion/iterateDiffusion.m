function f = iterateDiffusion(G, f0, p, lambda, relDiff)
%iterateDiffusion - performs an iterative diffusive scheme for label
%propagation
%
% f = iterateDiffusion(G, f0, p, lambda, relDiff)
%
% Input:
%   G: A graph instance
%   f0: intial assignment
%   p: parameter of the p-Laplcian
%   lambda: controls influence of the data fidelity term
%   relDiff: the code uses this parameter for a termination crierion, if
%   the change to the last iterate in norm is smaller than this value

%
% Outputs:
%   f: a new assignemnt after information propagation
%
% Author: Daniel Tenbrinck, FAU

% make sure to run into first loop
diff = relDiff + 1;

% assign f
f = f0;
%% main loop
while(diff > relDiff)
    falt = f;
    f = gaussjacobidiffusion(f, f0, p, lambda, G);
    diff = norm(f - falt);
end
end