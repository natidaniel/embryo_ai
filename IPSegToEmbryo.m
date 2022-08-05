%% Detecting a Embryo Using Image Segmentation

%% Read image
rgbImg = readimage(imds1,i);

% First, let's segment the entire Embryo (ROI)
gLayer = rgbImg(:,:,2);

% Create a Embryo mask
EmbryoMask = ~im2bw(gLayer,graythresh(gLayer));
originalMask = EmbryoMask;

% Clean mask: (1) Clear objects on the border
%EmbryoMask = imclearborder(EmbryoMask);

% Clean mask: (2) Obliterate small blobs
EmbryoMask = bwareaopen(EmbryoMask,25);

% Find the biggest region. Ignore all others by zeroing them out.
cc = bwconncomp(EmbryoMask);
pstats = regionprops(cc,'Area');
A = [pstats.Area];
[~,biggest] = max(A);
EmbryoMask(labelmatrix(cc)~=biggest) = 0;

% Fill it in
EmbryoMask = imfill(EmbryoMask,'holes');

% Smooth and fill
if strcmp(UseriMode,'TRUE')
    if (ri>=1 && ri<=12)
        imc = 100;
    elseif (ri>=42 && ri<=51)
        imc = 130;
    elseif (ri>=52 && ri<=71)
        imc = 140;
    elseif (ri>=72 && ri<=81)
        imc = 150;
    elseif (ri>=82)
        imc = 180;
    end
else
    if Ig == 14
        imc = 30;
    elseif Ig == 15
        imc = 150;
    elseif Ig == 0
        imc = 180;
    else
        imc = 110; % default
    end
end

EmbryoMask = imclose(EmbryoMask, strel('disk', imc));%30-14_2

% Segment the Embryo:
% Embryo is the most noticeable in the red plane.
rLayer = rgbImg(:,:,1);

% Re-apply EmbryoMask
% Also, let's use the mask we created to discard
% anything not in our ROI
rLayer(~EmbryoMask) = 255;
imwrite(rLayer,[path_out_seg,num2str(i),'.png']);

% Using Regionprops for analyzing the results
cc = bwconncomp(EmbryoMask);
pstats = regionprops(cc,{'Area', 'ConvexArea', 'Eccentricity', 'EquivDiameter', 'EulerNumber', 'Extent', 'FilledArea', 'MajorAxisLength', 'MinorAxisLength', 'Orientation', 'Perimeter', 'Solidity'}');
% GLCM stats
labeledImage = rLayer;
[rows, columns] = find(labeledImage ~= 255);
row1 = min(rows);row2 = max(rows);col1 = min(columns);col2 = max(columns);
croppedImage = labeledImage(row1:row2, col1:col2);% cropped image

GLCM2 = graycomatrix(croppedImage,'Offset',[2 0;0 2]);
stats = GLCM_Features(GLCM2,0);
% Analyzing the results
% Count the number of regions
[~, numberOfEmbryos] = bwlabel(EmbryoMask);     

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




