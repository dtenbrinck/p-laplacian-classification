%% Copyright (c) 2015,2016,2017 Daniel Tenbrinck (see LICENSE.txt)
%
%  author: Daniel Tenbrinck
%  date: 17.11.2016
%
%  modified: Samira Kabri

classdef kNNGraph < Graph
    %kNNGRAPH Own subclass of class graph for epsilon ball graphs
    
    properties
    end
    
    methods
        
        % constructor taking any amount of arguments
        % ATTENTION: we assume the following input arguments:
        % kNNGraph(data,neighborhood,distanceFunction,weightFunction)
        function obj = kNNGraph(varargin)
            
            % call superclass constructor
            obj = obj@Graph();
            
            % if no input arguments are specified -> return empty graph
            if nargin == 0
                return;
            end
            
            % extract input arguments from varargin cell array
            data = varargin{1};
            neighborhood = varargin{2};
            distanceFunction = varargin{3};
            weightFunction = varargin{4};
            
            % get number of vertices from the given data
            obj.numberOfVertices = size(data.coordinates,1);
            
            % initialize vector of node indices
            obj.vertices = transpose(1:obj.numberOfVertices);
            
            % initialize matrix of node neighbors and respective offsets
            % -> due to the fixed amount of neighbors the structure is clear
            obj.nodeNeighbors = NaN * ones(obj.numberOfVertices,3);
            obj.nodeNeighbors(:,1) = obj.vertices;
            obj.nodeNeighbors(:,2) = (obj.nodeNeighbors(:,1) - 1) * neighborhood.numberOfNeighbors + 1;
            obj.nodeNeighbors(:,3) = neighborhood.numberOfNeighbors;
            
            % easily compute and set number of edges
            obj.numberOfEdges = obj.numberOfVertices * neighborhood.numberOfNeighbors;
            
            % initialize matrices for edges and edge weights
            obj.edges = NaN * ones(obj.numberOfEdges,2);
            obj.edgeWeights = NaN * ones(obj.numberOfEdges,1);
            
            % set first column of edges to node indices
            tmp = repmat(1:obj.numberOfVertices,neighborhood.numberOfNeighbors,1);
            obj.edges(:,1) = tmp(:);
            
            % save input arguments into graphProperties struct
            obj.graphProperties.neighborhood = neighborhood;
            obj.graphProperties.weightFunction = weightFunction;
            obj.graphProperties.distanceFunction = distanceFunction;
            
            
            % get k-nearest neighbors using a kdtree approach implemented in Matlab
            
            if strcmp(distanceFunction, "Euclidean")
                
                [indices_all, ~] = knnsearch(data.coordinates,data.coordinates,...
                    'k',neighborhood.numberOfNeighbors+1,...
                    'Distance', 'euclidean');
                indices_all = indices_all(:,2:neighborhood.numberOfNeighbors+1);
                
            elseif strcmp(distanceFunction, "Tangent")
                
                profile on
                [indices_all, D] = knnsearch(data.coordinates,data.coordinates,...
                    'k',neighborhood.numberOfNeighbors+1,...
                    'Distance', @tangent);
                indices_all = indices_all(:,2:neighborhood.numberOfNeighbors+1);
                D = D(:,2:neighborhood.numberOfNeighbors+1);
                profile viewer
                
            end
            
            % as the kd-tree object can only extract neighbors of single nodes
            % we have to loop over all vertices
            for u = 1:obj.numberOfVertices
                
                % extract indices of k-nearest neighbors from all indices
                indices = indices_all(u,:);
                
                % set edges accordingly
                obj.edges((u-1)*neighborhood.numberOfNeighbors+(1:neighborhood.numberOfNeighbors),2) = indices;
                
                % compute distance of k nearest neighbor points to current node
                if strcmp(distanceFunction, "Euclidean")
                    distances = repmat(data.coordinates(u,:),neighborhood.numberOfNeighbors,1) - data.coordinates(indices,:);
                    distances = sqrt(sum(distances.^2,2));
                elseif strcmp(distanceFunction, "Tangent")
                    distances = D(u,:);
                end
                
                
                % compute and set edge weights accordingly
                obj.edgeWeights((u-1)*neighborhood.numberOfNeighbors+[1:neighborhood.numberOfNeighbors])...
                    = obj.graphProperties.weightFunction.function(distances);
            end
        end
        
        %
        function neighbor_indices = getNeighbors(obj,node_index)
            neighbor_indices = obj.edges(obj.edges(:,1) == node_index,2);
        end
        
        function weights = getWeights(obj,node_index)
            weights = obj.edgeWeights(obj.edges(:,1) == node_index);
        end
        
    end
end

