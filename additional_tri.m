function [counter, another_coord] = additional_tri(R, u_3, coord)
% check the second camera pose matrix
counter = 0;
another_coord = [];
for i = 1:length(coord(1, :))
    xyzcord = [coord(1, i); coord(2, i); coord(3, i)];
    temp_coord = R*xyzcord + u_3;
    if temp_coord(3, 1) > 0
        counter = counter + 1;
        another_coord = [another_coord temp_coord];
    end
end

end

