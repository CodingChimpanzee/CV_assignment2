% Computer Vision Programming Assignment 2
% 20175003 Sunghyun Kang
% Problem 3, Essential matrix decomposition
% You have to run problem_2.m before running this code

% add path
addpath('Camera_Visualization');
addpath('Data');
addpath('vlfeat-0.9.21-my');
addpath('Step5');

%% Essential matrix decomposition to [R|T]
% From the previous essential matrix E, 
% we have to struct camera matrix P

% Get U, W, V, and u_3

W = [0 -1 0; 1 0 0; 0 0 0];
Z = [1 0 0; 0 1 0; 0 0 0] * W;

[U, S, V] = svd(E);