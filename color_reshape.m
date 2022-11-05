function Colormatrix = color_reshape(Co, I_a, Fa)
% matrix that reconstructs color matrix
Colormatrix = [];

% switch matrix
temp = Fa(2, :);
Fa(2, :) = Fa(1, :);
Fa(1, :) = temp;

for i = 1:length(Co(1, :))
    xcord = round(Fa(1, Co(1, i)));
    ycord = round(Fa(2, Co(1, i)));
    r_val = I_a(xcord, ycord, 1);
    g_val = I_a(xcord, ycord, 2);
    b_val = I_a(xcord, ycord, 3);
    Colormatrix = [Colormatrix [r_val; g_val; b_val]];
end

end