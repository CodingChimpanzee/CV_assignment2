function E = BEST_SCORES_RANSAC(F_a, F_b, matches, scores)
%BEST_SCORES__RANSAC 이 함수의 요약 설명 위치

% Extract 5 best matches
% extract matches based on scores
best_five_scores = maxk(scores, 5);

% five indexes
idx1 = find(scores == best_five_scores(1:1));
idx2 = find(scores == best_five_scores(2:2));
idx3 = find(scores == best_five_scores(3:3));
idx4 = find(scores == best_five_scores(4:4));
idx5 = find(scores == best_five_scores(5:5));

% extract coordinates from index
right_1 = [F_a(1, idx1); F_a(2, idx1); 1];
right_2 = [F_a(1, idx2); F_a(2, idx2); 1];
right_3 = [F_a(1, idx3); F_a(2, idx3); 1];
right_4 = [F_a(1, idx4); F_a(2, idx4); 1];
right_5 = [F_a(1, idx5); F_a(2, idx5); 1];

left_1 = [F_b(1, idx1); F_b(2, idx1); 1];
left_2 = [F_b(1, idx2); F_b(2, idx2); 1];
left_3 = [F_b(1, idx3); F_b(2, idx3); 1];
left_4 = [F_b(1, idx4); F_b(2, idx4); 1];
left_5 = [F_b(1, idx5); F_b(2, idx5); 1];

% Make Q1, Q2 matrix for Essential Matrix Estimation
right_5points = [right_1 right_2 right_3 right_4 right_5];
left_5points = [left_1 left_2 left_3 left_4 left_5];

% Essential matrix E estimation
E_prime = calibrated_fivepoint(right_5points, left_5points);
E_candidates = [1 1 1; 1 1 1; 1 1 1; 1000 0 0];

% E can be 9 by 2 or 9 by 4 or 9 by 6, ... so we will have
% multiple 3 by 3 matrices
for i = 1:length(E_prime(1,:))
    E = reshape(E_prime(:,i), 3, 3);
    scores_E = 0;
    % Get x' * E * x for all matching points
    for k = 1:length(matches(1,:))
        idx_a = matches(1, k);
        idx_b = matches(2, k);
        x_trans = [F_b(1,idx_b), F_b(2,idx_b), 1];
        x = [F_a(1,idx_a); F_a(2,idx_a); 1];
        scores_E = scores_E + (x_trans * E * x);
    end
scores_E = abs(scores_E / length(matches(1,:)));
% Store the result in E_candidates
if E_candidates(4,1) > scores_E
    E_candidates = [E; scores_E 0 0];
    disp(scores_E)
end
E = E_candidates(1:3, 1:3);
end

