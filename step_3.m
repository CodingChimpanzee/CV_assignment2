% Computer Vision Programming Assignment 2
% 20175003 Sunghyun Kang
% Step 3, Essential matrix decomposition
% You have to run step_2.m before running this code

% add path
addpath('Camera_Visualization');
addpath('Data');
addpath('vlfeat-0.9.21-my');

%% Essential matrix decomposition to [R|T]
% From the previous essential matrix E,
% we have to struct camera matrix P

% Get U, W, V, and u_3
W = [0 -1 0; 1 0 0; 0 0 1];
[U, S, V_t] = svd(E);
u_3 = U * [0;0;1];

% Transpose of V, W
W_t = transpose(W);

% Get four candidates for camera matrix
P_1 = [(U*W*V_t) u_3];
P_2 = [(U*W*V_t) -u_3];
P_3 = [(U*W_t*V_t) u_3];
P_4 = [(U*W_t*V_t) -u_3];