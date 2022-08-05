%% Survived/Not suvrvived features
close all;clear;clc
% Read image
rgbImg_B = imread('C:\Nati\Embryos\4Yoni\Embryo Deep learning\images\O\9_8\4\1\57.png');
rgbImg_NB = imread('C:\Nati\Embryos\4Yoni\Embryo Deep learning\images\O\9_8\4\2\57.png');
figure(1);
subplot(1,2,1);imshow(rgbImg_B);title('Original Image, survived');
subplot(1,2,2);imshow(rgbImg_NB);title('Original Image, not survived');
% First, let's segment the entire Embryo (ROI)
gLayer_B = rgbImg_B(:,:,2);gLayer_NB = rgbImg_NB(:,:,2);

% Create a Embryo mask
EmbryoMask_B = ~im2bw(gLayer_B,graythresh(gLayer_B));EmbryoMask_NB = ~im2bw(gLayer_NB,graythresh(gLayer_NB));
originalMask_B = EmbryoMask_B;originalMask_NB = EmbryoMask_NB;

% Clean mask: (1) Clear objects on the border
%EmbryoMask = imclearborder(EmbryoMask);

% Clean mask: (2) Obliterate small blobs
EmbryoMask_B = bwareaopen(EmbryoMask_B,25);EmbryoMask_NB = bwareaopen(EmbryoMask_NB,25);

% Find the biggest region. Ignore all others by zeroing them out.
cc_B = bwconncomp(EmbryoMask_B);cc_NB = bwconncomp(EmbryoMask_NB);
pstats_B = regionprops(cc_B,'Area');pstats_NB = regionprops(cc_NB,'Area');
A_B = [pstats_B.Area];A_NB = [pstats_NB.Area];
[~,biggest_B] = max(A_B);[~,biggest_NB] = max(A_NB);
EmbryoMask_B(labelmatrix(cc_B)~=biggest_B) = 0;EmbryoMask_NB(labelmatrix(cc_NB)~=biggest_NB) = 0;

% Fill it in
EmbryoMask_B = imfill(EmbryoMask_B,'holes');EmbryoMask_NB = imfill(EmbryoMask_NB,'holes');

% Smooth and fill
imc = 110;
EmbryoMask_B = imclose(EmbryoMask_B, strel('disk', imc));EmbryoMask_NB = imclose(EmbryoMask_NB, strel('disk', imc));

% Segment the Embryo:
% Embryo is the most noticeable in the red plane.
rLayer_B = rgbImg_B(:,:,1);rLayer_NB = rgbImg_NB(:,:,1);

% Re-apply EmbryoMask
% Also, let's use the mask we created to discard
% anything not in our ROI
rLayer_B(~EmbryoMask_B) = 255;rLayer_NB(~EmbryoMask_NB) = 255;

% Using Regionprops for analyzing the results
cc_B = bwconncomp(EmbryoMask_B);cc_NB = bwconncomp(EmbryoMask_NB);
pstats_B = regionprops(cc_B,{'Area', 'ConvexArea', 'Eccentricity', 'EquivDiameter', 'EulerNumber', 'Extent', 'FilledArea', 'MajorAxisLength', 'MinorAxisLength', 'Orientation', 'Perimeter', 'Solidity'}');
pstats_NB = regionprops(cc_NB,{'Area', 'ConvexArea', 'Eccentricity', 'EquivDiameter', 'EulerNumber', 'Extent', 'FilledArea', 'MajorAxisLength', 'MinorAxisLength', 'Orientation', 'Perimeter', 'Solidity'}');

labeledImage_B = rLayer_B;labeledImage_NB = rLayer_NB;
figure(2);subplot(1,2,1);imshow(labeledImage_B);title('Segmented Image, survived');
subplot(1,2,2);imshow(labeledImage_NB);title('Segmented Image, not survived');

% cropped image
[rows, columns] = find(labeledImage_B ~= 255);
row1 = min(rows);row2 = max(rows);col1 = min(columns);col2 = max(columns);
croppedImage_B = labeledImage_B(row1:row2, col1:col2);
[rows, columns] = find(labeledImage_NB ~= 255);
row1 = min(rows);row2 = max(rows);col1 = min(columns);col2 = max(columns);
croppedImage_NB = labeledImage_NB(row1:row2, col1:col2);
figure(3);
subplot(1,2,1);imshow(croppedImage_B);title('Cropped Image, survived');
subplot(1,2,2);imshow(croppedImage_NB);title('Cropped Image, not survived');

% gradient magnitude, Gmag, and the gradient direction, Gdir
%Gdir contains angles in degrees within the range [-180, 180]
[Gmag_B, Gdir_B] = imgradient(croppedImage_B,'prewitt');
[Gmag_NB, Gdir_NB] = imgradient(croppedImage_NB,'prewitt');
figure(4);
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

m_Gmag_B_v = mean(Gmag_B_v);m_Gmag_NB_v = mean(Gmag_NB_v);v_Gmag_B_v = std(Gmag_B_v);v_Gmag_NB_v = std(Gmag_NB_v);
m_Gdir_B_v = mean(Gdir_B_v);m_Gdir_NB_v = mean(Gdir_NB_v);v_Gdir_B_v = std(Gdir_B_v);v_Gdir_NB_v = std(Gdir_NB_v);

