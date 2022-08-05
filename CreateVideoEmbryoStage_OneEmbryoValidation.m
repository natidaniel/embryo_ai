numStages = 7; % for chosing related training set 
if numStages == 7
    load('ResNet50_97_2.mat');
    load('trainedNet_ResNet.mat')
elseif numStages == 9
    load('BlastoExtAll.mat');
end
UseriMode = 'TRUE'; % if false, use Ig mode
Vidsmooth = 'FALSE'; % TODO
DebugMode = 'FALSE';
Ig = 666;

path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\O\28\7\';
path_out_seg= 'C:\Nati\Embryos\seg\21per\22_8_18\O\28\7\validation\';
morp_path = 'C:\Nati\Embryos\cropped 21per\morp\22_8_18\O\28\7\Embryosstats\';
file_vpath= 'C:\Nati\Embryos\seg\videos\21per\overide\';
validation_path = 'C:\Nati\Embryos\Videos\validation\';
video_n= 'Embryo_x.avi';
path_train = path_cell1; 
path_out = path_cell1;
transform2D_to_3D;


imds1 = imageDatastore(path_cell1,'IncludeSubfolders',true,'LabelSource','foldernames');
imds1_pred = augmentedImageDatastore(inputSize(1:2),imds1);
[YPred1,probs1] = classify(trainedNet,imds1_pred);


periodHr = 94;%97;
Embryosstats = zeros(25,periodHr);
ValidationError = zeros(1,periodHr);

C = categories(YPred1);
stat1=zeros(1,periodHr);

if numStages == 7
    statq=[1,4,8,12,32,36,24]; 
    % statq=[1,2,4,8,200,300,16]; for 7 stages
elseif numStages == 9
    statq=[1,4,8,12,32,38,35,42,24]; 
    % statq=[1,2,4,8,200,250,220,300,16]; 
end    

for ii=1:numStages
    ct=YPred1==C(ii);
    stat1(ct==1)=statq(ii);
end

for i=1:periodHr
    ValidationError(1,i) = 100*max(probs1(i,:));
end

t=1:1:periodHr;
v = VideoWriter(video_n);

open(v)

for i = 1:periodHr
    ri = i; % for determining the ri in IPSegToEmbryo
    figure
    I = rgb2gray(readimage(imds1,i));
    IPSegToEmbryo;

    subplot(13,3,[1,4,7])
    imshow(I,[ ]);
    
    label1 = YPred1(i);
    title(string(label1)+ ", " + num2str(100*max(probs1(i,:)),3) + "%");
    xlabel('Embryo')
    
    subplot(13,3,[3,6,9])
    imshow(rLayer);
    title('Embryo Segmented');
    
    
    subplot(13,3,10:27)
    plot(t(1:i),stat1(1:i),'-bo')
    h=gca;
    if numStages == 7
        set(h,'ytick',[1 4 8 12 24 32 36],'yticklabel',{'1cell','2cell','4cell','8cell','morula','EarlyBlasto','LateBlasto'},'fontsize', 5);   
        ylim([1 40])
    elseif numStages == 9
        set(h,'ytick',[1 4 8 12 24 32 35 38 42],'yticklabel',{'1cell','2cell','4cell','8cell','morula','EarlyBlasto','FullBlasto','ExpandedBlasto','HatchedBlasto'},'fontsize', 5);   
        ylim([1 45])
    end    

    title ('Embryo State:')
    xlabel ('Time [hours]');
    %ylabel ('Number of cells');

    subplot(13,3,31:39)
    plot(t(1:i),ValidationError(1,1:i))
    h1=gca;
    set(h1, 'fontsize', 5);
    xlabel ('Time [hours]', 'FontSize', 5);
    ylim([0 100]);
    title('Validation accuracy:', 'FontSize', 5);
    
    file1=[file_vpath,num2str(i),'.png'];
    saveas(gcf,file1);
    Iv=imread(file1);
    
    for jj=1:numStages
        writeVideo(v,Iv)
    end  
    
end

st_arr = [];st_stage = [];
st_arr = [st_arr, 1];st_stage = [st_stage, 1];
for i=2:(length(stat1)-1)
    count_if = 0 ;
    if stat1(i)~=stat1(i-1)
        if i <= (length(stat1)-27)
            if stat1(i)==stat1(i+1)
                count_if =count_if+1;
            end
            if stat1(i)==stat1(i+2)
                count_if =count_if+1;
            end
            if stat1(i)==stat1(i+3)
                count_if =count_if+1;
            end
            if stat1(i)==stat1(i+4)
                count_if =count_if+1;
            end
            if ((count_if >= 3) && isempty(find(st_stage(:)==stat1(i)))) % > 60%
                st_stage = [st_stage, stat1(i)];
                st_arr = [st_arr, i];
            end 
        elseif ((i > (length(stat1)-27)) && (i < (length(stat1)-6))) % > 50%
            if stat1(i)==stat1(i+1)
                count_if =count_if+1;
            end
            if stat1(i)==stat1(i+2)
                count_if =count_if+1;
            end
            if stat1(i)==stat1(i+3)
                count_if =count_if+1;
            end
            if stat1(i)==stat1(i+4)
                count_if =count_if+1;
            end
            if ((count_if >= 2) && isempty(find(st_stage(:)==stat1(i))))  
                st_stage = [st_stage, stat1(i)];
                st_arr = [st_arr, i];
            end 
        elseif ((i >= (length(stat1)-6)) && (i <= (length(stat1)-2))) % > 50%
            if stat1(i)==stat1(i+1)
                count_if =count_if+1;
            end
            if stat1(i)==stat1(i+2)
                count_if =count_if+1;
            end
            if ((count_if >=1) && isempty(find(st_stage(:)==stat1(i))))
                st_stage = [st_stage, stat1(i)];
                st_arr = [st_arr, i];
            end 
        else
            if (isempty(find(st_stage(:)==stat1(i))))
                st_stage = [st_stage, stat1(i)];
                st_arr = [st_arr, i];
            end 
        end
    end
end

for j=2:length(st_arr)
    imwrite(readimage(imds1,st_arr(j)-1),[validation_path,d1(st_arr(j)-1+2).name]); % save before jump 
    imwrite(readimage(imds1,st_arr(j)),[validation_path,d1(st_arr(j)+2).name]); % save jump image
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

%% plot ststs
figure;title('Embryo development');
fg=1;subplot(5,5,fg);
plot(t(1:periodHr),Embryosstats(1,1:periodHr))
xlabel ('Time [hours]');
title('Area:');

fg = fg +1;subplot(5,5,fg);
plot(t(1:i),Embryosstats(2,1:i))
xlabel ('Time [hours]');
title('Diameter:');

fg = fg +1;subplot(5,5,fg);
plot(t(1:i),Embryosstats(3,1:i))
xlabel ('Time [hours]');
title('Perimeter:');

fg = fg +1;subplot(5,5,fg);
plot(t(1:i),Embryosstats(4,1:i))
xlabel ('Time [hours]');
title('Eccentricity:');

fg = fg +1;subplot(5,5,fg);
plot(t(1:i),Embryosstats(5,1:i))
xlabel ('Time [hours]');
title('Autocorrelation:');

fg = fg +1;subplot(5,5,fg);
plot(t(1:i),Embryosstats(6,1:i))
xlabel ('Time [hours]');
title('Contrast:');

fg = fg +1;subplot(5,5,fg);
plot(t(1:i),Embryosstats(7,1:i))
xlabel ('Time [hours]');
title('Correlation:');

fg = fg +1;subplot(5,5,fg);
plot(t(1:i),Embryosstats(8,1:i))
xlabel ('Time [hours]');
title('Cluster Prominence:');

fg = fg +1;subplot(5,5,fg);
plot(t(1:i),Embryosstats(9,1:i))
xlabel ('Time [hours]');
title('Cluster Shade:');

fg = fg +1;subplot(5,5,fg);
plot(t(1:i),Embryosstats(10,1:i))
xlabel ('Time [hours]');
title('Dissimilarity:');

fg = fg +1;subplot(5,5,fg);
plot(t(1:i),Embryosstats(11,1:i))
xlabel ('Time [hours]');
title('Energy:');

fg = fg +1;subplot(5,5,fg);
plot(t(1:i),Embryosstats(12,1:i))
xlabel ('Time [hours]');
title('Entropy:');

fg = fg +1;subplot(5,5,fg);
plot(t(1:i),Embryosstats(13,1:i))
xlabel ('Time [hours]');
title('Homogeneity:');

fg = fg +1;subplot(5,5,fg);
plot(t(1:i),Embryosstats(14,1:i))
xlabel ('Time [hours]');
title('Maximum Probability:');

fg = fg +1;subplot(5,5,fg);
plot(t(1:i),Embryosstats(15,1:i))
xlabel ('Time [hours]');
title('Variance:');

fg = fg +1;subplot(5,5,fg);
plot(t(1:i),Embryosstats(16,1:i))
xlabel ('Time [hours]');
title('Smoothness:');

fg = fg +1;subplot(5,5,fg);
plot(t(1:i),Embryosstats(17,1:i))
xlabel ('Time [hours]');
title('Sum Everage:');

fg = fg +1;subplot(5,5,fg);
plot(t(1:i),Embryosstats(18,1:i))
xlabel ('Time [hours]');
title('Sum Variance:');

fg = fg +1;subplot(5,5,fg);
plot(t(1:i),Embryosstats(19,1:i))
xlabel ('Time [hours]');
title('Sum Entropy:');

fg = fg +1;subplot(5,5,fg);
plot(t(1:i),Embryosstats(20,1:i))
xlabel ('Time [hours]');
title('Difference Variance:');

fg = fg +1;subplot(5,5,fg);
plot(t(1:i),Embryosstats(21,1:i))
xlabel ('Time [hours]');
title('Difference Entropy:');

fg = fg +1;subplot(5,5,fg);
plot(t(1:i),Embryosstats(22,1:i))
xlabel ('Time [hours]');
title('Info Measure Of Correlation:');

fg = fg +1;subplot(5,5,fg);
plot(t(1:i),Embryosstats(23,1:i))
xlabel ('Time [hours]');
title('Inverse Difference Normalized:');

fg = fg +1;subplot(5,5,fg);
plot(t(1:i),Embryosstats(24,1:i))
xlabel ('Time [hours]');
title('Inverse Difference Moment:');

fg = fg +1;subplot(5,5,fg);
plot(t(1:i),Embryosstats(25,1:i))
xlabel ('Time [hours]');
title('Roundness:');
%%
save(morp_path,'Embryosstats');
close all