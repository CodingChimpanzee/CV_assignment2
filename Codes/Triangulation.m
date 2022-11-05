function [realP, result, counter, color_M] = Triangulation(P, matches, norm_Fa, norm_Fb)
% estimation function that used in step 3
% If this value turns out positive, then the camera matrix P
% would be the real camera matrix

counter = 0;
realP = [];
result = [];
color_M = [];

% Image 1 camera matrix (default)
% Identity matrix with translation zeros
p_img1 = [1 0 0 0; 0 1 0 0; 0 0 1 0];
% Extrinsic matrix of it (Intrinsic matrix * camera matrix)
% (E * p_img1) => WRONG!
p_1 = p_img1(1, :);
p_2 = p_img1(2, :);
p_3 = p_img1(3, :);

% Image 2 camera matrix (candidates)
% (E * P) => WRONG!
p_img2 = P;
pp_1 = p_img2(1, :);
pp_2 = p_img2(2, :);
pp_3 = p_img2(3, :);

% 1st phase: use Ax = 0 and obtain the first candidates
for i = 1:length(matches(1, :))
    idx_a = matches(1, i);
    idx_b = matches(2, i);
    x = norm_Fa(1, idx_a);
    y = norm_Fa(2, idx_a);
    xp = norm_Fb(1, idx_b);
    yp = norm_Fb(2, idx_b);

    A = [x*pp_3 - pp_1; 
        y*pp_3 - pp_2; 
        xp*p_3 - p_1; 
        yp*p_3 - p_2];

    %[~, ~, V] = svd(A.' * A);
    [~, ~, V] = svd(A);
    % Warining, V is a transposed matrix!
    if V(3, 4)/V(4, 4) < 0
        realP = false;
    else
        realP = P;
        xyzcoord = [V(1, 4)/V(4, 4); 
            V(2, 4)/V(4, 4); 
            V(3, 4)/V(4, 4)];
        %xyzcoord = [V(4, 1); V(4, 2); V(4, 3)];
        result = [result xyzcoord];
        color_M = [color_M [idx_a; idx_b]];
        counter = counter + 1;
    end
    
end

end

