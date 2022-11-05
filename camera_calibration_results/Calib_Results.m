% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly excecuted under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 2846.555869842812172 ; 2935.255104226779622 ];

%-- Principal point:
cc = [ 2015.500000000000000 ; 1511.500000000000000 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ 0.020282145754837 ; -0.164254697054152 ; -0.003787365129372 ; -0.003878022565970 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 368.635103533132906 ; 267.241849293402197 ];

%-- Principal point uncertainty:
cc_error = [ 0.000000000000000 ; 0.000000000000000 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.111780108947587 ; 0.748451060492269 ; 0.003070261849393 ; 0.007355467995371 ; 0.000000000000000 ];

%-- Image size:
nx = 4032;
ny = 3024;


%-- Various other variables (may be ignored if you do not use the Matlab Calibration Toolbox):
%-- Those variables are used to control which intrinsic parameters should be optimized

n_ima = 3;						% Number of calibration images
est_fc = [ 1 ; 1 ];					% Estimation indicator of the two focal variables
est_aspect_ratio = 1;				% Estimation indicator of the aspect ratio fc(2)/fc(1)
center_optim = 0;					% Estimation indicator of the principal point
est_alpha = 0;						% Estimation indicator of the skew coefficient
est_dist = [ 1 ; 1 ; 1 ; 1 ; 0 ];	% Estimation indicator of the distortion coefficients


%-- Extrinsic parameters:
%-- The rotation (omc_kk) and the translation (Tc_kk) vectors for every calibration image and their uncertainties

%-- Image #1:
omc_1 = [ -2.831332e+00 ; -6.213614e-01 ; 8.424296e-01 ];
Tc_1  = [ -1.249044e+02 ; 3.776010e+01 ; 4.152946e+02 ];
omc_error_1 = [ 3.672130e-02 ; 8.595122e-03 ; 8.309302e-02 ];
Tc_error_1  = [ 5.005366e+00 ; 2.572459e-01 ; 3.737382e+01 ];

%-- Image #2:
omc_2 = [ -7.172061e-01 ; -2.416579e+00 ; 2.605786e-01 ];
Tc_2  = [ -2.425140e+00 ; -1.096921e+02 ; 3.531040e+02 ];
omc_error_2 = [ 1.610704e-02 ; 5.322617e-02 ; 1.573549e-02 ];
Tc_error_2  = [ 3.138023e-01 ; 1.467267e-01 ; 3.170229e+01 ];

%-- Image #3:
omc_3 = [ -1.217899e-03 ; -2.585702e+00 ; -5.365468e-03 ];
Tc_3  = [ 5.458947e+01 ; -6.392526e+01 ; 2.826240e+02 ];
omc_error_3 = [ 1.800984e-03 ; 6.252538e-02 ; 6.141113e-03 ];
Tc_error_3  = [ 2.143048e+00 ; 1.831169e-01 ; 2.541629e+01 ];

