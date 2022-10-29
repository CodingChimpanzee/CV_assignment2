function E_matrix = RANSAC(F_a, F_b, matches)
% RANSAC FUNCTION that returns optimal E
% F_a: normalized right side image coordinates
% F_b: normalized left side image coordinates
% matches: matched value that found in problem 1
% E_matrix: output E

% First, initialize the matrix we want to store the E
% In (1:3, 1:3) will be our estimated E
% the 4 by 1 element of E_candidates refers the x' * E * x value
% rest of the elements are dummy values
E_candidates = [1 1 1; 1 1 1; 1 1 1; 1000 0 0];

% For progress bar
f = waitbar(0, 'iteration start!');

% iteration time definition
iter_c = 5000;
% Threshold definition
threshold = 0.003;

for iter = 1:iter_c
    
    % Achieve 5 random coordinates
    indexes = randi([1 length(matches)], 5);
    right_5points = [];
    left_5points = [];
    for i = 1:5
        right_5points = [right_5points [F_a(1, indexes(i)); F_a(2, indexes(i)); 1]];
        left_5points = [left_5points [F_b(1, indexes(i)); F_b(2, indexes(i)); 1]];
    end

    % Get metadata E
    E_prime = calibrated_fivepoint(right_5points, left_5points);
    % E can be 9 by 2 or 9 by 4 or 9 by 6, ... so we will have
    % multiple 3 by 3 matrices
    for i = 1:length(E_prime(1,:))
        % Number of inliers
        inliers = 0;
        E = reshape(E_prime(:,i), 3, 3);
        scores_E = 0;
        % Get x' * E * x for all matching points
        % WARNING: DO NOT USE i AS AN coordinate index
        for k = 1:length(matches(1,:))
            x_trans = [F_b(1,k), F_b(2,k), 1];
            x = [F_a(1,k); F_a(2,k); 1];
            temp = abs(x_trans * E * x);
            scores_E = scores_E + temp;
            if temp < threshold
                inliers = inliers + 1;
            end
        end
        scores_E = scores_E / length(matches(1,:));
    
        % Store the result in E_candidates if its inliers are more
        if E_candidates(4,2) < inliers
            E_candidates = [E; scores_E inliers 0];
            disp(scores_E)
            disp(inliers)
        end
    end

    % Progress bar
    waitbar(iter/iter_c, f, sprintf('Progress: %d %%', floor(iter/iter_c*100)));
end
% end progress bar
close(f)
% output: The most optimal matrix E
E_matrix = E_candidates(1:3, 1:3);

end

