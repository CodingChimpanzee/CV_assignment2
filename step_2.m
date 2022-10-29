% Computer Vision Programming Assignment 2
% 20175003 Sunghyun Kang
% Step 2, Estimate matrix E with RANSAC,
% Also, decompose essntial matrix E to camera extrinsic
% You have to run step_1.m first before running step 2.

% add path
addpath('Camera_Visualization');
addpath('Data');
addpath('vlfeat-0.9.21-my');
addpath('Step2');

%% Essential matrix E estimation based on scores
E_best = BEST_SCORES_RANSAC(norm_F3, norm_F4, matches, scores);

%% Using RANSAC, get the most optimal E
E = RANSAC(norm_F3, norm_F4, matches);