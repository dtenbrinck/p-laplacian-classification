function accuracy = test_accuracy(labels, realLabels)
%test_accuracy - test labels against realLables
%
% accuracy = test(labels, realLables)
%
% Input:
%   labels: computed labels
%   realLabels: actualLabels
%
% Outputs:
%   accuracy: the accuracy of the labeling
%
% Authors: Daniel Tenbrinck, Samira Kabri, Tim Roith, 
%          Friedrich--Alexander-Universitaet Erlangen--Nuernberg

accuracy = sum(labels==realLabels)/length(labels);
end
