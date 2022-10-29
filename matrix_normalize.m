function result = matrix_normalize(matrix)
% Function that normlizes the target matrix
% From range 0 ~ 1

result = [];
mother_x = max(matrix(1, :));
doughter_x = min(matrix(1, :));
mother_y = max(matrix(2, :));
doughter_y = min(matrix(2, :));
for i = 1:length(matrix(1,:))
    x_cord = matrix(1, i);
    y_cord = matrix(2, i);
    temp = [(x_cord-doughter_x)/mother_x; (y_cord-doughter_y)/mother_y];
    result = [result temp];
end

end

