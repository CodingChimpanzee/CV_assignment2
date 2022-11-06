# CV_assignment2: Structure From Motion (SFM)
Programming assignment 2 for computer vision course

## Dependencies
* MATALB version: at least 2022a
* VLFeat: at least v.0.9.21

## Usage
```bash
# add paths inside matlab console
addpath('Data')
addpath('Calibration_Data')
addpath('match_plot')
addpath('Step2')
addpath('Step5')
addpath('Step7')
addpath('vlfeat-0.9.21');
addpath('external_source_code');

# run codes using matlab
# you have to run with this order
cd Codes
step1
step2
step3
step4
```

## Directories
* Codes: Source code for this project
* external_source_code: External source code for visualizing
* Data: Image data that used for the report 
* Calibration_Data: Calibration image and my own data to reproduce the 3D coordinates
* Results: Results from my code, please see "the_real_result" file
* camera_calibration_results: My camera calibration results

## Components
* Codes
    * step_1.m: Imaging feature extraction and basic matching
    * step_2.m: Running RANSAC to achieve essential matrix E and its reasonable matchings
    * step_3.m: Receive 4 camera matricies candidate 
    * step_4.m: Triangulation and the 3D coodinate estimation
    * matrix_normalize: Feature vector normalization based on camera intrinsic K
    * RANSAC.m: RANSAC function
    * BEST_SCORES_RANSAC: RANSAC based on the best scores (not that meaningful)
    * Triangulation.m: Triangulation function
    * additional_tri.m: Triangulation in backwards (switching camera)
    * color_reshape.m: Function that reconstructs the color of 3D mesh
    * Plotting.m: Plotting a graph for my report


* Images
    * the_real_result.ply: The submission file for .ply
    * my_image_result.ply: Result from my own image

