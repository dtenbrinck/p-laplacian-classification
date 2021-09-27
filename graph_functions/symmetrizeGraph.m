function G = symmetrizeGraph(G)

% add all reverse edges and remove duplicates
[G.edges,ia] = unique(cat(1,G.edges,G.edges(:,2:-1:1)),'rows');

% add all edge weights again
tmp = cat(1,G.edgeWeights,G.edgeWeights);

% remove all duplicates
G.edgeWeights = tmp(ia);

end

