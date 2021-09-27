function [bestlabels, table, perc] = classifyMnist(G, p, lambda, labeledIndices)

reguL = zeros(10000,10);

labeled = zeros(10000,1);

%% initialize f0, run classification for all 10 labels
labeled(seeds,:) = -1;
for i = 1:10
    f0(seeds(((i-1)*labperc+1):(i*labperc))) = 1;
    reguL(:,i) = myClassifier(G,f0,p,lambda);
    f0(seeds(((i-1)*labperc+1):(i*labperc))) = -1;
end

labels = zeros(10000,1);
% right = zeros(10,1);
for i = 1:10000
    [~,labels(i)] = max(reguL(i,:));
    l = labels(i);
    labels(i) = labels(i)-1; %%right indexed label
%     if labels(i) == reallabels(i)
%         right(l) = right(l)+1;
%     end
end

end

