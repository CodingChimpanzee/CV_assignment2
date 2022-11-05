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

[P_candidate_1, z_1, c_1, Co_1] = Triangulation(P_1, real_matches, norm_Fa, norm_Fb);
[P_candidate_2, z_2, c_2, Co_2] = Triangulation(P_2, real_matches, norm_Fa, norm_Fb);
[P_candidate_3, z_3, c_3, Co_3] = Triangulation(P_3, real_matches, norm_Fa, norm_Fb);
[P_candidate_4, z_4, c_4, Co_4] = Triangulation(P_4, real_matches, norm_Fa, norm_Fb);


% Check whether the triangulation has been done correctly
if c_1 ~= 0
    [temp, add_coord_1] = additional_tri(U*W*V_t, u_3, z_1);
    c_1 = c_1 + temp;
end
if c_2 ~= 0
    [temp, add_coord_2] = additional_tri(U*W*V_t, -u_3, z_2);
    c_2 = c_2 + temp;
end

if c_3 ~= 0
    [temp, add_coord_3] = additional_tri(U*W_t*V_t, u_3, z_3);
    c_3 = c_3 + temp;
end
if c_4 ~= 0
    [temp, add_coord_4] = additional_tri(U*W_t*V_t, -u_3, z_4);
    c_4 = c_4 + temp;
end

c = max([c_1, c_2, c_3, c_4]);

if c == c_1
    P = P_candidate_1;
    C = color_reshape(Co_1, I_a, Fa);
    z = [z_1(1:3, :)];
elseif c == c_2
    P = P_candidate_2;
    C = color_reshape(Co_2, I_a, Fa);
    z = [z_2(1:3, :)];
elseif c == c_3
    P = P_candidate_3;
    C = color_reshape(Co_3, I_a, Fa);
    z = [z_3(1:3, :)];
elseif c == c_4
    P = P_candidate_4;
    C = color_reshape(Co_4, I_a, Fa);
    z = [z_4(1:3, :)];
else
    error("NO CANDIDATES!");
end
%plotCamera3d(U*W_t*V_t, u_3);
scatter3(z(1, :), z(2, :), z(3, :));
%% Final step, plot the result
%C = zeros(3, length(z(1, :)));
write_ply("test.ply", z, C);