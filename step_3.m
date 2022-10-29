% Computer Vision Programming Assignment 2
% 20175003 Sunghyun Kang
% Step 3, Essential matrix decomposition
% You have to run step_2.m before running this code

% add path
addpath('Camera_Visualization');
addpath('Data');
addpath('vlfeat-0.9.21-my');
addpath('Step5');

%% Essential matrix decomposition to [R|T]
% From the previous essential matrix E, 
% we have to struct camera matrix P

% Get U, W, V, and u_3
W = [0 -1 0; 1 0 0; 0 0 1];
Z = [0 1 0; -1 0 0; 0 0 0];
[U, S, V] = svd(E);
u_3 = U * [0;0;1];

% Get four candidates for camera matrix
P_1 = [(U*W*transpose(V)) u_3];
P_2 = [(U*W*transpose(V)) -u_3];
P_3 = [U*transpose(W)*transpose(V) u_3];
P_4 = [U*transpose(W)*transpose(V) u_4];

% Now evaluate those matrix to get real P
if Decomposition_estimate(P_1)
    P = P_1;
elseif Decomposition_estimate(P_2)
    P = P_2;
elseif Decomposition_estimate(P_3)
    P = P_3;
elseif Decomposition_estimate(P_4)
    P = P_4;
else
    error("There is no candidate for camera matrix!");
end