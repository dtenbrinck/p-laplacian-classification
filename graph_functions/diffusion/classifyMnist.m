function [bestlabels, table, perc] = classifyMnist(G,p,lambda,reallabels, L, labperc)

load('savedSeeds10.mat','seedmat');


highest = 0;
iter = 10;

% Known labels in %:
stepsize = 100/labperc;

%% change anz for different data set than mnist-test-set
anz = [980, 1135, 1032, 1010, 982, 892,958,1028,974,1009]';

%  seeds = zeros(labperc*10,1);
%  seedmat = zeros(labperc*10,iter);
 table = [anz,zeros(10,1)];
 perc = zeros(iter,1);
 for j = 1:iter
   
%%precomputed random seeds   
seeds = seedmat(1:stepsize:1000,j);


% 
% seedmat(:,j) = seeds;

%to only label nodes with positive 'probabilities': make reguL 10000x11
reguL = zeros(10000,10);

f0 = zeros(10000,1);

%%initialize f0, run classification for all 10 labels
f0(seeds,:) = -1;
for i = 1:10
    f0(seeds(((i-1)*labperc+1):(i*labperc))) = 1;
    reguL(:,i) = myClassifier(G,f0,p,lambda);
    f0(seeds(((i-1)*labperc+1):(i*labperc))) = -1;
end

labels = zeros(10000,1);
right = zeros(10,1);
for i = 1:10000
    [~,labels(i)] = max(reguL(i,:));
    l = labels(i);
    labels(i) = labels(i)-1; %%right indexed label
    if labels(i) == reallabels(i)
        right(l) = right(l)+1;
    end
end
perc(j) = sum(right);
if perc(j)>= highest
table = [anz, right];
bestlabels = labels;
highest = perc(j);
end
%to check if iteration is converging
%disp(j)
 end
end

