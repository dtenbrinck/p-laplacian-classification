%% Copyright (c) 2015,2016 Daniel Tenbrinck (see LICENSE.txt)
%
%  author: Daniel Tenbrinck
%  date: 17.11.2016
%
function G = constructGraph(data,neighborhood,distanceFunction,weightFunction)
%CONSTRUCTGRAPH Constructs a graph from given data based on chosen criteria.
% This is a wrapper function, which chooses the correct constructor for
% constructing a graph from given data and based on the defined settings.
% 
%   Input: data - struct; should be defined in graph setting script
%          neighborhood - struct; should be defined in graph setting script
%          distanceFunction - struct; should be defined in graph setting script
%          weightFunction - struct; should be defined in graph setting script
%
%   Output: G - graph object with all necessary properties set
%
% define implementation of kd tree

implementation = 'matlab'; % 'matlab' or 'cpp'

% check the chosen type of graph
switch lower(neighborhood.type)
  case 'knn' % k nearest neighbor graph
    
    % call constructor for kNN graphs
    G = kNNGraph(data,neighborhood,distanceFunction,weightFunction,implementation);
    
    % symmetrize graph
    G = symmetrizeGraph(G);
    
  case 'epsilon' % epsilon ball graphs
    
    % call constructor for epsilon ball graphs
    G = EpsBallGraph(data,neighborhood,distanceFunction,weightFunction,implementation);
    
  case 'grid' % grid graphs
    
    % this graph type is only valid on grid structured data
    assert(strcmp(data.type,'grid'));
    
    % call constructor for grid graphs
    G = GridGraph(data,neighborhood,distanceFunction,weightFunction);
    
  otherwise % unknown graph type
    
    % throw an error message
    error('Unknown neighborhood.type specified!');
   
end

end