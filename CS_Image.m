function out = CS_Image(im)
% in = 2D image
% out = Segmented and Cropped embryo image

% Create a Embryo mask
EmbryoMask = ~im2bw(im,graythresh(im));

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
imc = 110;
EmbryoMask = imclose(EmbryoMask, strel('disk', imc));

% Segment the Embryo:
% Embryo is the most noticeable in the red plane.
rLayer = im;

% Re-apply EmbryoMask
% Also, let's use the mask we created to discard
% anything not in our ROI
rLayer(~EmbryoMask) = 255;

% Using Regionprops for analyzing the results
cc = bwconncomp(EmbryoMask);
pstats = regionprops(cc,{'Area', 'ConvexArea', 'Eccentricity', 'EquivDiameter', 'EulerNumber', 'Extent', 'FilledArea', 'MajorAxisLength', 'MinorAxisLength', 'Orientation', 'Perimeter', 'Solidity'}');

labeledImage = rLayer;

% cropped image
[rows, columns] = find(labeledImage ~= 255);
row1 = min(rows);row2 = max(rows);col1 = min(columns);col2 = max(columns);
croppedImage = labeledImage(row1:row2, col1:col2);
out = croppedImage;
end

