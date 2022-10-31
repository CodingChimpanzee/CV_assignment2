function [realP, result] = Triangulation(P, matches, norm_1, norm_2)
% estimation function that used in step 3
% If this value turns out positive, then the camera matrix P
% would be the real camera matrix

realP = [];
result = [];

p_1 = [1 0 0 0];
p_2 = [0 1 0 0];
p_3 = [0 0 1 0];

pp_1 = P(1, :);
pp_2 = P(2, :);
pp_3 = P(3, :);

for i = 1:length(matches(1, :))
    idx = matches(1, i);
    x = norm_1(1, idx);
    y = norm_1(2, idx);
    xp = norm_2(1, idx);
    yp = norm_2(2, idx);

    A = [x*p_3 - p_1; y*p_3 - p_2; xp*pp_3 - pp_1; yp*pp_3 - pp_2];
    [~, ~, V] = svd(A);
    
    if V(4, 3) < 0
        realP = false;
        result = false;
    end
    
end

if realP ~= 0
    realP = P;
end

end
