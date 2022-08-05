% feature_extraction_used_with total variation
clear;close all;clc

SurvivedComparison = 'FALSE';
Survived_plusNot_Comparison = 'TRUE';

% Read Input Image
if strcmp(Survived_plusNot_Comparison,'TRUE')
    inImg_1 = rgb2gray(imread('C:\Nati\Embryos\4Yoni\Embryo Deep learning\images\O\9_8\1\1\66.png')); %s
    out_1 = CS_Image(inImg_1);
    inImg_2 = rgb2gray(imread('C:\Nati\Embryos\4Yoni\Embryo Deep learning\images\O\9_8\4\2\66.png')); %ns
    out_2 = CS_Image(inImg_2);
end
if strcmp(SurvivedComparison,'TRUE')
    inImg_1 = rgb2gray(imread('C:\Nati\Embryos\4Yoni\Embryo Deep learning\images\O\9_8\4\1\50.png')); %s
    out_1 = CS_Image(inImg_1);
    inImg_2 = rgb2gray(imread('C:\Nati\Embryos\4Yoni\Embryo Deep learning\images\O\9_8\5\1\50.png')); %s2
    out_2 = CS_Image(inImg_2);
end

% debug
im_sentetic = zeros(231,246);im_sentetic(10:end,5:end)=1;

[bp_im_1, hp_im_1, lp_im_1, I_1, G_1] = total_variation_2D(out_1, 1, 25, 1:25, [5 5], 22, 8, 8, 22, 1);
[bp_im_2, hp_im_2, lp_im_2, I_2, G_2] = total_variation_2D(out_2, 1, 25, 1:25, [5 5], 22, 8, 8, 22, 8);
[bp_im_s, hp_im_s, lp_im_s, I_s, G_s] = total_variation_2D(im_sentetic, 1, 25, 1:25, [5 5], 22, 8, 8, 22, 15);
[geometric_1, texture_1, gradient_1, comatrix_features_1] = propery_extraction(hp_im_1, out_1);
[geometric_2, texture_2, gradient_2, comatrix_features_2] = propery_extraction(hp_im_2, out_2);
[geometric_s, texture_s, gradient_s, comatrix_features_s] = propery_extraction(bp_im_s, im_sentetic);

fprintf('servived results: %d\n', texture_1.smoothness2)
fprintf('not servived results: %d\n', texture_2.smoothness2)
fprintf('sentetic image results: %d\n', texture_s.smoothness2)

