% Computer Vision Programming Assignment 2
% 20175003 Sunghyun Kang
% Appendix: Plotting part
% You have to run all steps before running this code!

%% Plot to see the best matches
% Result: image 9 and image 10 showed best matches!
match_find = load("Analysis_result_matches.mat");
plot_matrix = zeros(15);
counter = 0;
for i = 1:length(match_find.matrix_ij(1, :))
    x = match_find.matrix_ij(1, i);
    y = match_find.matrix_ij(2, i);
    v = match_find.matrix_ij(3, i);
    plot_matrix(x+1, y+1) = v;
end
tr_matrix = transpose(plot_matrix);
plot_matrix = tr_matrix - diag(tr_matrix) + plot_matrix;

image(plot_matrix, 'CDataMapping','scaled')
a = colorbar;
a.Label.String = "Number of matchings";
a.Label.FontSize = 12;
title('two image matching in vl\_ubcmatch')
xlabel('Image number')
ylabel('Image number')
xticks([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15])
yticks([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15])
%% Draw the map that shows the matches (Before/After)
% Done by other source (See the "match_plot" folder)

ia_coord = [];
ib_coord = [];

for i = randi(length(real_matches), 200)
    idx_a = real_matches(1, i);
    idx_b = real_matches(2, i);
    ia_coord = [ia_coord; Fa(1, idx_a) Fa(2, idx_a)];
    ib_coord = [ib_coord; Fb(1, idx_b) Fb(2, idx_b)];
end
match_plot(i_a, i_b, ia_coord, ib_coord);

%% Draw the map that shows matches (original)
% Done by other source (See the "match_plot" folder)

ia_coord = [];
ib_coord = [];

for i = randi(length(matches), 200)
    idx_a = matches(1, i);
    idx_b = matches(2, i);
    ia_coord = [ia_coord; Fa(1, idx_a) Fa(2, idx_a)];
    ib_coord = [ib_coord; Fb(1, idx_b) Fb(2, idx_b)];
end
match_plot(i_a, i_b, ia_coord, ib_coord);