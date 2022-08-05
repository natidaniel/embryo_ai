function [hws, vws, dws, gws, lp_s_m, hp_s_m, bp_s_m, geometric, texture, gradient, comatrix_features, H_m, m_Gmag_v, m_Gdir_v, v_Gmag_v, v_Gdir_v] = FE_A(im,d,Max_time,Num_of_bands,hp_i,lp_i,bp_low_i,bp_high_i)
warning off;

%% INPUTS & OUTPUTS
% inputs:
% im - Segmented and Cropped embryo image
% d - intersample distance, default 25
% Max_time - Maximal scale to be processed (in evolution time), default 1
% Num_of_bands - Number of bands phi(x,t), default 25
% hp_i , lp_i - Define Filters, default 8
% bp_low_i - indix of low bandpass cutoff, default 22
% bp_high_i - indix of high bandpass cutoff, default 1

% outputs:
% hws - horizontal-weighted sum, max vector value
% vws - vertical-weighted sum, max vector value
% dws - diagonal-weighted sum, max vector value
% gws -  grid-weighted sum, max vector value
% lp_s_m - low pass filter spectrom, mean value
% hp_s_m - high pass filter spectrom, mean value
% bp_s_m - band pass filter spectrom, mean value
% H_m - Histogram of gradient, mean value
% geometric, texture, gradient, comatrix - features extractions, structs
% m_Gmag_v - embryo Gradient Magnitude, mean value
% m_Gdir_v - embryo Gradient Direction, mean value
% v_Gmag_v - embryo Gradient Magnitude, std value
% v_Gdir_v - embryo Gradient Direction, std value

%% Example run w/ default params
%[hws, vws, dws, gws, lp_s_m, hp_s_m, bp_s_m, geometric, texture, gradient, comatrix_features, H_m, m_Gmag_v, m_Gdir_v, v_Gmag_v, v_Gdir_v] = FE_A(im,25,1,25,22,8,8,22);

%% METHODS
% GRAY LEVEL DIFFERENCE METHOD
% For details on the Gray level Difference Method, refer the following paper
% J. K. Kim and H. W. Park, "Statistical textural features for
% detection of microcalcifications in digitized mammograms",
% IEEE Trans. Med. Imag. 18, 231-238 (1999).
[pdf1, pdf2, pdf3, pdf4] = GLDM(im, d);
hws = max(pdf1); vws = max(pdf2);dws = max(pdf3); gws = max(pdf4); 

% Total Variation
% Decompose textures in image with spectral TV, gray-scale images
% Script by Guy Gilboa (Jan 2015).
% Based on: [1] G. Gilboa, "A total variation spectral framework for scale and texture analysis." SIAM Journal on Imaging Sciences 7.4 (2014): 1937-1961.
dt = Max_time/Num_of_bands; 
f = mat2gray(im);
% Compute Phi bands and residual f_r
[S,T,Phi,f_r] = specTV_evolve(f, Max_time, dt);  % evolve image
H1 = zeros(size(T));H1(1:lp_i)=1;  % high pass
f_H1 = specTV_filter( Phi, H1, f_r, dt );
hp_im = 0.5+f_H1*2;
lp_s_m = mean(S(1:lp_i));hp_s_m = mean(S(hp_i:end));bp_s_m = mean(S(bp_low_i:bp_high_i));

% gradient and texture info extraction, w/ high pass filter
[geometric, texture, gradient, comatrix_features] = propery_extraction(hp_im, im);

%HOG
%Image descriptor based on Histogram of Orientated Gradients for gray-level images. This code 
%was developed for the work: O. Ludwig, D. Delgado, V. Goncalves, and U. Nunes, 'Trainable 
%Classifier-Fusion Schemes: An Application To Pedestrian Detection,' In: 12th International IEEE 
%Conference On Intelligent Transportation Systems, 2009, St. Louis, 2009. V. 1. P. 432-437. 
%In case of publication with this code, please cite the paper above.
H=HOG(im);H_m =  mean(H);

% gradient magnitude, Gmag, and the gradient direction, Gdir
% Gdir contains angles in degrees within the range [-180, 180]
[Gmag, Gdir] = imgradient(im,'prewitt');

% Also, let's use the mask we created to discard
% anything not in our ROI
Gmag_v = [];Gdir_v = [];
[M, N] = size(Gmag);
for i=1:M
    for j=1:N
        if Gmag(i,j) ~= 0
            Gmag_v = [Gmag_v, Gmag(i,j)];
        end
    end
end
[M, N] = size(Gdir);
for i=1:M
    for j=1:N
        if Gdir(i,j) ~= 0
            Gdir_v = [Gdir_v, Gdir(i,j)];
        end
    end
end
m_Gmag_v = mean(Gmag_v);m_Gdir_v = mean(Gdir_v);% mean
v_Gmag_v = std(Gmag_v);v_Gdir_v = std(Gdir_v);% std

end