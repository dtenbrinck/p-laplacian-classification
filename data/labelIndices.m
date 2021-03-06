function labeledIndices = labelIndices(numLabels, numInClass, lGroups)
%labelIndices - Randomly determines labeled indices for multiclass 
%classification.
%
% labeledIndices = labeledIndices(labelPercentage, numInClass, lGroups)
%
% Input:
%   numLabels: number of indices to label in *each* class
%   numInClass: number of elements in each class
%   lGroups: labeling groups for each class
%
% Outputs:
%   labeledIndices: An (numClasses, numLables) array, where in the ith row 
%                   stores the labeled indices for the ith class. Here 
%                   the number of Classes numClasses is implicitly given by
%                   numInClass.
%
% Author: Daniel Tenbrinck, FAU

% initialize labeled indices
labeledIndices = -ones(length(numInClass), numLabels);

%% Loop over all classes
for i = 1:length(numInClass)
    % random permutation of possible inidices
    perm = randperm(numInClass(i));
    
    % set labeled indices
    labeledIndices(i, :) = lGroups(i, perm(1:numLabels));
end
end