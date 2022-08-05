%% dataset including 6.6
clear
UseAllMorpData = 'FALSE';
Use9_8_MorpData = 'FALSE';
Use10_8_MorpData = 'TRUE'; % Exp1 - KL
Use12_8_MorpData = 'FALSE'; % Exp2 - KL/GLR
Use12_5_MorpData = 'FALSE'; % Exp3 KL/GLR/Manual
if strcmp(UseAllMorpData,'TRUE') % all morps
    load('C:/Nati/Embryos/4Yoni/data/machine_morp_data.mat')
    morp_list_all = {'Area','Diameter','Perimeter','Eccentricity','Autocorrelation','Contrast','Correlation','ClusterProminence','ClusterShade','Dissimilarity','Energy','Entropy','Homogeneity','MaximumProbability','Variance','Smoothness','SumEverage','SumVariance','SumEntropy','DifferenceVariance','DifferenceEntropy','InfoMeasureOfCorrelation','InverseDifferenceNormalized','InverseDifferenceMoment','Roundness','HWS','VWS','DWS','GWS','LPSF_T_V','HPSF_T_V','BPSF_T_V','HOG_m','m_Gmag_v','m_Gdir_v','v_Gmag_v','v_Gdir_v','TextureSkewness','GradientMean','GradientStd','GradientGlobalmean','GradientUniformity','GradientEntropy','GradientSkewness','GradientCorrelation','Time'};
elseif strcmp(Use9_8_MorpData,'TRUE') % 9/8 selected 1 morps. before 6.6
    load('C:/Nati/Embryos/4Yoni/data/machine_morp_data_9Y_8O.mat')
    morp_list_y = {'Area','Eccentricity','Correlation','Symmetric','TexturalUniformity','Smoothness','IMC','HPspectrumFilter','Time'};
    morp_list_o = {'Area','Diameter','Perimeter','Eccentricity','Contrast','Symmetric','Roundness','Time'};
elseif strcmp(Use10_8_MorpData,'TRUE') % 10/8 selected 2 morps. after 6.6
    load('C:/Nati/Embryos/4Yoni/data/machine_morp_data_10Y_8O.mat')
    morp_list_y = {'Area','AutoCorr','Correlation','Varinace','Smoothness','SumAverage','Roundness','LPspectrumFilter','TextureSkewness','Time'};
    morp_list_o = {'Area','AutoCorr','Varinace','SumAverage','DWS','HPspectrumFilter','TextureSkewness','Time'};
elseif strcmp(Use12_8_MorpData,'TRUE') % 12/8 selected 2 morps. after 6.6 new
    load('C:/Nati/Embryos/4Yoni/data/machine_morp_data_12Y_8O.mat')
    morp_list_y = {'Area','AutoCorr','Correlation','ClusterProminence','ClusterShade','Varinace','Smoothness','SumAverage','Roundness','LPspectrumFilter','TextureSkewness','Time'};
    morp_list_o = {'Area','AutoCorr','Varinace','SumAverage','DWS','HPspectrumFilter','TextureSkewness','Time'};
elseif strcmp(Use12_5_MorpData,'TRUE') % 12/8 selected 2 morps. after 6.6 new
    load('C:/Nati/Embryos/4Yoni/data/machine_morp_data_12Y_5O.mat')
    morp_list_y = {'Area','AutoCorr','Correlation','ClusterProminence','ClusterShade','Varinace','Smoothness','SumAverage','Roundness','LPspectrumFilter','TextureSkewness','Time'};
    morp_list_o = {'Area','ClusterProminence','HPspectrumFilter','TextureSkewness','Time'};
end

%% create reduced and normilizaed vectors per stage
for ind_stage=1:6
    % Young
    k=1;
    for i  = 1:length(ind_blasto_Y)
        [n_prop,n_stage] = size(data_Y_R_N{i});
        if n_stage>=ind_stage;
            vector_Y(k,:) = data_Y_R_N{i}(:,ind_stage);
            k=k+1;
        end
    end
    vector_R_N_Y{ind_stage} = vector_Y;
    
    % Old
    k=1;
    for i  = 1:length(ind_blasto_O)
        [n_prop,n_stage] = size(data_O_R_N{i});
        if n_stage>=ind_stage;
            vector_O(k,:) = data_O_R_N{i}(:,ind_stage);
            k=k+1;
        end
    end
    vector_R_N_O{ind_stage} = vector_O;
end

%% create all reduced vectors per stage
for ind_stage=1:6
    % Young
    k=1;
    for i  = 1:length(ind_blasto_Y)
        [n_prop,n_stage] = size(data_Y_R{i});
        if n_stage>=ind_stage;
            vector_Y(k,:) = data_Y_R{i}(:,ind_stage);
            k=k+1;
        end
    end
    vector_Y_R{ind_stage} = vector_Y;
    
    % Old
    k=1;
    for i  = 1:length(ind_blasto_O)
        [n_prop,n_stage] = size(data_O_R{i});
        if n_stage>=ind_stage;
            vector_O(k,:) = data_O_R{i}(:,ind_stage);
            k=k+1;
        end
    end
    vector_O_R{ind_stage} = vector_O;
end

%% Example 1 - independent for data morp size
clear fig
hfigs = findall(0,'Type','figure', '-not', 'HandleVisibility', 'on');close(hfigs);close all;
fig = 1;
UseYoungData = 'TRUE';
UseOldData = 'FALSE';
for ind_stage=1:6
    if ind_stage == 1
        s_stage = '1cell';
    elseif ind_stage == 2
        s_stage = '2cell';
    elseif ind_stage == 3
        s_stage = '4cell';
    elseif ind_stage == 4
        s_stage = '8cell';
    elseif ind_stage == 5
        s_stage = 'Morula';
    elseif ind_stage == 6
        s_stage = 'EarlyBlasto';
    end
    
    if strcmp(UseYoungData,'TRUE') % Young
        k=1;
        for i  = 1:length(ind_blasto_Y)
            [n_prop,n_stage] = size(data_Y_R_N{i});
            if n_stage>=ind_stage;
                vector_Y(k,:) = data_Y_R_N{i}(:,ind_stage);
                ind_blasto_Y_stage(k) = ind_blasto_Y(i);
                k=k+1;
            end
        end
        
        [coeff,score,~,~,explained,~] = pca(vector_Y);
        mapcaplot(vector_Y);
        figure(fig);hold on
        % axis 1-2
        plot(score(:,1),score(:,2),'ok');
        plot(score(find(ind_blasto_Y_stage==1),1),score(find(ind_blasto_Y_stage==1),2),'.g');
        plot(score(find(ind_blasto_Y_stage==0),1),score(find(ind_blasto_Y_stage==0),2),'.r');
        titleplot = sprintf('Embryos in indication stage = %s', s_stage);
        title({'PCA',titleplot});
        legend({'All embryos','survived','not survived'}, 'Location', 'best');
        fig = fig +1;
        
        % axis 2-3
        figure(fig);hold on
        plot(score(:,2),score(:,3),'ok');
        plot(score(find(ind_blasto_Y_stage==1),2),score(find(ind_blasto_Y_stage==1),3),'.g');
        plot(score(find(ind_blasto_Y_stage==0),2),score(find(ind_blasto_Y_stage==0),3),'.r');
        titleplot = sprintf('Embryos in indication stage = %s', s_stage);
        title({'PCA',titleplot});
        legend({'All embryos','survived','not survived'}, 'Location', 'best');
        fig = fig +1;
        
        Y = tsne(vector_Y,'distance','seuclidean');
        figure(fig);hold on
        plot(Y(:,1),Y(:,2),'ok');
        plot(Y(find(ind_blasto_Y_stage==1),1),Y(find(ind_blasto_Y_stage==1),2),'.g');
        plot(Y(find(ind_blasto_Y_stage==0),1),Y(find(ind_blasto_Y_stage==0),2),'.r');
        hold off
        grid
        legend({'All embryos','survived','not survived'}, 'Location', 'best');
        %titleplot = sprintf('2D tsne - Young Embryos in indication stage = %d', ind_stage);
        titleplot = sprintf('Embryos in indication stage = %s', s_stage);
        title({'t-SNE',titleplot});
        fig = fig +1;
        
    end
    
    if strcmp(UseOldData,'TRUE') % Old
        k=1;
        for i  = 1:length(ind_blasto_O)
            [n_prop,n_stage] = size(data_O_R_N{i});
            if n_stage>=ind_stage;
                vector_O(k,:) = data_O_R_N{i}(:,ind_stage);
                ind_blasto_O_stage(k) = ind_blasto_O(i);
                k=k+1;
            end
        end
        
        [coeff,score,~,~,explained,~] = pca(vector_O);
        mapcaplot(vector_O);
        figure(fig);hold on
        % axis 1-2
        plot(score(:,1),score(:,2),'ok');
        plot(score(find(ind_blasto_O_stage==1),1),score(find(ind_blasto_O_stage==1),2),'.g');
        plot(score(find(ind_blasto_O_stage==0),1),score(find(ind_blasto_O_stage==0),2),'.r');
        titleplot = sprintf('Embryos in indication stage = %s', s_stage);
        title({'PCA',titleplot});
        legend({'All embryos','survived','not survived'}, 'Location', 'best');
        fig = fig +1;
        % axis 2-3
        figure(fig);hold on
        plot(score(:,2),score(:,3),'ok');
        plot(score(find(ind_blasto_O_stage==1),2),score(find(ind_blasto_O_stage==1),3),'.g');
        plot(score(find(ind_blasto_O_stage==0),2),score(find(ind_blasto_O_stage==0),3),'.r');
        titleplot = sprintf('Embryos in indication stage = %s', s_stage);
        title({'PCA',titleplot});
        legend({'All embryos','survived','not survived'}, 'Location', 'best');
        fig = fig +1;
        
        
        O = tsne(vector_O,'distance','seuclidean');
        figure(fig);hold on
        plot(O(:,1),O(:,2),'ok');
        plot(O(find(ind_blasto_O_stage==1),1),O(find(ind_blasto_O_stage==1),2),'.g');
        plot(O(find(ind_blasto_O_stage==0),1),O(find(ind_blasto_O_stage==0),2),'.r');
        hold off
        grid
        legend({'All embryos','survived','not survived'}, 'Location', 'best');
        %titleplot = sprintf('2D tsne - Young Embryos in indication stage = %d', ind_stage);
        titleplot = sprintf('Embryos in indication stage = %s', s_stage);
        title({'t-SNE',titleplot});
        fig = fig +1;
    end
end
hfigs = findall(0,'Type','figure', '-not', 'HandleVisibility', 'on');close(hfigs);


%%
% bellow examples work only for all data morp

%% Example 2 - works only for all data morp (46)
for ind_stage=1:6
    [~, scores, pcvars] = pca(vector_R_N_Y{1,ind_stage}(:,[1,4,46]));
    x = zscore(scores(:,1));
    y = zscore(scores(:,2));
    z = zscore(scores(:,3));
    scatter3(x,y,z,'ok');
    hold on
    scatter3(x(find(ind_blasto_Y==1)),y(find(ind_blasto_Y==1)),z(find(ind_blasto_Y==1)),'.g');
    hold on
    scatter3(x(find(ind_blasto_Y==0)),y(find(ind_blasto_Y==0)),z(find(ind_blasto_Y==0)),'.r');
    hold on
    xlabel(['PC1-(',num2str(round(pcvars(1)/sum(pcvars)*100)),'%)']);
    ylabel(['PC2-(',num2str(round(pcvars(2)/sum(pcvars)*100)),'%)']);
    zlabel(['PC3-(',num2str(round(pcvars(3)/sum(pcvars)*100)),'%)']);
end
title({'An expression of Young morphological featues along developmental stage','Area, Eccentricity, Time'});
legend({'ALL embryos','Survived','Not Survived'},'Location','best');

%% Example 3 - data Reduced Normalized Young - work only for all data morp
Area_idx = 1;
Eccentricity_idx = 4;
Time_idx = 46;
UseYoungData = 'TRUE';
UseOldData = 'FALSE';
if strcmp(UseYoungData,'TRUE') % Young
    mrkslestr={'+','o','*','x','^','v'};
    for ind_stage=1:6
        x_Area = vector_R_N_Y{1,ind_stage}(:,Area_idx);
        y_Eccentricity = vector_R_N_Y{1,ind_stage}(:,Eccentricity_idx);
        z_Time = vector_R_N_Y{1,ind_stage}(:,Time_idx);
        scatter3(x_Area,y_Eccentricity,z_Time,mrkslestr{ind_stage});
        hold on
    end
    legend({'1cell','2cell','4cell','8cell','Morula','Early Blastocyst'},'Location','best');
    title('An expression of Young morphological featues along developmental stage');
    xlabel('Area');
    ylabel('Eccentricity');
    zlabel('Time');
end

if strcmp(UseOldData,'TRUE') % Old
    mrkslestr={'+','o','*','x','^','v'};
    for ind_stage=1:6
        x_Area = vector_R_N_O{1,ind_stage}(:,Area_idx);
        y_Eccentricity = vector_R_N_O{1,ind_stage}(:,Eccentricity_idx);
        z_Time = vector_R_N_O{1,ind_stage}(:,Time_idx);
        scatter3(x_Area,y_Eccentricity,z_Time,mrkslestr{ind_stage});
        hold on
    end
    legend({'1cell','2cell','4cell','8cell','Morula','Early Blastocyst'},'Location','best');
    title('An expression of Old morphological featues along developmental stage');
    xlabel('Area');
    ylabel('Eccentricity');
    zlabel('Time');
end


%% Example 4 - all data morp reduced
Area_idx = 1;
Eccentricity_idx = 4;
Time_idx = 46;
UseYoungData = 'TRUE';
UseOldData = 'FALSE';
if strcmp(UseYoungData,'TRUE') % Young
    mrkslestr={'+','o','*','x','^','v'};
    for ind_stage=1:6
        x_Area = vector_Y_R{1,ind_stage}(:,Area_idx);
        y_Eccentricity = vector_Y_R{1,ind_stage}(:,Eccentricity_idx);
        z_Time = vector_Y_R{1,ind_stage}(:,Time_idx);
        scatter3(x_Area,y_Eccentricity,z_Time,mrkslestr{2});
        hold on
        scatter3(x_Area(find(ind_blasto_Y==1)),y_Eccentricity(find(ind_blasto_Y==1)),z_Time(find(ind_blasto_Y==1)),'.g');
        hold on
        scatter3(x_Area(find(ind_blasto_Y==0)),y_Eccentricity(find(ind_blasto_Y==0)),z_Time(find(ind_blasto_Y==0)),'.r');
        hold on
    end
    legend({'1cell','2cell','4cell','8cell','Morula','Early Blastocyst'},'Location','best');
    title('An expression of Young morphological featues along developmental stage');
    xlabel('Area');
    ylabel('Eccentricity');
    zlabel('Time');
end

if strcmp(UseOldData,'TRUE') % Old
    mrkslestr={'+','o','*','x','^','v'};
    for ind_stage=1:6
        x_Area = vector_O_R{1,ind_stage}(:,Area_idx);
        y_Eccentricity = vector_O_R{1,ind_stage}(:,Eccentricity_idx);
        z_Time = vector_O_R{1,ind_stage}(:,Time_idx);
        scatter3(x_Area,y_Eccentricity,z_Time,mrkslestr{2});
        hold on
        scatter3(x_Area(find(ind_blasto_O==1)),y_Eccentricity(find(ind_blasto_O==1)),z_Time(find(ind_blasto_O==1)),'.g');
        hold on
        scatter3(x_Area(find(ind_blasto_O==0)),y_Eccentricity(find(ind_blasto_O==0)),z_Time(find(ind_blasto_O==0)),'.r');
        hold on
    end
    legend({'1cell','2cell','4cell','8cell','Morula','Early Blastocyst'},'Location','best');
    title('An expression of Old morphological featues along developmental stage');
    xlabel('Area');
    ylabel('Eccentricity');
    zlabel('Time');
end

%% Example 5 - works only on data morp 
for ind_stage=1:6
    [~, scores, pcvars] = pca(vector_R_N_Y{1,ind_stage}(:,[1,4,46]));
    x = zscore(scores(:,1));
    y = zscore(scores(:,2));
    z = zscore(scores(:,3));
    scatter3(x,y,z,'ok');
    hold on
    scatter3(x(find(ind_blasto_Y==1)),y(find(ind_blasto_Y==1)),z(find(ind_blasto_Y==1)),'.g');
    hold on
    scatter3(x(find(ind_blasto_Y==0)),y(find(ind_blasto_Y==0)),z(find(ind_blasto_Y==0)),'.r');
    hold on
    xlabel(['PC1-(',num2str(round(pcvars(1)/sum(pcvars)*100)),'%)']);
    ylabel(['PC2-(',num2str(round(pcvars(2)/sum(pcvars)*100)),'%)']);
    zlabel(['PC3-(',num2str(round(pcvars(3)/sum(pcvars)*100)),'%)']);
end
title({'An expression of Young morphological featues along developmental stage','Area, Eccentricity, Time'});
legend({'ALL embryos','Survived','Not Survived'},'Location','best');


