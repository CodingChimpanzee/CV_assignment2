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
addpath('match_plot');

%% Essential matrix E estimation based on scores
E_best = BEST_SCORES_RANSAC(norm_Fa, norm_Fb, matches, scores);

%% Using RANSAC, get the most optimal E
[E, real_matches] = RANSAC(norm_Fa, norm_Fb, matches);

%% Draw the map that shows the matches (After)
% Done by other source (See the "match_plot" folder)

ia_coord = [];
ib_coord = [];

for i = randi(length(real_matches), 1000)
    idx_a = real_matches(1, i);
    idx_b = real_matches(2, i);
    ia_coord = [ia_coord; Fa(1, idx_a) Fa(2, idx_a)];
    ib_coord = [ib_coord; Fb(1, idx_b) Fb(2, idx_b)];
end
match_plot(i_a, i_b, ia_coord, ib_coord);