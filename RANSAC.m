function [E_matrix, real_matches] = RANSAC(norm_Fa, norm_Fb, matches)
% RANSAC FUNCTION that returns optimal E
% F_a: normalized right side image coordinates
% F_b: normalized left side image coordinates
% matches: matched value that found in problem 1
% E_matrix: output E

% First, initialize the matrix we want to store the E
% In (1:3, 1:3) will be our estimated E
% the 4 by 1 element of E_candidates refers the x' * E * x value
% rest of the elements are dummy values
E_candidates = [0 0 0; 0 0 0; 0 0 0; 0 0 0];

% For progress bar
f = waitbar(0, 'iteration start!');

% iteration time definition
iter_c = 10000;
% Threshold definition
threshold = 7e-05;
% For the real matches
real_matches = [];

for iter = 1:iter_c    
    temp_matches = [];
    % Achieve 5 random coordinates
    indexes = randperm(length(matches), 5);
    right_5points = [];
    left_5points = [];
    for i = 1:5
        index_r = matches(1, indexes(i));
        index_l = matches(2, indexes(i));
        right_5points = [right_5points [norm_Fa(1, index_r); norm_Fa(2, index_r); 1]];
        left_5points = [left_5points [norm_Fb(1, index_l); norm_Fb(2, index_l); 1]];
    end

    % Get metadata E
    E_prime = calibrated_fivepoint(right_5points, left_5points);
    % E can be 9 by 2 or 9 by 4 or 9 by 6, ... so we will have
    % multiple 3 by 3 matrices
    for i = 1:length(E_prime(1,:))
        % Number of inliers
        inliers = 0;
        temp_matches = [];
        E = reshape(E_prime(:,i), 3, 3);
        
        % Get U, W, V
        W = [0 -1 0; 1 0 0; 0 0 1];
        [U, ~, V_t] = svd(E);
        R = U*W*V_t;

        scores_E = 0;
        % Get x' * E * x for all matching points
        % WARNING: DO NOT USE i AS AN coordinate index
        for k = 1:length(matches(1,:))
            idx_a = matches(1, k);
            idx_b = matches(2, k);
            x_trans = [norm_Fa(1,idx_a), norm_Fa(2,idx_a), 1];
            x = [norm_Fb(1,idx_b); norm_Fb(2,idx_b); 1];
            % ABSOLUTE VALUE!
            temp = abs(x_trans * E * x);
            scores_E = scores_E + temp;
            if temp < threshold && det(R) > 0
                inliers = inliers + 1;
                temp_matches = [temp_matches matches(:, k)];
            end
        end
        scores_E = scores_E / length(matches(1,:));
    
        % Store the result in E_candidates if its inliers are more
        if E_candidates(4,2) < inliers
            E_candidates = [E; scores_E inliers 0];
            real_matches = temp_matches;
        end
    end

    % Progress bar
    waitbar(iter/iter_c, f, sprintf('Progress: %d %%', floor(iter/iter_c*100)));
end
% end progress bar
close(f)
% output: The most optimal matrix E and its matches
E_matrix = E_candidates(1:3, 1:3); 
disp(E_candidates(4,2))
end

