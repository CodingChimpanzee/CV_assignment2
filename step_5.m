% Computer Vision Programming Assignment 2
% 20175003 Sunghyun Kang
% Step 5, Growing Step
% You have to run all previous steps before running this code

% add path
addpath('Camera_Visualization');
addpath('Data');
addpath('vlfeat-0.9.21-my');
addpath('Step5');

%% Growing step: Randomly select three points
% The same thing that we done in RANSAC

% The set of match points would be the points that we got
% in previous RANSAC. Hence we have to choose three random
% points from that set.

[idx_1, idx_2, idx_3] = randi(length(real_matches), 3);
p_1 = 
