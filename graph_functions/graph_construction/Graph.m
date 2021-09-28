%% Copyright (c) 2015,2016 Daniel Tenbrinck (see LICENSE.txt)
%
%  author: Daniel Tenbrinck
%  date: 17.11.2016
%
classdef Graph
  %GRAPH Own base class for graphs
  
  properties
    % scalars holding information about number of vertices and edges in graph
    numberOfVertices;
    numberOfEdges;
    
    % vector of size numberOfVertices x 1 holding node indices
    vertices;
    
    % vector of size numberOfEdges x 2 holding edges in form [node1, node2]
    % representing an edge "node1 -> node2"; note that in undirected graphs 
    % there will also be an edge "node2 -> node1"
    % ATTENTION: always make sure edges(:,1) is sorted increasingly
    edges;
    
    % vector of size numberOfEdges x 1 holding weights of respective edges
    % ATTENTION: always make sure edgeWeights(i) gives the weight for edges(i,:)
    edgeWeights;
    
    % vector of size numberOfVertices x 3 holding: 1. the node indices, 2.
    % the corresponding offset for the first row in edges, 3. the number of
    % neighbors
    nodeNeighbors;
    
    % struct containing all meta information about the graph, e.g.,
    % neighborhood, distanceFunction, weightingFunction
    graphProperties;
    
    % the adjacencyMatrix for the graph, only gets computetet when the
    % method getAdjacencyMatrix is called
    adjacencyMatrix;
  end
  
  methods
    
    % standard constructor initializing an empty graph
    function obj = Graph()
      obj.numberOfVertices = 0;
      obj.numberOfEdges = 0;
      obj.vertices = zeros(0,1);
      obj.edges = zeros(0,2);
      obj.edgeWeights = zeros(0,1);
      obj.nodeNeighbors = zeros(0,3);
      obj.graphProperties = [];     
    end
    
    % adds a specified amount of vertices to the graph without overwriting 
    % other vertices
    % ATTENTION: make sure node indices are continued properly
    function addVertices(amountOfVertices)
      % TODO
    end
      
    % adds an edge with specified weight to the graph
    % ATTENTION: make sure edge and weight are added to edges and
    % edgeWeights properly and 0 < weight <= 1 and nodeNeighbors is adapted
    function addEdge(u,v,weight)
      % TODO
    end
    
    % removes an edge with index e from the graph
    % ATTENTION: make sure the corresponding entries in edges and
    % edgeWeights are removed and nodeNeighbors is adapted
    function removeEdge(e)
      % TODO
    end
    
    % assembles and returns the matrix corresponding to the Laplacian operator
    % ATTENTION: incorporate correct boundary conditions for grid graphs
    function laplacian = getLaplacianMatrix()
      % TODO
    end
    
    % gets neighbor indices of a specified node u
    % ATTENTION: this is a fallback method which gets probably overwritten 
    % by subclasses of this class
    function neighbor_indices = getNeighbors(obj,u)
      [low_index, up_index] = binarySearch(obj.edges(:,1),u,u);
      neighbor_indices = obj.edges(low_index:up_index,2);
    end
    
    % gets weights of edges to the neighbors of a specified node u
    % ATTENTION: this is a fallback method which gets probably overwritten 
    % by subclasses of this class
    function weights = getWeights(obj,u)
      [low_index, up_index] = binarySearch(obj.edges(:,1),u,u);
      weights = obj.edgeWeights(low_index:up_index);
    end
    
    function obj = computeAdjacencyMatrix(obj)
    %computeAdjacencyMatrix Computes a (in many cases) sparse matrix encoding
    % adjacency of graph vertices by the corresponding edge weights.
    %
    % Authors: Daniel Tenbrinck, Samira Kabri, Tim Roith, 
    %          Friedrich--Alexander-Universitaet Erlangen--Nuernberg

    % initialize sparse matrix from edge weights
    obj.adjacencyMatrix = sparse(obj.edges(:,1), obj.edges(:,2), obj.edgeWeights);
    end
    
    function obj = symmetrizeGraph(obj)
    %symmetrizeGraph symmetrize a graph instance
    %
    % Authors: Daniel Tenbrinck, Samira Kabri, Tim Roith, 
    %          Friedrich--Alexander-Universitaet Erlangen--Nuernberg

    % add all reverse edges and remove duplicates
    [obj.edges,ia] = unique(cat(1,obj.edges,obj.edges(:,2:-1:1)),'rows');

    % add all edge weights again
    tmp = cat(1,obj.edgeWeights,obj.edgeWeights);

    % remove all duplicates
    obj.edgeWeights = tmp(ia);
    end
  end
  
end

