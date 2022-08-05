%% GLCM EoE Script

clear
close all 
clc


%%
isPlot = "FALSE";
isMajoritySet = "TRUE";

%% Load data
path_full = 'C:\Nati\EoE\paper1\paper_data_for_nati\data\sub_dataset2_patch_validation_224\0\';
path_eoe_stat = 'C:\Nati\EoE\paper1\paper_data_for_nati\data\sub_dataset2_patch_validation_224\';
img_labels = 0;

imds1 = imageDatastore(path_full,'IncludeSubfolders',true,'LabelSource','foldernames');



%% Transform 2d to 3d
%tic
if strcmp(isMajoritySet,'FALSE')
    d1=dir(path_full);
    for ii=3:length(d1)
        I=imread([path_full,d1(ii).name]);
        if ndims(I) == 2 % if it's a 2D image,  Convert to 3-D.
            I1 = cat(3, I, I, I);
            imwrite(I1,[path_full,d1(ii).name]);
        end
        clear I1
    end
else
    for i = 1:length(imds1.Files)
        I = readimage(imds1,i);
        if ndims(I) == 2 % if it's a 2D image,  Convert to 3-D.
            I1 = cat(3, I, I, I);
            imwrite(I1,imds1.Files{i});
        end
        clear I1
    end
end
%toc

%% Define EoEstats
EoEstats = zeros(length(imds1.Files),21);

for i = 1:length(imds1.Files)
    I = rgb2gray(readimage(imds1,i));
    if strcmp(isPlot,'TRUE')
        figure(1), imshow(I,[ ]);
    end
    
    % GLCM stats
    % using cropping im for stats
    labeledImage = I;
    [rows, columns] = find(labeledImage ~= 0);
    row1 = min(rows);row2 = max(rows);col1 = min(columns);col2 = max(columns);
    croppedImage = labeledImage(row1:row2, col1:col2);% cropped image
    if strcmp(isPlot,'TRUE')
        figure(2), imshow(croppedImage,[ ]);
    end
    
    % Use the following angles "offset"= [0 1;-1 1;-1 0;-1 -1] =(0,45,90,135), instead of previous offset [2 0;0 2]
    GLCM2 = graycomatrix(croppedImage,'Offset',[0 1;-1 1;-1 0;-1 -1]);
    stats = GLCM_Features(GLCM2,0);

    % save in stats data into matrix for each image
    EoEstats(i,1) = stats.Autocorrelation(2);
    EoEstats(i,2) = stats.Contrast(2);
    EoEstats(i,3) = stats.Correlation(2);
    EoEstats(i,4) = stats.ClusterProminence(2);
    EoEstats(i,5) = stats.ClusterShade(2);
    EoEstats(i,6) = stats.Dissimilarity(2);
    EoEstats(i,7) = stats.Energy(2);
    EoEstats(i,8) = stats.Entropy(2);
    EoEstats(i,9) = stats.Homogeneity(2);
    EoEstats(i,10) = stats.MaximumProbability(2);
    EoEstats(i,11) = stats.Variance(2);
    EoEstats(i,12) = stats.Smoothness(2);
    EoEstats(i,13) = stats.SumAverage(2);
    EoEstats(i,14) = stats.SumVariance(2);
    EoEstats(i,15) = stats.SumEntropy(2);
    EoEstats(i,16) = stats.DifferenceVariance(2);
    EoEstats(i,17) = stats.DifferenceEntropy(2);
    EoEstats(i,18) = stats.InformationMeasureOfCorrelation1(2);
    EoEstats(i,19) = stats.InverseDifferenceNormalized(2);
    EoEstats(i,20) = stats.InverseDifferenceMomentNormalized(2);
end
EoEstats(:,21) = img_labels;

save(fullfile(path_eoe_stat, 'EoEstats_0'), 'EoEstats');

disp('Done')

