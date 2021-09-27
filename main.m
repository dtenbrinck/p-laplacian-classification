%% CLEAN UP
clc; clear; close all;

% add needed subdirectories
addpath('./data');
addpath(genpath('./graph_functions'));
addpath('./savedData');

%% LOAD SETTINGS FOR DATA AND GRAPH CONSTRUCTION

% LOAD MNIST DATA (10k images)
%%each column represents a 28x28 image
images = loadMNISTImages('t10k-images.idx3-ubyte');

%%GET LABELS
[lGroups, labels] = labelgroups('t10k-labels.idx1-ubyte');

%%SET COORDINATES
%%each picture's gray values are treated as coordinates in 784-dim space
coordinates = images';

% SET GRAPH PROPERTIES FOR POINT CLOUDS
% define data properties
data.coordinates = coordinates;

% define parameters for k nearest neighbor search
neighborhood.type = 'kNN';
neighborhood.numberOfNeighbors = 5;

% define distance function NO INFLUENCE ON TANGENT DISTANCE
distanceFunction = 'Euclidean'; % 'Euclidean' or 'Tangent'

% define weight function
weightFunction.function = @(x)100*exp(-x.^2./10e+5);


%% CONSTRUCT GRAPH FROM DATA

 fprintf('Building graph from MNIST dataset...');

 % call constructor for kNN graphs
 G = kNNGraph(data,neighborhood,distanceFunction,weightFunction);
 % symmetrize kNN graph
 G = symmetrizeGraph(G);
    
 fprintf('finished!\n');

%load('goodweights.mat', 'G'); % tangent distance with w(x) = 100*exp(-x.^2./10e+5)
%load('badweights.mat', 'Gdis'); % tangent distance with w(x) = 1
%load('euclidean.mat', 'Ge');  % euclidean distance with 'good' weight function

%% Get labeled Data
numLabels = 5;
numInClass = [980, 1135, 1032, 1010, 982, 892,958,1028,974,1009]';
labeledIndices = labelIndices(numLabels, numInClass, lGroups);

%% PERFORM CLASSIFICATION


tic
[~,~,perc] = classifyMnist(G, 2, 10, labeledIndices);
save('./savedData/goodweights12.mat', 'perc');
toc

[~,~,perc] = classifyMnist(G,2,10,labels, lGroups,50);
save('./savedData/goodweights52.mat', 'perc');

[l,t,perc] = classifyMnist(G,2,10,labels, lGroups,100);
save('./savedData/goodweights102.mat', 'perc');
save('./savedData/goodweights102table.mat', 't');
save('./savedData/goodweights102labels.mat', 'l');

[~,~,perc] = classifyMnist(Gdis,2,10,labels, lGroups,10);
save('./savedData/badweights12.mat', 'perc');

[~,~,perc] = classifyMnist(Gdis,2,10,labels, lGroups,50);
save('./savedData/badweights52.mat', 'perc');

[~,~,perc] = classifyMnist(Gdis,2,10,labels, lGroups,100);
save('./savedData/badweights102.mat', 'perc');

[~,~,perc] = classifyMnist(Ge,2,10,labels, lGroups,10);
save('./savedData/euclidean12.mat', 'perc');

[~,~,perc] = classifyMnist(Ge,2,10,labels, lGroups,50);
save('./savedData/euclidean52.mat', 'perc');

[~,~,perc] = classifyMnist(Ge,2,10,labels, lGroups,100);
save('./savedData/euclidean102.mat', 'perc');