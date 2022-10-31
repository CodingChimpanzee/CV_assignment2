% Computer Vision Programming Assignment 2
% 20175003 Sunghyun Kang
% Step 1, import image and Extract features using SIFT
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

%% Appendix: Find the best match of the image

matrix_ij = [];
counter = 0;
% For progress bar
f = waitbar(0, 'iteration start!');

for i = 0:14
    for j = (i+1):14
        if i < 10
            str1 = strcat('sfm0', int2str(i), '.jpg');
        else
            str1 = strcat('sfm', int2str(i), '.jpg');
        end
        if j < 10
            str2 = strcat('sfm0', int2str(j), '.jpg');
        else
            str2 = strcat('sfm', int2str(j), '.jpg');
        end
        Image_i = imread(str1);
        Image_j = imread(str2);
        i_i = single(rgb2gray(Image_i));
        i_j = single(rgb2gray(Image_j));
        
        [F_i, D_i] = vl_sift(i_i);
        [F_j, D_j] = vl_sift(i_j);
        
        [match_ij, score_ij] = vl_ubcmatch(D_i, D_j);
        matrix_ij = [matrix_ij [i; j; length(match_ij(1, :))]];

%        if matrix_ij(3, 1) < length(match_ij(1, :))
%            matrix_ij = [i; j; length(match_ij(1, :))];
%        end
        counter = counter + 1;
        % Progress bar, 105 = 15 Combination 2
        waitbar(counter/105, f, sprintf('Progress: %d %%', floor(counter/105*100)));
    end
end
close(f)
