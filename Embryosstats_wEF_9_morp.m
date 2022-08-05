function Embryosstats = Embryosstats_wEF_9_morp(path_cell1, path_out_seg, path_mask, periodHr, nsortD, tdump)  

path_train = path_cell1; 
path_out = path_cell1;
transform2D_to_3D;

imds1 = imageDatastore(path_cell1,'IncludeSubfolders',true,'LabelSource','foldernames');
if strcmp(nsortD,'TRUE')
    imds1.Files = natsortfiles(imds1.Files);
end

imds_mask = imageDatastore(path_mask,'IncludeSubfolders',true,'LabelSource','foldernames');
if strcmp(nsortD,'TRUE')
    imds_mask.Files = natsortfiles(imds_mask.Files);
end

Embryosstats = zeros(45,periodHr);

for i = 1:periodHr
    I = rgb2gray(readimage(imds1,tdump(i)));
    M = readimage(imds_mask,i);
    ri = tdump(i); % for determining the ri in IPSegToEmbryo
    IPSegToEmbryo_morp9;
end
%%
close all
end