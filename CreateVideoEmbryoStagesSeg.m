
path_cell1='C:\Nati\Embryos\cropped_06_09_18\crop_final\15\png\3v\';
path_out_seg1 = 'C:\Nati\Embryos\seg\15\3\';
path_cell2='C:\Nati\Embryos\cropped_06_09_18\crop_final\14\png\2v\';%embryo2
path_out_seg2='C:\Nati\Embryos\seg\14\2\';
path_train = path_cell1; 
path_out = path_cell1;
transform2D_to_3D;
%embryo2
path_train = path_cell2; 
path_out = path_cell2;
transform2D_to_3D;

imds1 = imageDatastore(path_cell1,'IncludeSubfolders',true,'LabelSource','foldernames');
imds1_pred = augmentedImageDatastore(inputSize(1:2),imds1);
[YPred1,probs1] = classify(trainedNet,imds1_pred);
%embryo2
imds2 = imageDatastore(path_cell2,'IncludeSubfolders',true,'LabelSource','foldernames');
imds2_pred = augmentedImageDatastore(inputSize(1:2),imds2);
[YPred2,probs2] = classify(trainedNet,imds2_pred);


periodHr = 97;
%numStages = 7;
numStages = 9;

C = categories(YPred1);
C2 = categories(YPred2);
stat1=zeros(1,periodHr);
stat2=zeros(1,periodHr);

% statq=[1,2,4,8,200,300,16]; for 7 stages
% The cell number are not real.It is done only for plotting. real vlaues are above.
%statq=[1,4,8,12,32,36,24]; 
statq=[1,4,8,12,32,38,35,42,24]; 
for ii=1:numStages
    ct=YPred1==C(ii);
    ct1=YPred2==C2(ii);
    stat1(ct==1)=statq(ii);
    stat2(ct1==1)=statq(ii);
end

t=1:1:periodHr;
v = VideoWriter('Embryo_15_3v_14_2v.avi');

open(v)

for i = 1:periodHr
    figure
    I = rgb2gray(readimage(imds1,i));
    rLayerI = ImgSeg(imds1,i,path_out_seg1);
    I1 = rgb2gray(readimage(imds2,i));
    rLayerI1 = ImgSeg(imds2,i,path_out_seg2);
    
    subplot(2,2,1)
    imshow(rLayerI);
    label1 = YPred1(i);
    title({"Embryo 1 Segmented"; string(label1)+ ", " + num2str(100*max(probs1(i,:)),3) + "%"});
    
    subplot(2,2,2)
    imshow(rLayerI1);
    label2 = YPred2(i);
    title({"Embryo 2 Segmented"; string(label2)+ ", " + num2str(100*max(probs2(i,:)),3) + "%"});
 
    
    subplot(2,2,[3,4])
    plot(t(1:i),stat1(1:i),'-bo')
    hold on
    plot(t(1:i),stat2(1:i),'-r*')
    legend('Embryo 1','Embryo 2','Location','westoutside')
    h=gca;
    %set(h,'ytick',[1 4 8 12 24 32 36],'yticklabel',{'1cell','2cell','4cell','8cell','morula','EarlyBlasto','LateBlasto'});   
    set(h,'ytick',[1 4 8 12 24 32 35 38 42],'yticklabel',{'1cell','2cell','4cell','8cell','morula','EarlyBlasto','FullBlasto','ExpandedBlasto','HatchedBlasto'});   
    %ylim([1 40])
    ylim([1 45])
    title ('Embryo State:')
    xlabel ('Time [hours]');
    ylabel ('Number of cells');

    
    file1=['C:\Nati\Embryos\Videos\double\14_2_15_1\',num2str(i),'.png'];
    saveas(gcf,file1);
    Iv=imread(file1);
    
    for jj=1:numStages
    writeVideo(v,Iv)
    end  
    
end

close (v);
close all
