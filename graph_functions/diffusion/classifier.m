function labels = classifier(G, p, lambda, labeledIndices, relDiff)
%classifier - labeles unlabelded data for a multiclass classifiaction
%
% labels = classifier(G, p, lambda, labeledIndices, numVerts, relDiff)
%
% Input:
%   G: A graph instance, with numVerts indices
%   p: parameter of the p-Laplcian
%   lambda: controls influence of the data fidelity term
%   labeledIndices: array of size (numClasses, numLabels) that stores the
%                   indices of the labeled data for each class
%   relDiff: relative stopping criterion for the underlying difffusion
%            iteration
%
% Outputs:
%   labels: labeling for each vertex of the size (numberOfVertices, 1)
%
% Authors: Daniel Tenbrinck, Samira Kabri, Tim Roith, 
%          Friedrich--Alexander-Universitaet Erlangen--Nuernberg

[numClasses, ~]  = size(labeledIndices);

%% initalize arrays for labeld and unlabeld data
% unlabeld stores a likelihood for each class therefore it has an 
% additional dimesnion
unlabeled = zeros(numClasses, G.numberOfVertices);
labeled = zeros(G.numberOfVertices, 1);

%% initialize f0, run classification for all 10 labels
% set all labeld indices to -1
labeled(labeledIndices(:)) = -1;

%% i runs over all classes
for i = 1:numClasses
    % set all labeled indices of this class to 1
    labeled(labeledIndices(i, :)) = 1;
    
    % perform classification
    unlabeled(i, :) = iterateDiffusion(G, labeled, p, lambda, relDiff);
    
    % reset the labelling
    labeled(labeledIndices(i, :)) = -1;
end

% assign labels as the label with the highest percentage
labels = max(unlabeled);
end

