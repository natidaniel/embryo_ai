%% Detecting a Embryo Using Manual Image Segmentation

%% Read image and mask
EmbryoMask = M;
rLayer = I(:,:,1);

% Re-apply EmbryoMask
% Also, let's use the mask we created to discard
% anything not in our ROI
rLayer(~EmbryoMask) = 255;
imwrite(rLayer,[path_out_seg,'\Embryosstats',num2str(ri),'.png']);

% Using Regionprops for analyzing the results
cc = bwconncomp(EmbryoMask);
pstats = regionprops(cc,{'Area', 'ConvexArea', 'Eccentricity', 'EquivDiameter', 'EulerNumber', 'Extent', 'FilledArea', 'MajorAxisLength', 'MinorAxisLength', 'Orientation', 'Perimeter', 'Solidity'}');

% GLCM stats
% using cropping im for stats
labeledImage = rLayer;
[rows, columns] = find(labeledImage ~= 255);
row1 = min(rows);row2 = max(rows);col1 = min(columns);col2 = max(columns);
croppedImage = labeledImage(row1:row2, col1:col2);% cropped image

% Use the following angles "offset"= [0 1;-1 1;-1 0;-1 -1] =(0,45,90,135), instead of previous offset [2 0;0 2]
GLCM2 = graycomatrix(croppedImage,'Offset',[0 1;-1 1;-1 0;-1 -1]);
stats = GLCM_Features(GLCM2,0);
% Analyzing the results
% Count the number of regions
[~, numberOfEmbryos] = bwlabel(EmbryoMask);     

% Total variation, GLDM, gradient, HOG and mag_dir methods
[hws, vws, dws, gws, lp_s_m, hp_s_m, bp_s_m, geometric, texture, gradient, comatrix_features, H_m, m_Gmag_v, m_Gdir_v, v_Gmag_v, v_Gdir_v] = FE_A(croppedImage,25,1,25,22,8,8,22);

% save in stats data into matrix for each image
Embryosstats(1,i) = pstats.Area;
Embryosstats(2,i) = pstats.MajorAxisLength;
Embryosstats(3,i) = pstats.Perimeter;
Embryosstats(4,i) = pstats.Eccentricity;
Embryosstats(5,i) = stats.Autocorrelation(2);
Embryosstats(6,i) = stats.Contrast(2);
Embryosstats(7,i) = stats.Correlation(2);
Embryosstats(8,i) = stats.ClusterProminence(2);
Embryosstats(9,i) = stats.ClusterShade(2);
Embryosstats(10,i) = stats.Dissimilarity(2);
Embryosstats(11,i) = stats.Energy(2);
Embryosstats(12,i) = stats.Entropy(2);
Embryosstats(13,i) = stats.Homogeneity(2);
Embryosstats(14,i) = stats.MaximumProbability(2);
Embryosstats(15,i) = stats.Variance(2);
Embryosstats(16,i) = stats.Smoothness(2);
Embryosstats(17,i) = stats.SumAverage(2);
Embryosstats(18,i) = stats.SumVariance(2);
Embryosstats(19,i) = stats.SumEntropy(2);
Embryosstats(20,i) = stats.DifferenceVariance(2);
Embryosstats(21,i) = stats.DifferenceEntropy(2);
Embryosstats(22,i) = stats.InformationMeasureOfCorrelation1(2);
Embryosstats(23,i) = stats.InverseDifferenceNormalized(2);
Embryosstats(24,i) = stats.InverseDifferenceMomentNormalized(2);
Embryosstats(25,i) = 4*pi*(pstats.Area/(pstats.Perimeter)^2); % Roundess - 1.0 represented a perfect circle
Embryosstats(26,i) = hws;
Embryosstats(27,i) = vws; 
Embryosstats(28,i) = dws; 
Embryosstats(29,i) = gws;
Embryosstats(30,i) = lp_s_m;
Embryosstats(31,i) = hp_s_m; 
Embryosstats(32,i) = bp_s_m;
Embryosstats(33,i) = H_m;
Embryosstats(34,i) = m_Gmag_v;
Embryosstats(35,i) = m_Gdir_v; 
Embryosstats(36,i) = v_Gmag_v;
Embryosstats(37,i) = v_Gdir_v;
Embryosstats(38,i) = texture.skewness;
Embryosstats(39,i) = gradient.mean;
Embryosstats(40,i) = gradient.std;
Embryosstats(41,i) = gradient.globalmean;
Embryosstats(42,i) = gradient.uniformity;
Embryosstats(43,i) = gradient.entropy;
Embryosstats(44,i) = gradient.skewness;
Embryosstats(45,i) = gradient.correlation;