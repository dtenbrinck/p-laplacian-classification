% clean up
clc; clear; close all;

% add needed subfolders
addpath('./data');
addpath(genpath('./graph_functions'));
addpath('./savedData');

%% LOAD SETTINGS FOR DATA AND GRAPH CONSTRUCTION

% LOAD MNIST DATA
%%each coloumn represents a 28x28 picture
images = loadMNISTImages('t10k-images.idx3-ubyte');

%%GET LABELS
[L, labels] = labelgroups('t10k-labels.idx1-ubyte');

%%SET COORDINATES
%%each picture's gray values are treated as coordinates in 784-dim space
coordinates = images';


% SET GRAPH PROPERTIES FOR POINT CLOUDS

% define data properties
data.type = 'point_cloud';
data.dimDomain = 3;
data.dimRange = 1;
data.coordinates = coordinates;

% define parameters for k nearest neighbor search
neighborhood.type = 'kNN';
neighborhood.numberOfNeighbors = 5;

% define distance function NO INFLUENCE ON TANGENT DISTANCE
distanceFunction.innerNorm = @(x)(x.^2);
distanceFunction.outerNorm = @(x)(sqrt(x));

% define weight function
weightFunction.function = @(x)100*exp(-x.^2./10e+5);


%% CONSTRUCT GRAPH FROM DATA

 tic
 G = constructGraph(data,neighborhood,distanceFunction,weightFunction); 
 toc

%load('goodweights.mat', 'G'); % tangent distance with w(x) = 100*exp(-x.^2./10e+5)
%load('badweights.mat', 'Gdis'); % tangent distance with w(x) = 1
%load('euclidean.mat', 'Ge');  % euclidean distance with 'good' weight function

%% PERFORM CLASSIFICATION

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