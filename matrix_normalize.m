function result = matrix_normalize(matrix, K)
% Function that normlizes the target matrix
% From range 0 ~ 1

result = [];

for i = 1:length(matrix(1,:))
    x_cord = matrix(1, i);
    y_cord = matrix(2, i);
    temp = inv(K) * [x_cord; y_cord; 1];
    result = [result temp];
end

end

