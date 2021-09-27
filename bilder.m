clc;
clear;
close all;

load('easyGraph.mat', 'easyG');
load('easyLabels.mat', 'easyL'); 

%% parameters
% specific number of iterations
its = 10;
% or until convergence? 
conv = false;

%% for plots
A = computeAdjacencyMatrix(easyG);
T = graph(A);
n = 1:90;

%% plot ground truth labels
figure('Name', 'ground truth');
h = plot(T);
% make 0 black
highlight(h, n(easyL(n) == 0), 'NodeColor', 'k'); 
% make 3 green
highlight(h, n(easyL(n) == 3), 'NodeColor', 'g');
% make 7 red
highlight(h, n(easyL(n) == 7), 'NodeColor', 'r'); 
% highlight known nodes
highlight(h, n(easyL(n) == 0 | easyL(n) == 3 | easyL(n) == 7));


%% initial labels

seeds = [5,51,78];

%% plot seeds
figure('Name', 'seeds');
g = plot(T);
% make 0 black
highlight(g, seeds(1), 'NodeColor', 'k'); 
% make 3 green
highlight(g, seeds(2), 'NodeColor', 'g');
% make 7 red
highlight(g, seeds(3), 'NodeColor', 'r'); 
% highlight known nodes
highlight(g, seeds);


%% seed functions
F0 = zeros(90,3);
for i = 1:3
    F0(seeds(i),:) = -1;
    F0(seeds(i), i) = 1;
end

%% compute labels after 'its' iterations or after 'conv' = convergence
[~,l] = anotherone(easyG, F0, its, conv);

%% plot progress
figure('Name', 'progress');
f = plot(T);
% make 0 black
highlight(f, n(l(n) == 1), 'NodeColor', 'k'); 
% make 3 green
highlight(f, n(l(n) == 2), 'NodeColor', 'g');
% make 7 red
highlight(f, n(l(n) == 3), 'NodeColor', 'r'); 
% highlight known nodes
highlight(f, n(l(n) == 1 | l(n) == 2 | l(n) == 3));





