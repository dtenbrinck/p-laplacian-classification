function [reguL, labels] = anotherone(G, F, its, conv)



if conv
    reguL = zeros(90,3);
    for i = 1:3
        reguL(:,i) = myEasyClassifier(G,F(:,i),1,10, its, conv);
    end
else
    %% extra 0-column to only label 'reached' nodes
    reguL = zeros(90,4);
    for i = 1:3
        reguL(:,i+1) = myEasyClassifier(G,F(:,i),1,10, its, conv);
    end
end

labels = zeros(90,1);
for i = 1:90
[~,labels(i)] = max(reguL(i,:));
end

if ~conv
    labels = labels -1;
end

end

