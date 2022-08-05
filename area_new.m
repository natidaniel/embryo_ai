clc;clear;close all

%%
NewS = nan([103,97]);
load('emb_alive.mat')
load('AllPaths.mat')

for ii=1:103
    path = string(AllPaths(ii,1));
    imds = imageDatastore(path,...
        'IncludeSubfolders',true, ...
        'LabelSource','foldernames');
    imds.Files = natsortfiles(imds.Files);
    Area = [];
    for i =1:length(imds.Files)
        I = imread(imds.Files{i,1});
        EmbryoMask = ~im2bw(I,graythresh(I));
        EmbryoMask = imfill(EmbryoMask,'holes');
        cc = bwconncomp(EmbryoMask);
        pstats = regionprops(cc,'Area');
        A = [pstats.Area];
        Area = [Area, A(1,1)];
    end
    NewS(ii,1:length(imds.Files)) = Area;
    
end
