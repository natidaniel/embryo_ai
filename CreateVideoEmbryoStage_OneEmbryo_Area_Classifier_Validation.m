%video with unsupervised learning model
close all;clear;clc;
warning('off', 'Images:initSize:adjustingMag');
numStages = 7; % for chosing related training set 

if numStages == 7
    load('RN50.mat')
    %load('trainedNet_ResNet.mat');inputSize=[224 224 3];
elseif numStages == 9
    load('BlastoExtAll.mat');
end

UseriMode = 'TRUE';
Vidsmooth = 'TRUE'; 
DebugMode = 'FALSE';
UseYoungData = 'TRUE';
UseOldData = 'FALSE';
Ig = 666;

ckpt = [24, 48, 72]; %1d,2d,3d

path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\Y\21\4\';
path_out_seg= 'C:\Nati\Embryos\4Yoni\Embryo Deep learning\images\Y\22_8\21\4\s\';
morp_path = 'C:\Nati\Embryos\4Yoni\Embryo Deep learning\images\Y\22_8\21\4\m\';
file_vpath= 'C:\Nati\Embryos\4Yoni\Embryo Deep learning\images\Y\22_8\21\4\v\';
validation_path = 'C:\Nati\Embryos\4Yoni\Embryo Deep learning\images\Y\22_8\21\4\validation\';
video_n= 'Embryo_y_21_4_unsupervised_learning.avi';
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
elseif numStages == 9
    statq=[1,4,8,12,32,38,35,42,24]; 
end    

for ii=1:numStages
    ct=YPred1==C(ii);
    stat1(ct==1)=statq(ii);
end


for i=1:periodHr
    ValidationError(1,i) = 100*max(probs1(i,:));
    if i == 1
        ValidationMeanError(1,i)=ValidationError(1,i);
    else
        ValidationMeanError(1,i)=mean(ValidationError(1,1:i));
    end
end

if strcmp(Vidsmooth,'TRUE')
    [stat1, st_arr] = smooth_stat(stat1, periodHr);
    YPred1 = align_YPred(stat1, numStages);
end

if strcmp(UseYoungData,'TRUE')
    morp_idx = [1,4,7,11,16,26];
end

if strcmp(UseOldData,'TRUE')
    morp_idx = [1,4,6,9,16,25,26];
end

t=1:1:periodHr;
v = VideoWriter(video_n);

open(v)

for i = 1:periodHr
    ri = i; % for determining the ri in IPSegToEmbryo
    figure
    I = rgb2gray(readimage(imds1,i));
    IPSegToEmbryo; %segment I
    
    % predict of embryo survived to full blasto stage in 3 different
    % checkpoints
	% TO-DO reduce the Embryosstats(choose onlu the indexes of trained and reduced morps,i)'
    if ismember(i, ckpt)
        if numStages == 7
            switch(stat1(i))
                case 1
                    if strcmp(UseYoungData,'TRUE')
                        morp_one_embryo = Embryosstats(:,i)';
                        morp_one_embryo(1,26)=i;
                        morp_one_embryo = morp_one_embryo(morp_idx);
                        load('C:\Nati\Embryos\4Yoni\Embryo Deep learning\TrainedModels\R_M_D\1cell\Y\trained1cell_Y_EnsembleModel.mat');
                        trained_classifier = trained1cell_Y_EnsembleModel;
                        pEmbryoSurvived = trained_classifier.predictFcn(morp_one_embryo);
                        if pEmbryoSurvived == 0
                            EmbryoSurvived = 'No';
                        else
                            EmbryoSurvived = 'Yes';
                        end
                        Ensembledl = trained_classifier.ClassificationEnsemble;
                        [label,score] = predict(Ensembledl,morp_one_embryo);pscore = score(pEmbryoSurvived+1)*100;
                        format shortG;
                        tp = sprintf('%d', pscore);
                        A = 'Embryo will arrive to blastocyst stage? A: ';pbs = [A EmbryoSurvived ', ' tp '%'];
                        %disp(pbs);
                        Text = sprintf('Blastosyct Potential? A: %s\n      Success Rate is %.2f%s\n',EmbryoSurvived,pscore,'%'); 
                    elseif strcmp(UseOldData,'TRUE')
                        morp_one_embryo = Embryosstats(:,i)';
                        morp_one_embryo(1,26)=i;
                        morp_one_embryo = morp_one_embryo(morp_idx);
                        load('C:\Nati\Embryos\4Yoni\Embryo Deep learning\R_M_D\1cell\O\trained1cell_O_EnsembleModel.mat');
                        trained_classifier = trained1cell_O_EnsembleModel;
                        pEmbryoSurvived = trained_classifier.predictFcn(morp_one_embryo);
                        if pEmbryoSurvived == 0
                            EmbryoSurvived = 'No';
                        else
                            EmbryoSurvived = 'Yes';
                        end
                        Ensembledl = trained_classifier.ClassificationEnsemble;
                        [label,score] = predict(Ensembledl,morp_one_embryo);pscore = score(pEmbryoSurvived+1)*100;
                        format shortG;
                        tp = sprintf('%d', pscore);
                        A = 'Embryo will arrive to blastocyst stage? A: ';pbs = [A EmbryoSurvived ', ' tp '%'];
                        %disp(pbs);
                        Text = sprintf('Blastosyct Potential? A: %s\n      Success Rate is %.2f%s\n',EmbryoSurvived,pscore,'%');  
                    end
                case 4
                    if strcmp(UseYoungData,'TRUE')
                        morp_one_embryo = Embryosstats(:,i)';
                        morp_one_embryo(1,26)=i;
                        morp_one_embryo = morp_one_embryo(morp_idx);
                        load('C:\Nati\Embryos\4Yoni\Embryo Deep learning\TrainedModels\R_M_D\2cell\Y\trained2cell_Y_EnsembleModel.mat');
                        trained_classifier = trained2cell_Y_EnsembleModel;
                        pEmbryoSurvived = trained_classifier.predictFcn(morp_one_embryo);
                        if pEmbryoSurvived == 0
                            EmbryoSurvived = 'No';
                        else
                            EmbryoSurvived = 'Yes';
                        end
                        Ensembledl = trained_classifier.ClassificationEnsemble;
                        [label,score] = predict(Ensembledl,morp_one_embryo);pscore = score(pEmbryoSurvived+1)*100;
                        format shortG;
                        tp = sprintf('%d', pscore);
                        A = 'Embryo will arrive to blastocyst stage? A: ';pbs = [A EmbryoSurvived ', ' tp '%'];
                        %disp(pbs);
                        Text = sprintf('Blastosyct Potential? A: %s\n      Success Rate is %.2f%s\n',EmbryoSurvived,pscore,'%');  
                    elseif strcmp(UseOldData,'TRUE')
                        morp_one_embryo = Embryosstats(:,i)';
                        morp_one_embryo(1,26)=i;
                        morp_one_embryo = morp_one_embryo(morp_idx);
                        load('C:\Nati\Embryos\4Yoni\Embryo Deep learning\TrainedModels\R_M_D\2cell\O\trained2cell_O_SVMModel.mat');
                        trained_classifier = trained2cell_O_SVMModel;
                        pEmbryoSurvived = trained_classifier.predictFcn(morp_one_embryo);
                        if pEmbryoSurvived == 0
                            EmbryoSurvived = 'No';
                        else
                            EmbryoSurvived = 'Yes';
                        end
                        SVMdl = trained_classifier.ClassificationSVM;
                        [label,score] = predict(SVMdl,morp_one_embryo);pscore = score(pEmbryoSurvived+1)*100;
                        format shortG;
                        tp = sprintf('%d', pscore);
                        A = 'Embryo will arrive to blastocyst stage? A: ';pbs = [A EmbryoSurvived ', ' tp '%'];
                        %disp(pbs);
                        Text = sprintf('Blastosyct Potential? A: %s\n      Success Rate is %.2f%s\n',EmbryoSurvived,pscore,'%');  
                    end
                case 8
                    if strcmp(UseYoungData,'TRUE')
                        morp_one_embryo = Embryosstats(:,i)';
                        morp_one_embryo(1,26)=i;
                        morp_one_embryo = morp_one_embryo(morp_idx);
                        load('C:\Nati\Embryos\4Yoni\Embryo Deep learning\TrainedModels\R_M_D\4cell\Y\trained4cell_Y_EnsembleModel.mat');
                        trained_classifier = trained4cell_Y_EnsembleModel;
                        pEmbryoSurvived = trained_classifier.predictFcn(morp_one_embryo);
                        if pEmbryoSurvived == 0
                            EmbryoSurvived = 'No';
                        else
                            EmbryoSurvived = 'Yes';
                        end
                        Ensembledl = trained_classifier.ClassificationEnsemble;
                        [label,score] = predict(Ensembledl,morp_one_embryo);pscore = score(pEmbryoSurvived+1)*100;
                        format shortG;
                        tp = sprintf('%d', pscore);
                        A = 'Embryo will arrive to blastocyst stage? A: ';pbs = [A EmbryoSurvived ', ' tp '%'];
                        %disp(pbs);
                        Text = sprintf('Blastosyct Potential? A: %s\n      Success Rate is %.2f%s\n',EmbryoSurvived,pscore,'%');  
                    elseif strcmp(UseOldData,'TRUE')
                        morp_one_embryo = Embryosstats(:,i)';
                        morp_one_embryo(1,26)=i;
                        morp_one_embryo = morp_one_embryo(morp_idx);
                        load('C:\Nati\Embryos\4Yoni\Embryo Deep learning\TrainedModels\R_M_D\4cell\O\trained4cell_O_TreeModel.mat');
                        trained_classifier = trained4cell_O_TreeModel;
                        pEmbryoSurvived = trained_classifier.predictFcn(morp_one_embryo);
                        if pEmbryoSurvived == 0
                            EmbryoSurvived = 'No';
                        else
                            EmbryoSurvived = 'Yes';
                        end
                        Treedl = trained_classifier.ClassificationTree;
                        [label,score] = predict(Treedl,morp_one_embryo);pscore = score(pEmbryoSurvived+1)*100;
                        format shortG;
                        tp = sprintf('%d', pscore);
                        A = 'Embryo will arrive to blastocyst stage? A: ';pbs = [A EmbryoSurvived ', ' tp '%'];
                        %disp(pbs);
                        Text = sprintf('Blastosyct Potential? A: %s\n      Success Rate is %.2f%s\n',EmbryoSurvived,pscore,'%');  
                    end
                case 12
                    if strcmp(UseYoungData,'TRUE')
                        morp_one_embryo = Embryosstats(:,i)';
                        morp_one_embryo(1,26)=i;
                        morp_one_embryo = morp_one_embryo(morp_idx);
                        load('C:\Nati\Embryos\4Yoni\Embryo Deep learning\TrainedModels\R_M_D\8cell\Y\trained8cell_Y_EnsembleModel.mat');
                        trained_classifier = trained8cell_Y_EnsembleModel;
                        pEmbryoSurvived = trained_classifier.predictFcn(morp_one_embryo);
                        if pEmbryoSurvived == 0
                            EmbryoSurvived = 'No';
                        else
                            EmbryoSurvived = 'Yes';
                        end
                        Ensembledl = trained_classifier.ClassificationEnsemble;
                        [label,score] = predict(Ensembledl,morp_one_embryo);pscore = score(pEmbryoSurvived+1)*100;
                        format shortG;
                        tp = sprintf('%d', pscore);
                        A = 'Embryo will arrive to blastocyst stage? A: ';pbs = [A EmbryoSurvived ', ' tp '%'];
                        %disp(pbs);
                        Text = sprintf('Blastosyct Potential? A: %s\n      Success Rate is %.2f%s\n',EmbryoSurvived,pscore,'%');  
                    elseif strcmp(UseOldData,'TRUE')
                        morp_one_embryo = Embryosstats(:,i)';
                        morp_one_embryo(1,26)=i;
                        morp_one_embryo = morp_one_embryo(morp_idx);
                        load('C:\Nati\Embryos\4Yoni\Embryo Deep learning\TrainedModels\R_M_D\8cell\O\trained8cell_O_EnsembleModel.mat');
                        trained_classifier = trained8cell_O_EnsembleModel;
                        pEmbryoSurvived = trained_classifier.predictFcn(morp_one_embryo);
                        if pEmbryoSurvived == 0
                            EmbryoSurvived = 'No';
                        else
                            EmbryoSurvived = 'Yes';
                        end
                        Ensembledl = trained_classifier.ClassificationEnsemble;
                        [label,score] = predict(Ensembledl,morp_one_embryo);pscore = score(pEmbryoSurvived+1)*100;
                        format shortG;
                        tp = sprintf('%d', pscore);
                        A = 'Embryo will arrive to blastocyst stage? A: ';pbs = [A EmbryoSurvived ', ' tp '%'];
                        %disp(pbs);
                        Text = sprintf('Blastosyct Potential? A: %s\n      Success Rate is %.2f%s\n',EmbryoSurvived,pscore,'%');  
                    end
                case 24
                    if strcmp(UseYoungData,'TRUE')
                        morp_one_embryo = Embryosstats(:,i)';
                        morp_one_embryo(1,26)=i;
                        morp_one_embryo = morp_one_embryo(morp_idx);
                        load('C:\Nati\Embryos\4Yoni\Embryo Deep learning\TrainedModels\R_M_D\Morula\Y\trainedMorula_Y_EnsembleModel.mat');
                        trained_classifier = trainedMorula_Y_EnsembleModel;
                        pEmbryoSurvived = trained_classifier.predictFcn(morp_one_embryo);
                        if pEmbryoSurvived == 0
                            EmbryoSurvived = 'No';
                        else
                            EmbryoSurvived = 'Yes';
                        end
                        Ensembledl = trained_classifier.ClassificationEnsemble;
                        [label,score] = predict(Ensembledl,morp_one_embryo);pscore = score(pEmbryoSurvived+1)*100;
                        format shortG;
                        tp = sprintf('%d', pscore);
                        A = 'Embryo will arrive to blastocyst stage? A: ';pbs = [A EmbryoSurvived ', ' tp '%'];
                        %disp(pbs);
                        Text = sprintf('Blastosyct Potential? A: %s\n      Success Rate is %.2f%s\n',EmbryoSurvived,pscore,'%');  
                    elseif strcmp(UseOldData,'TRUE')
                        morp_one_embryo = Embryosstats(:,i)';
                        morp_one_embryo(1,26)=i;
                        morp_one_embryo = morp_one_embryo(morp_idx);
                        load('C:\Nati\Embryos\4Yoni\Embryo Deep learning\TrainedModels\R_M_D\Morula\O\trainedMorula_O_EnsembleModel.mat');
                        trained_classifier = trainedMorula_O_EnsembleModel;
                        pEmbryoSurvived = trained_classifier.predictFcn(morp_one_embryo);
                        if pEmbryoSurvived == 0
                            EmbryoSurvived = 'No';
                        else
                            EmbryoSurvived = 'Yes';
                        end
                        Ensembledl = trained_classifier.ClassificationEnsemble;
                        [label,score] = predict(Ensembledl,morp_one_embryo);pscore = score(pEmbryoSurvived+1)*100;
                        format shortG;
                        tp = sprintf('%d', pscore);
                        A = 'Embryo will arrive to blastocyst stage? A: ';pbs = [A EmbryoSurvived ', ' tp '%'];
                        %disp(pbs);
                        Text = sprintf('Blastosyct Potential? A: %s\n      Success Rate is %.2f%s\n',EmbryoSurvived,pscore,'%');  
                    end
                case 32
                    if strcmp(UseYoungData,'TRUE')
                        morp_one_embryo = Embryosstats(:,i)';
                        morp_one_embryo(1,26)=i;
                        morp_one_embryo = morp_one_embryo(morp_idx);
                        load('C:\Nati\Embryos\4Yoni\Embryo Deep learning\TrainedModels\R_M_D\EarlyBlasto\Y\trainedEB_Y_EnsembleModel.mat');
                        trained_classifier = trainedEB_Y_EnsembleModel;
                        pEmbryoSurvived = trained_classifier.predictFcn(morp_one_embryo);
                        if pEmbryoSurvived == 0
                            EmbryoSurvived = 'No';
                        else
                            EmbryoSurvived = 'Yes';
                        end
                        Ensembledl = trained_classifier.ClassificationEnsemble;
                        [label,score] = predict(Ensembledl,morp_one_embryo);pscore = score(pEmbryoSurvived+1)*100;
                        format shortG;
                        tp = sprintf('%d', pscore);
                        A = 'Embryo will arrive to blastocyst stage? A: ';pbs = [A EmbryoSurvived ', ' tp '%'];
                        %disp(pbs);
                        Text = sprintf('Blastosyct Potential? A: %s\n      Success Rate is %.2f%s\n',EmbryoSurvived,pscore,'%');  
                    elseif strcmp(UseOldData,'TRUE')
                        morp_one_embryo = Embryosstats(:,i)';
                        morp_one_embryo(1,26)=i;
                        morp_one_embryo = morp_one_embryo(morp_idx);
                        load('C:\Nati\Embryos\4Yoni\Embryo Deep learning\TrainedModels\R_M_D\EarlyBlasto\O\trainedEB_O_EnsembleModel.mat');
                        trained_classifier = trainedEB_O_EnsembleModel;
                        pEmbryoSurvived = trained_classifier.predictFcn(morp_one_embryo);
                        if pEmbryoSurvived == 0
                            EmbryoSurvived = 'No';
                        else
                            EmbryoSurvived = 'Yes';
                        end
                        Ensembledl = trained_classifier.ClassificationEnsemble;
                        [label,score] = predict(Ensembledl,morp_one_embryo);pscore = score(pEmbryoSurvived+1)*100;
                        format shortG;
                        tp = sprintf('%d', pscore);
                        A = 'Embryo will arrive to blastocyst stage? A: ';pbs = [A EmbryoSurvived ', ' tp '%'];
                        %disp(pbs);
                        Text = sprintf('Blastosyct Potential? A: %s\n      Success Rate is %.2f%s\n',EmbryoSurvived,pscore,'%');  
                    end
                case 36
                    disp('Already in Full Blastocyst stage');
            end
        end
    end

    subplot(19,3,[1,4])
    imshow(I,[ ]);
    label1 = YPred1(i);
    title(string(label1)+ ", " + num2str(100*max(probs1(i,:)),3) + "%");
    xlabel('Embryo')
    
    if ismember(i, ckpt)
        ax = subplot(19,3,[2,5]);
        text(0.05,0.7,Text,'FontSize',7); 
        axis off;
        set ( ax, 'visible', 'off')
    end
    
    subplot(19,3,[3,6])
    imshow(rLayer);
    title('Embryo Segmented');
    
    
    subplot(19,3,7:24)
    plot(t(1:i),stat1(1:i),'-bo')
    h=gca;
    if numStages == 7
        set(h,'ytick',[1 4 8 12 24 32 36],'yticklabel',{'1cell','2cell','4cell','8cell','morula','EarlyBlasto','LateBlasto'},'fontsize', 5);   
        ylim([1 40])
    elseif numStages == 9
        set(h,'ytick',[1 4 8 12 24 32 35 38 42],'yticklabel',{'1cell','2cell','4cell','8cell','morula','EarlyBlasto','FullBlasto','ExpandedBlasto','HatchedBlasto'},'fontsize', 5);   
        ylim([1 45])
    end    

    title ('Embryonic Development:','fontsize', 5)
    xlabel ('Time [hours]','fontsize', 5);
    ylabel ('Embryo stage','fontsize', 5);

    subplot(19,3,31:39)
    plot(t(1:i),Embryosstats(1,1:i))
    title('Embryo Area:','fontsize', 5);
    xlabel ('Time [hours]','fontsize', 5);
    ylabel ('pixels','fontsize', 5);
    
    subplot(19,3,49:57)
    plot(t(1:i),ValidationError(1,1:i))
    hold on;
    plot(t(1:i),ValidationMeanError(1,1:i),'m')
    ylim([0 100]);
    title('Validation Inference:', 'FontSize', 5);
    xlabel ('Time [hours]', 'FontSize', 5);
    ylabel ('Accuracy [%]','fontsize', 5);
    legend({'Momentary Accuracy','Average Accuracy'},'Location','southwest','FontSize',5)
    legend('boxoff')

    MAA = ValidationMeanError(1,i);
    annotation('textbox',...
    [.65 .02 .28 .03],...
    'String',{['Momentary Average Accuracy = ' num2str(MAA),'%']},...
    'FontSize',5,'FitBoxToText','on');

    file1=[file_vpath,num2str(i),'.png'];
    saveas(gcf,file1);
    Iv=imread(file1);
    
    for jj=1:numStages
        writeVideo(v,Iv)
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
save(fullfile(morp_path,'Embryosstats'));
close all