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

[P_candidate_1, z_1, c_1] = Triangulation(P_1, E, real_matches, Fa, Fb);
[P_candidate_2, z_2, c_2] = Triangulation(P_2, E, real_matches, Fa, Fb);
[P_candidate_3, z_3, c_3] = Triangulation(P_3, E, real_matches, Fa, Fb);
[P_candidate_4, z_4, c_4] = Triangulation(P_4, E, real_matches, Fa, Fb);

c = max([c_1, c_2, c_3, c_4]);

if c == c_1
    P = P_candidate_1;
    z = z_1;
elseif c == c_2
    P = P_candidate_2;
    z = z_2;
elseif c == c_3
    P = P_candidate_3;
    z = z_3;
elseif c == c_4
    P = P_candidate_4;
    z = z_4;
else
    error("NO CANDIDATES!");
end

Z = z(1:3, :);

%% Final step, plot the result
C = zeros(3, length(Z));
write_ply("test.ply", Z, C);