numStages = 7; % for chosing related training set 
if numStages == 7
    load('RN50.mat')
elseif numStages == 9
    load('BlastoExtAll.mat');
end

Vidsmooth = 'TRUE'; 
DebugMode = 'FALSE';


path_cell1= 'C:\Nati\Embryos\cropped 21per\9_8_18\O\1\1\';
path_out_seg= 'C:\Nati\Embryos\seg\21per\tmp\';
morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\9_8_18\O\1\1\';
file_vpath= 'C:\Nati\Embryos\seg\videos\21per\overide\';

video_n= 'Embryo_tmp.avi';
path_train = path_cell1; 
path_out = path_cell1;
transform2D_to_3D;

imds1 = imageDatastore(path_cell1,'IncludeSubfolders',true,'LabelSource','foldernames');
imds1_pred = augmentedImageDatastore(inputSize(1:2),imds1);
[YPred1,probs1] = classify(trainedNet,imds1_pred);

periodHr = 97;%94;
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
v = VideoWriter(video_n);

open(v)

for i = 1:periodHr
    ri = i; % for determining the ri in IPSegToEmbryo
    figure
    I = rgb2gray(readimage(imds1,i));
    IPSegToEmbryo;

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
    
    for jj=1:numStages
        writeVideo(v,Iv)
    end  
    
end


if strcmp(DebugMode,'TRUE')
    if length(st_stage)~=numStages
        idx=find(~ismember(statq',st_stage','rows'));
        for i=1:length(idx)
            switch idx(i)
                case 1
                    disp('Zygote missed');
                case 2
                    disp('2cell missed');
                case 3
                    disp('4cell missed');
                case 4
                    disp('8cell missed');
                case 5
                    disp('EB missed');
                case 6
                    if numStages==7 
                        disp('LB missed');
                    elseif numStages==9 
                        disp('ExB missed');
                    end
                case 7
                    if numStages==7 
                        disp('Morula missed');
                    elseif numStages==9 
                        disp('FB missed');
                    end
                case 8
                    disp('HB missed');
                case 9
                    disp('Morula missed');
                otherwise
                    disp('NaN')
            end    
        end
    end
end
%%
close (v);
close all

%%
save(fullfile(morp_path,'Embryosstats'));
close all