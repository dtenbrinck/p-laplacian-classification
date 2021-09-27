%% Copyright (c) 2015,2016,2017 Daniel Tenbrinck (see LICENSE.txt)
%
%  author: Daniel Tenbrinck
%  date: 29.03.2017
%
function [ W ] = computeAdjacencyMatrix( G )
%COMPUTEADJACENCYMATRIX Computes a (in many cases) sparse matrix encoding
% adjacency of graph vertices by the corresponding edge weights.

% initialize sparse matrix from edge weights
W = sparse(G.edges(:,1), G.edges(:,2), G.edgeWeights);

end