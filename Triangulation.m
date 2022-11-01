function [realP, result, counter] = Triangulation(P, E, matches, Fa, Fb)
% estimation function that used in step 3
% If this value turns out positive, then the camera matrix P
% would be the real camera matrix

counter = 0;
realP = [];
result = [];

% Image 1 camera matrix (default)
p_img1 = [1 0 0 0; 0 1 0 0; 0 0 1 0];
% Extrinsic matrix of it (Intrinsic matrix * camera matrix)
p_img1 = E * p_img1;
p_1 = p_img1(1, :);
p_2 = p_img1(2, :);
p_3 = p_img1(3, :);

% Image 2 camera matrix (candidates)
p_img2 = E * P;
pp_1 = p_img2(1, :);
pp_2 = p_img2(2, :);
pp_3 = p_img2(3, :);

for i = 1:length(matches(1, :))
    idx_a = matches(1, i);
    idx_b = matches(2, i);
    x = Fa(1, idx_a);
    y = Fa(2, idx_a);
    xp = Fb(1, idx_b);
    yp = Fb(2, idx_b);

    A = [x*p_3 - p_1; y*p_3 - p_2; xp*pp_3 - pp_1; yp*pp_3 - pp_2];
    [~, ~, V] = svd(A);

    if V(3, 4)/V(4, 4) < 0
        realP = false;
    else
        realP = P;
        result = [result V(:, 4)./V(4, 4)];
        counter = counter + 1;
    end
    
end

end

