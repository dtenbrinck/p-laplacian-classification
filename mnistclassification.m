%% Copyright (c) 2015,2016,2017 Daniel Tenbrinck (see LICENSE.txt)
%
%  Testing script for building graphs from data given as point clouds
%  and performing spectral clustering based on the graph structure.
%
%  author: Daniel Tenbrinck
%  date: 18.03.2017
%
%
%% INITIALIZATION

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



