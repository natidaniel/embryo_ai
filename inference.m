%% Inference embryo model
clear;clc;close all

%% Data Configuration
numStages = 7; % for chosing related training set
periodHr = 94; % video period time
path_inference = '\images\';
file_vpath= '\path_of_embryo_video\';
video_n= 'Embryo_inference_video.avi';
Vidsmooth = 'TRUE'; 

%% Model Load
if numStages == 7
    load('trainedNet-7.mat')
	statq=[1,4,8,12,32,36,24]; % for visualization
elseif numStages == 9
    load('trainedNet-9.mat');
	statq=[1,4,8,12,32,38,35,42,24]; % for visualization
end

%% Data Preparation
% Data store
imds1 = imageDatastore(path_inference,'IncludeSubfolders',true,'LabelSource','foldernames');
imds1_pred = augmentedImageDatastore(inputSize(1:2),imds1);

% Model Classification
[YPred1,probs1] = classify(trainedNet,imds1_pred);
C = categories(YPred1);
stat1=zeros(1,periodHr);
for ii=1:numStages
    ct=YPred1==C(ii);
    stat1(ct==1)=statq(ii);
end

% Smooth stages
if strcmp(Vidsmooth,'TRUE')
    [stat1, st_arr] = smooth_stat(stat1, periodHr);
    YPred1 = align_YPred(stat1, numStages);
end

% Detecting Die
if numStages == 7
    if strcmp(isDie(stat1),'TRUE')
        display('Embryo probably is going to die ...');
    end
end

% Start video capturing
t=1:1:periodHr;
v = VideoWriter(video_n);
open(v)

for i = 1:periodHr
    figure
    I = rgb2gray(readimage(imds1,i));
    subplot(16,3,[1,4])
    imshow(I,[ ]);
    label1 = YPred1(i);
    title(string(label1)+ ", " + num2str(100*max(probs1(i,:)),3) + "%");
    xlabel('Embryo')
    
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
    

    file1=[file_vpath,num2str(i),'.png'];
    saveas(gcf,file1);
    Iv=imread(file1);
    
    for jj=1:numStages
        writeVideo(v,Iv)
    end  
end

%% Close video capturing
close (v);
close all

%% Support functions
% Embryo smooth
function [stat1_o, st_arr] = smooth_stat(stat1, periodHr)
st_arr = [];st_stage = [];
st_arr = [st_arr, 1];st_stage = [st_stage, 1];
for i=2:(length(stat1)-1)
    count_if = 0 ;
    if stat1(i)~=stat1(i-1)
        if i <= (length(stat1)-27) % frames 2-66
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
        elseif ((i > (length(stat1)-27)) && (i < (length(stat1)-6))) % > 50%, frames 67-87
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
        elseif ((i >= (length(stat1)-6)) && (i <= (length(stat1)-2))) % > 50%, frames 88-(periodHr-2)
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
            if (isempty(find(st_stage(:)==stat1(i)))) % last 2 frames
                st_stage = [st_stage, stat1(i)];
                st_arr = [st_arr, i];
            end 
        end
    end
end

stat1_o=[];
for s=1:(length(st_stage)-1)
    if (s == 1)
        stat1_o = [stat1_o, repmat(st_stage(s),(st_arr(s+1)-st_arr(s)),1)];
    else
        stat1_o= padconcatenation(stat1_o,repmat(st_stage(s),(st_arr(s+1)-st_arr(s)),1),1);
    end
end
stat1_o = padconcatenation(stat1_o, repmat(st_stage(end),(periodHr-st_arr(end)+1),1),1);
stat1_o = stat1_o';


function [YPred1_o] = align_YPred(stat1, numStages)
YPred1_o = {};
for i=1:length(stat1)
    if numStages == 7
        switch(stat1(i))
            case 1
                stg = '1cell';
            case 4
                stg = '2cell';
            case 8
                stg = '4cell';
            case 12
                stg = '8cell';
            case 24
                stg = 'Morula';
            case 32
                stg = 'EarlyBlastocyst';
            case 36
                stg = 'LateBlastocyst';
        end
    end
    if numStages ==9    
        switch(stat1(i))
            case 1
                stg = '1cell';
            case 4
                stg = '2cell';
            case 8
                stg = '4cell';
            case 12
                stg = '8cell';
            case 24
                stg = 'Morula';
            case 32
                stg = 'EarlyBlastocyst';
            case 35
                stg = 'FullBlastocyst';
            case 38
                stg = 'ExpandedBlastocyst';
            case 42
                stg = 'HatchedBlastocyst';
        end
    end
YPred1_o{i} = stg;
end
YPred1_o = YPred1_o';
YPred1_o = categorical(YPred1_o);

% Concatenates arrays with different sizes and pads with NaN.
function [catmat]=padconcatenation(a,b,c)
sa=size(a);
sb=size(b);
switch c
    case 1
        tempmat=NaN(sa(1)+sb(1),max([sa(2) sb(2)]));
        tempmat(1:sa(1),1:sa(2))=a;
        tempmat(sa(1)+1:end,1:sb(2))=b;
        
    case 2
        tempmat=NaN(max([sa(1) sb(1)]),sa(2)+sb(2));
        tempmat(1:sa(1),1:sa(2))=a;
        tempmat(1:sb(1),sa(2)+1:end)=b;
end
catmat=tempmat;
end

% Embryo died
function F = isDie(stat1)
statq_d = [0 3 4 12];
d = diff(stat1);
s = sign(d);
c = conv2(s, [1 1 1], 'valid');
p = find(c == -3);
Lia = ismember(statq_d,d);
if ~isempty(p) || sum(Lia) ~=4 
    F = 'TRUE';
else
    F = 'FALSE';
end
end