% Computer Vision Programming Assignment 2
% 20175003 Sunghyun Kang
% Step 1, import image and Extract features using SIFT
% Also, match features between two images

% Add path
addpath('Camera_Visualization');
addpath('Data');
addpath('vlfeat-0.9.21');

%% Import image a and b
% Or kirby02 and kirby03
% (turn into grayscale and extract as single type)
I_a = imread('sfm03.jpg');
I_b = imread('sfm04.jpg');

i_a = single(rgb2gray(I_a));
i_b = single(rgb2gray(I_b));

%% Extract features using SIFT
[Fa, Da] = vl_sift(i_a);
[Fb, Db] = vl_sift(i_b);

%% Check whether the x and y axis has been switched
% If it is switched, please run this coordinate
% temp = Fa(2, :);
% Fa(2, :) = Fa(1, :);
% Fa(1, :) = temp;
% 
% temp = Fb(2, :);
% Fb(2, :) = Fb(1, :);
% Fb(1, :) = temp;

%% Visualize the feature extraction result
imshow(I_a);
hold on;
fa = vl_plotframe(Fa);
set(fa, 'color', 'k', 'linewidth', 0.001);
hold off;

%% Match features between two images
[matches, scores] = vl_ubcmatch(Da, Db);

%% Normalize coordinates inside Fa, Fb

% Original(SFM) image K
K = [ 3451.5      0.0  2312;
        0.0 3451.5  1734;
        0.0      0.0    1.0];

% My image K
% K = [2846.555869842812172 0.0 2015.500000000000000;
%      0.0 2935.255104226779622 1511.500000000000000;
%      0.0 0.0 1.0];

norm_Fa = matrix_normalize(Fa, K);
norm_Fb = matrix_normalize(Fb, K);

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

        counter = counter + 1;
        % Progress bar, 105 = 15 Combination 2
        waitbar(counter/105, f, sprintf('Progress: %d %%', floor(counter/105*100)));
    end
end
close(f)
