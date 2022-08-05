% feature_extraction_used_with total variation
clear;close all;clc
warning off;

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

% Set the intersample distance d
d = 25;
% GRAY LEVEL DIFFERENCE METHOD
% For details on the Gray level Difference Method, refer the following paper
% J. K. Kim and H. W. Park, "Statistical textural features for
% detection of microcalcifications in digitized mammograms",
% IEEE Trans. Med. Imag. 18, 231-238 (1999).
[pdf1_1, pdf2_1, pdf3_1, pdf4_1] = GLDM(out_1, d);
[pdf1_2, pdf2_2, pdf3_2, pdf4_2] = GLDM(out_2, d);

% Total Variation
% Decompose textures in image with spectral TV, gray-scale images
% Script by Guy Gilboa (Jan 2015).
% Based on: [1] G. Gilboa, "A total variation spectral framework for scale and texture analysis." SIAM Journal on Imaging Sciences 7.4 (2014): 1937-1961.
[bp_im_1, hp_im_1, lp_im_1, I_1, G_1, fignum] = total_variation_2D(out_1, 1, 25, 1:25, [5 5], 22, 8, 8, 22, 1);
[bp_im_2, hp_im_2, lp_im_2, I_2, G_2, fignum] = total_variation_2D(out_2, 1, 25, 1:25, [5 5], 22, 8, 8, 22, 8);

% gradient and texture info extraction
[geometric_1, texture_1, gradient_1, comatrix_features_1] = propery_extraction(hp_im_1, out_1);
[geometric_2, texture_2, gradient_2, comatrix_features_2] = propery_extraction(hp_im_2, out_2);

fprintf('survived texture results: %d\n', texture_1.smoothness2)
fprintf('not survived texture results: %d\n', texture_2.smoothness2)

%HOG
%Image descriptor based on Histogram of Orientated Gradients for gray-level images. This code 
%was developed for the work: O. Ludwig, D. Delgado, V. Goncalves, and U. Nunes, 'Trainable 
%Classifier-Fusion Schemes: An Application To Pedestrian Detection,' In: 12th International IEEE 
%Conference On Intelligent Transportation Systems, 2009, St. Louis, 2009. V. 1. P. 432-437. In 
%case of publication with this code, please cite the paper above.
H_s=HOG(out_1);
H_ns=HOG(out_2);
fprintf('survived HOG mean:  %d\n', mean(H_s))
fprintf('not survived HOG mean: %d\n', mean(H_ns))


% Plot
figure(fignum); fignum = fignum + 1; 
if strcmp(Survived_plusNot_Comparison,'TRUE')
    subplot(221);plot(pdf1_1);hold on; plot(pdf1_2);title('          horizontal-weighted sum');legend({'survived','not survived'},'Location','southeast');legend('boxoff');
    subplot(222);plot(pdf2_1);hold on; plot(pdf2_2);title('     vertical-weighted sum');legend({'survived','not survived'},'Location','southeast');legend('boxoff');
    subplot(223);plot(pdf3_1);hold on; plot(pdf3_2);title('        diagonal-weighted sum');legend({'survived','not survived'},'Location','southeast');legend('boxoff');
    subplot(224);plot(pdf4_1);hold on; plot(pdf4_2);title('grid-weighted sum');legend({'survived','not survived'},'Location','southeast');legend('boxoff');
end
if strcmp(SurvivedComparison,'TRUE')
    subplot(221);plot(pdf1_1);hold on; plot(pdf1_2);title('          horizontal-weighted sum');legend({'survived-1','survived-2'},'Location','southeast');legend('boxoff');
    subplot(222);plot(pdf2_1);hold on; plot(pdf2_2);title('     vertical-weighted sum');legend({'survived-1','survived-2'},'Location','southeast');legend('boxoff');
    subplot(223);plot(pdf3_1);hold on; plot(pdf3_2);title('        diagonal-weighted sum');legend({'survived-1','survived-2'},'Location','southeast');legend('boxoff');
    subplot(224);plot(pdf4_1);hold on; plot(pdf4_2);title('grid-weighted sum');legend({'survived-1','survived-2'},'Location','southeast');legend('boxoff');
end

% gradient magnitude, Gmag, and the gradient direction, Gdir
% Gdir contains angles in degrees within the range [-180, 180]
[Gmag_B, Gdir_B] = imgradient(out_1,'prewitt');
[Gmag_NB, Gdir_NB] = imgradient(out_2,'prewitt');
figure(fignum); fignum = fignum + 1; 
subplot(2,1,1);imshowpair(Gmag_B, Gdir_B, 'montage');
title('Gradient Magnitude    Gradient Direction');
ylabel('servived')
subplot(2,1,2);imshowpair(Gmag_NB, Gdir_NB, 'montage');
title('Gradient Magnitude    Gradient Direction');
ylabel('not servived')

% Also, let's use the mask we created to discard
% anything not in our ROI
Gmag_B_v = [];Gdir_B_v = [];Gmag_NB_v = [];Gdir_NB_v = [];
[M, N] = size(Gmag_B);
for i=1:M
    for j=1:N
        if Gmag_B(i,j) ~= 0
            Gmag_B_v = [Gmag_B_v, Gmag_B(i,j)];
        end
    end
end
[M, N] = size(Gdir_B);
for i=1:M
    for j=1:N
        if Gdir_B(i,j) ~= 0
            Gdir_B_v = [Gdir_B_v, Gdir_B(i,j)];
        end
    end
end
[M, N] = size(Gmag_NB);
for i=1:M
    for j=1:N
        if Gmag_NB(i,j) ~= 0
            Gmag_NB_v = [Gmag_NB_v, Gmag_NB(i,j)];
        end
    end
end
[M, N] = size(Gdir_NB);
for i=1:M
    for j=1:N
        if Gdir_NB(i,j) ~= 0
            Gdir_NB_v = [Gdir_NB_v, Gdir_NB(i,j)];
        end
    end
end

% mean
m_Gmag_B_v = mean(Gmag_B_v);
m_Gmag_NB_v = mean(Gmag_NB_v);
m_Gdir_B_v = mean(Gdir_B_v);
m_Gdir_NB_v = mean(Gdir_NB_v);
% std
v_Gmag_B_v = std(Gmag_B_v);
v_Gmag_NB_v = std(Gmag_NB_v);
v_Gdir_B_v = std(Gdir_B_v);
v_Gdir_NB_v = std(Gdir_NB_v);

fprintf('survived Embryo mean Magnitude: %d, Direction: %d\n', m_Gmag_B_v, m_Gdir_B_v)
fprintf('not survived Embryo mean Magnitude: %d, Direction: %d\n', m_Gmag_NB_v, m_Gdir_NB_v)
%fprintf('survived Embryo var Magnitude: %d, Direction: %d\n', v_Gmag_B_v, v_Gdir_B_v)
%fprintf('not survived Embryo var Magnitude: %d, Direction: %d\n', v_Gmag_NB_v, v_Gdir_NB_v)