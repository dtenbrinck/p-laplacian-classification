function [labeledIndices, numLabels] = labelIndices(labelPercentage, numInClass, lGroups)
%labelIndices - Randomly determines labeled indices for multiclass 
%classification.
%
% labeledIndices = labeledIndices(numLabels)
%
% Input:
%   numLabels: number of indices to label in *each* class
%   numInClass: number of elements in each class
%   lGroups: labeling groups for each class
%
% Outputs:
%   labeledIndices: An (10, numLables) 

% number of Labels for each group
numLabels = floor(labelPercentage * numInClass);

% initialize labeled indices
labeledIndices = zeros(length(numInClass), max(numLabels));

%% Loop over all classes
for i = 1:length(numInClass)
    % random permutation of possible inidices
    perm = randperm(numInClass(i));
    
    % set labeled indices
    labeledIndices(i, 1:numLabels(i)) = lGroups(i, perm(1:numLabels(i)));
end
end