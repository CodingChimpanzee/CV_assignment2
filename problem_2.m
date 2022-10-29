% Computer Vision Programming Assignment 2
% 20175003 Sunghyun Kang
% Problem 2, Estimate matrix E with RANSAC,
% Also, decompose essntial matrix E to camera extrinsic

%% Essential matrix E estimation

E = calibrated_fivepoint(matches, revmatches);