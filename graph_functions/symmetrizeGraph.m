function G = symmetrizeGraph(G)

[G.edges,ia] = unique(cat(1,G.edges,G.edges(:,2:-1:1)),'rows');

tmp = cat(1,G.edgeWeights,G.edgeWeights);
G.edgeWeights = tmp(ia);

end

