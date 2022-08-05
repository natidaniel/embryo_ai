function Embryosstats = Embryosstats_wEF (path_cell1, path_out_seg, periodHr, nsortD)  
numStages = 7; % for chosing related training set 
if numStages == 7
    load('RN50.mat')
elseif numStages == 9
    load('BlastoExtAll.mat');
end
UseriMode = 'TRUE'; % if false, use Ig mode
Vidsmooth = 'TRUE'; 
RegVis = 'FALSE';
NormVis = 'FALSE';
Ig = 666;

%path_out_seg= 'C:\Nati\Embryos\seg\21per\tmp\';
file_vpath= 'C:\Nati\Embryos\seg\videos\21per\overide\';

video_n= 'Embryo_tmp.avi';
path_train = path_cell1; 
path_out = path_cell1;
transform2D_to_3D;

imds1 = imageDatastore(path_cell1,'IncludeSubfolders',true,'LabelSource','foldernames');
if strcmp(nsortD,'TRUE')
    imds1.Files = natsortfiles(imds1.Files);
end
imds1_pred = augmentedImageDatastore(inputSize(1:2),imds1);
[YPred1,probs1] = classify(trainedNet,imds1_pred);

Embryosstats = zeros(45,periodHr);

C = categories(YPred1);
stat1=zeros(1,periodHr);

if numStages == 7
    statq=[1,4,8,12,32,36,24]; 
elseif numStages == 9
    statq=[1,4,8,12,32,38,35,42,24]; 
end    

for ii=1:numStages
    ct=YPred1==C(ii);
    stat1(ct==1)=statq(ii);
end

if strcmp(Vidsmooth,'TRUE')
    [stat1, st_arr] = smooth_stat(stat1, periodHr);
    YPred1 = align_YPred(stat1, numStages);
end

t=1:1:periodHr;
if strcmp(RegVis,'TRUE')
    v = VideoWriter(video_n);
    open(v)
end

for i = 1:periodHr
    I = rgb2gray(readimage(imds1,i));
    ri = i; % for determining the ri in IPSegToEmbryo
    IPSegToEmbryo;
    
    if strcmp(RegVis,'TRUE')
        figure
        subplot(16,3,[1,4])
        imshow(I,[ ]);

        label1 = YPred1(i);
        title(string(label1)+ ", " + num2str(100*max(probs1(i,:)),3) + "%");
        xlabel('Embryo')

        subplot(16,3,[3,6])
        imshow(rLayer);
        title('Embryo Segmented');


        subplot(16,3,7:24)
        plot(t(1:i),stat1(1:i),'-bo')
        h=gca;
        if numStages == 7
            set(h,'ytick',[1 4 8 12 24 32 36],'yticklabel',{'1cell','2cell','4cell','8cell','morula','EarlyBlasto','LateBlasto'},'fontsize', 5);   
            ylim([1 40])
        elseif numStages == 9
            set(h,'ytick',[1 4 8 12 24 32 35 38 42],'yticklabel',{'1cell','2cell','4cell','8cell','morula','EarlyBlasto','FullBlasto','ExpandedBlasto','HatchedBlasto'},'fontsize', 5);   
            ylim([1 45])
        end    
    
        title ('Embryonic Development:','fontsize', 7)
        xlabel ('Time [hours]','fontsize', 7);
        ylabel ('Embryo stage','fontsize', 7);

        subplot(16,3,31:48)
        plot(t(1:i),Embryosstats(1,1:i))
        title('Embryo Area:','fontsize', 7);
        xlabel ('Time [hours]','fontsize', 7);
        ylabel ('pixels','fontsize', 7);


        file1=[file_vpath,num2str(i),'.png'];
        saveas(gcf,file1);
        Iv=imread(file1);

        % save video
        for jj=1:numStages
            writeVideo(v,Iv)
        end  
    elseif strcmp(NormVis,'TRUE')
        figure
        subplot(12,4,[1:2,5:6])
        imshow(I,[ ]);
        title('Embryo')
        
        subplot(12,4,[3:4,7:8])
        imshow(rLayer);
        title('Embryo Segmented');
        
        subplot(12,4,31:48)
        plot(t(1:i),Embryosstats(1,1:i))
        title('Embryo Area:','fontsize', 7);
        xlabel ('Time [hours]','fontsize', 7);
        ylabel ('pixels','fontsize', 7);


        file1=[file_vpath,num2str(i),'.png'];
        saveas(gcf,file1);
        else
            disp('under running, please dont stop')
    end
end

%%
if strcmp(RegVis,'TRUE')
    close (v);
end
close all
end