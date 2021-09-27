function [bestlabels, table, perc] = classifyMnist(G, p, lambda, labeledIndices, numVerts)
[numClasses, ~]  = size(labeledIndices);

%% initalize arrays for labeld and unlabeld data

% unlabeld stores a likelihood for each class therefore it has 
% an additional dimesnion
unlabeld = zeros(numClasses, numVerts);
labeled = zeros(numVerts,1);

%% initialize f0, run classification for all 10 labels
% set all labeld indices to -1
labeled(labeledIndices(:)) = -1;

%% i runs over all classes
for i = 1:10
    % set all labeled indices of this class to 1
    labeled(labeledIndices(i, :)) = 1;
    
    % perform classification
    unlabeld(i, :) = myClassifier(G, labeled, p, lambda);
    
    % reset the labelling
    labeled(labeledIndices(i, :)) = -1;
end

% assign labels as the label with the highest percentage
labels = max(unlabeled);
end

