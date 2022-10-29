% Computer Vision Programming Assignment 2
% 20175003 Sunghyun Kang
% Problem 1, import image and Extract features using SIFT
% Also, match features between two images

% Add path
addpath('Camera_Visualization');
addpath('Data');
addpath('vlfeat-0.9.21-my');

%% Import image 3 and 4 
% (turn into grayscale and extract as single type)
I_3 = imread('sfm03.jpg');
I_4 = imread('sfm04.jpg');

i_3 = single(rgb2gray(I_3));
i_4 = single(rgb2gray(I_4));

%% Extract features using SIFT
[F3, D3] = vl_sift(i_3);
[F4, D4] = vl_sift(i_4);

% Visualize the feature extraction result
imshow(I_3);
hold on;
f3 = vl_plotframe(F3);
set(f3, 'color', 'k', 'linewidth', 0.001);
hold off;

%% Match features between two images
[matches, scores] = vl_ubcmatch(D3, D4);

%% Normalize coordinates inside F3, F4
norm_F3 = matrix_normalize(F3);
norm_F4 = matrix_normalize(F4);