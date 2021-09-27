
%% run mnistclassification first
mnistclassification;

addpath('./savedData');

[~,~,perc] = classifyMnist(G,2,10,labels, L,10);
save('./savedData/goodweights12.mat', 'perc');

[~,~,perc] = classifyMnist(G,2,10,labels, L,50);
save('./savedData/goodweights52.mat', 'perc');

[l,t,perc] = classifyMnist(G,2,10,labels, L,100);
save('./savedData/goodweights102.mat', 'perc');
save('./savedData/goodweights102table.mat', 't');
save('./savedData/goodweights102labels.mat', 'l');

[~,~,perc] = classifyMnist(Gdis,2,10,labels, L,10);
save('./savedData/badweights12.mat', 'perc');

[~,~,perc] = classifyMnist(Gdis,2,10,labels, L,50);
save('./savedData/badweights52.mat', 'perc');

[~,~,perc] = classifyMnist(Gdis,2,10,labels, L,100);
save('./savedData/badweights102.mat', 'perc');

[~,~,perc] = classifyMnist(Ge,2,10,labels, L,10);
save('./savedData/euclidean12.mat', 'perc');

[~,~,perc] = classifyMnist(Ge,2,10,labels, L,50);
save('./savedData/euclidean52.mat', 'perc');

[~,~,perc] = classifyMnist(Ge,2,10,labels, L,100);
save('./savedData/euclidean102.mat', 'perc');