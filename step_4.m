% Computer Vision Programming Assignment 2
% 20175003 Sunghyun Kang
% Step 4, Triangulation
% You have to run step_3.m before running this code

% add path
addpath('Camera_Visualization');
addpath('Data');
addpath('vlfeat-0.9.21-my');

%% Get 3D points from Camera pose & correspondences
% Retrieve all the camera matrix candidates

[P_candidate_1, tri] = Triangulation(P_1, matches, norm_F3, norm_F4);
[P_candidate_2, tri] = Triangulation(P_2, matches, norm_F3, norm_F4);
[P_candidate_3, tri] = Triangulation(P_3, matches, norm_F3, norm_F4);
[P_candidate_4, tri] = Triangulation(P_4, matches, norm_F3, norm_F4);

if P_candidate_1
    P = P_candidate_1;
elseif P_candidate_2
    P = P_candidate_2;
elseif P_candidate_3
    P = P_candidate_3;
elseif P_candidate_4
    P = P_candidate_4;
else
    error("NO CANDIDATES!");
end