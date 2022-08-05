
load('emb_alive.mat')

embryo_num = 38;
t = 94;
path='C:\Nati\Embryos\cropped 21per\seg_validation\22_8_18\O\26\4\';

nsortD = 'TRUE';
imds = imageDatastore(path,... 
    'IncludeSubfolders',true, ...
    'LabelSource','foldernames');
if strcmp(nsortD,'TRUE')
    imds.Files = natsortfiles(imds.Files);
end

Area = []
for i =1:t
    I = imread(imds.Files{i,1});
    EmbryoMask = ~im2bw(I,graythresh(I));
    EmbryoMask = imfill(EmbryoMask,'holes');
    cc = bwconncomp(EmbryoMask);
    pstats = regionprops(cc,'Area');
    A = [pstats.Area];
    Area = [Area, A(1,1)];
end

figure(1);
plot(1:t, Area, 'r')
hold on;
plot(1:t,  area_f(embryo_num,1:94), 'b')