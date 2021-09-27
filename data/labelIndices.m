function labeledIndices = labelIndices(numLabels, anz, lGroups)
%labelIndices - Randomly determines labeled indices for multiclass 
%classification.
%
% labeledIndices = labeledIndices(numLabels)
%
% Input:
%   numLabels: number of indices to label in *each* class
%   anz: number of elements in each class
%   lGroups: labeling groups for each class
%
% Outputs:
%   labeledIndices: An (10, numLables) 

% initialize labeled indices
labeledIndices = zeros(length(anz), numLabels);

%% Loop over all classes
for i = 1:length(anz)
    % random permutation of possible inidices
    perm = randperm(anz(i));
    
    % set labeled indices
    labeledIndices(i, :) = lGroups(i, perm(1:numLabels));
end
end