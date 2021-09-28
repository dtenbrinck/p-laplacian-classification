%% CLEAN UP
clc; clear; close all;

% add needed subdirectories
addpath('./data');
addpath(genpath('./graph_functions'));
addpath('./savedData');

%% Output configuration
sLine = strcat(repmat('^',1,50),'\n');
cLine = strcat(repmat('.',1,50),'\n');

%% LOAD SETTINGS FOR DATA AND GRAPH CONSTRUCTION AND GET LABELS

% LOAD MNIST DATA (10k images)
%%each column represents a 28x28 image
images = loadMNISTImages('t10k-images.idx3-ubyte');
[lGroups, realLabels] = labelgroups('t10k-labels.idx1-ubyte');

%% SET COORDINATES
%%each picture's gray values are treated as coordinates in 784-dim space
coordinates = images';

% SET GRAPH PROPERTIES FOR POINT CLOUDS
% define data properties
data.coordinates = coordinates;

% define parameters for k nearest neighbor search
neighborhood.type = 'kNN';
neighborhood.numberOfNeighbors = 7;

% define distance function NO INFLUENCE ON TANGENT DISTANCE
distanceFunction = 'Euclidean'; % 'Euclidean' or 'Tangent'

% define weight function
weightFunction.function = @(x)10*exp(-x.^2./10e+6);

% parameters for the diffusion algorithm
p = 2;
lamda = 10;


%% CONSTRUCT GRAPH FROM DATA

fprintf(sLine,'\n');
fprintf('Building graph from MNIST dataset.\n');
fprintf(cLine,'\n');
tic

% call constructor for kNN graphs
G = kNNGraph(data, neighborhood, distanceFunction, weightFunction);
 
% compute the adjacency matrix and store it
G = G.computeAdjacencyMatrix;
 
% symmetrize kNN graph
G = G.symmetrizeGraph;

fprintf('Finished after %f seconds.\n', toc);

%% Get labeled Data
numLabels = 100;
numInClass = [980, 1135, 1032, 1010, 982, 892, 958, 1028, 974, 1009]';
labeledIndices = labelIndices(numLabels, numInClass, lGroups);

%% Classification
fprintf(sLine,'\n');
fprintf('Performing classfication via diffusion.\n');
fprintf(cLine,'\n');

tic
labels = classifier(G, p, lamda, labeledIndices, 1e-8);
t = toc;
fprintf('Finished diffusion after %s seconds.\n', t);
fprintf(cLine,'\n');

%% Test Accuracy
accuracy = test(labels, realLabels);
fprintf(sLine,'\n');
fprintf('The classification had a accuracy of %f .\n', round(100*accuracy,2));
