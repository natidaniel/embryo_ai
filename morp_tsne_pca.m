%% Analyze and Model Embryos data via KS, GLR, LR-LDA, t-SNE and PCA
%% cleaning
hfigs = findall(0,'Type','figure', '-not', 'HandleVisibility', 'on');
close(hfigs);clear;clc;close all;pause(3);
%% initialization
% Exp
Before6_6 = 'FALSE';
After6_6 = 'TRUE';
% Embryo age
UseYoungData = 'TRUE';
UseOldData = 'TRUE';
% Morp selection - Manual
UseM_ReducedMorpData = 'FALSE';
UseM_D_O_Y_ReducedMorpData = 'FALSE';
UseM_D_46_O_Y_ReducedMorpData = 'FALSE';
UseM_D_46_2_O_Y_ReducedMorpData = 'FALSE';
UseM_D_46_3_O_Y_ReducedMorpData = 'FALSE';
UseM_D_46_4_O_Y_ReducedMorpData = 'FALSE'; % best for Old and Young
UseM_D_46_5_O_Y_ReducedMorpData = 'TRUE'; % including 6.6 best for Old and Young
UseM_S_O_Y_ReducedMorpData = 'FALSE';
% Morp selection - Automated (GLR/KS) - run either glr_trees.m or ks_trees.m
UseA_ReducedMorpData = 'FALSE';
Use_GLR_Threshold = 'FALSE';
Use_KS_Threshold = 'FALSE';
UseLinearRegressionModeling = 'TRUE';
% Normalization mode
NormalizedVector = 'TRUE'; % normalize along embryo (vector)
UseNormalizeForData_YO = 'FALSE'; %standardisation/unit-vector/mean normalization

%% Read the data
% 26 features
%main_path = 'C:\Nati\Embryos\4Yoni\Embryo Deep learning\morp';

% 46 features
if strcmp(Before6_6,'TRUE') 
    main_path = 'C:\Nati\Embryos\4Yoni\Embryo Deep learning\new_f\morp\before6_6';
else
    main_path = 'C:\Nati\Embryos\4Yoni\Embryo Deep learning\new_f\morp\SyncToTime';
end

% Get list of all subfolders.
allSubFolders = genpath(main_path);
% Parse into a cell array.
remain = allSubFolders;
listOfFolderNames = {};
while true
    [singleSubFolder, remain] = strtok(remain, ';');
    if isempty(singleSubFolder)
        break;
    end
    listOfFolderNames = [listOfFolderNames singleSubFolder];
end
numberOfFolders = length(listOfFolderNames)

%% Create the data 
fig = 1;
k = 0;
for i = 1:numberOfFolders
    
    files = dir(listOfFolderNames{i});
    
    if ~isempty(find([files.isdir]==0))
        
        k = k+1;
        
        ind = find([files.isdir]==0);
        
        load([listOfFolderNames{i},'\',files(ind).name])
        
        data{k} = Embryosstats;
        
        if ~isempty(regexp(listOfFolderNames{i},'\O\'))
            
            age(k) =1;%'old'
        else
            age(k) = 0;%'young';
        end
        
        clear Embryosstats
    end    
end

data_Y = data(find(age==0));
data_O = data(find(age==1));

%% Manual different morp for old and young (violent) - Reduced Morp Data for calssifier
if strcmp(UseM_ReducedMorpData,'TRUE') 
    if strcmp(UseYoungData,'TRUE') % Young
        for y=1:length(data_Y)
            [my,ny] = size(data_Y{y});
            data_Y_tmp = zeros(7,ny);
            data_Y_tmp(1,:) = data_Y{y}(1,:); % area
            data_Y_tmp(2,:) = data_Y{y}(4,:); % Eccentricity - a measure of how much a conic section deviates from being circular,The eccentricity of a circle is zero.
            data_Y_tmp(3,:) = data_Y{y}(7,:); % Correlation
            data_Y_tmp(4,:) = data_Y{y}(9,:); % Cluster Shade: the lack of symmetry. When cluster shade is high, the embryo is not symmetric.
            data_Y_tmp(5,:) = data_Y{y}(22,:); % InfoMeasureOfCorrelation : Correlation
            data_Y_tmp(6,:) = data_Y{y}(25,:); % Roundness
            data_Y_tmp(7,:) = data_Y{y}(26,:); % developmental time
            data_Y{y}=data_Y_tmp;
        end
    end

    if strcmp(UseOldData,'TRUE') % Old   
        for o=1:length(data_O)
            [mo,no] = size(data_O{o});
            data_O_tmp = zeros(6,no);
            data_O_tmp(1,:) = data_O{o}(1,:); % area
            data_O_tmp(2,:) = data_O{o}(4,:); % Perimeter
            data_O_tmp(3,:) = data_O{o}(7,:); % Correlation
            data_O_tmp(4,:) = data_O{o}(11,:); % Energy
            data_O_tmp(5,:) = data_O{o}(14,:); % Maximum Probability - max(co-occurrence matrix)
            data_O_tmp(6,:) = data_O{o}(26,:); % developmental time
            data_O{o}=data_O_tmp;
        end
    end
end

%% Manual different morp for old and young (ks and glr), Reduced Morp Data for calssifier
if strcmp(UseM_D_O_Y_ReducedMorpData,'TRUE') 
    if strcmp(UseYoungData,'TRUE') % Young
        for y=1:length(data_Y)
            [my,ny] = size(data_Y{y});
            data_Y_tmp = zeros(6,ny);
            data_Y_tmp(1,:) = data_Y{y}(1,:); % Area
            data_Y_tmp(2,:) = data_Y{y}(4,:); % Eccentricity - a measure of how much a conic section deviates from being circular,The eccentricity of a circle is zero.
            data_Y_tmp(3,:) = data_Y{y}(7,:); % Correlation
            data_Y_tmp(4,:) = data_Y{y}(11,:); % Energy - Textural Uniformity. 
            data_Y_tmp(5,:) = data_Y{y}(16,:); % Smoothness 
            data_Y_tmp(6,:) = data_Y{y}(26,:); % Developmental time
            data_Y{y}=data_Y_tmp;
        end
    end

    if strcmp(UseOldData,'TRUE') % Old   
        for o=1:length(data_O)
            [mo,no] = size(data_O{o});
            data_O_tmp = zeros(7,no);
            data_O_tmp(1,:) = data_O{o}(1,:); % Area
            data_O_tmp(2,:) = data_O{o}(4,:); % Eccentricity
            data_O_tmp(3,:) = data_O{o}(6,:); % Contrast
            data_O_tmp(4,:) = data_O{o}(9,:); % Symmetric - When cluster shade is high, the embryo is not symmetric.
            data_O_tmp(5,:) = data_O{o}(16,:); % Smoothness 
            data_O_tmp(6,:) = data_O{o}(25,:); % Roundness
            data_O_tmp(7,:) = data_O{o}(26,:); % Developmental time
            data_O{o}=data_O_tmp;
        end
    end
end

%% Manual different morp for old and young (ks and glr), Reduced Morp Data for calssifier
if strcmp(UseM_S_O_Y_ReducedMorpData,'TRUE') 
    if strcmp(UseYoungData,'TRUE') % Young
        for y=1:length(data_Y)
            [my,ny] = size(data_Y{y});
            data_Y_tmp = zeros(9,ny);
            data_Y_tmp(1,:) = data_Y{y}(1,:); % area
            data_Y_tmp(2,:) = data_Y{y}(4,:); % Eccentricity - a measure of how much a conic section deviates from being circular,The eccentricity of a circle is zero.
            data_Y_tmp(3,:) = data_Y{y}(6,:); % Contrast
            data_Y_tmp(4,:) = data_Y{y}(7,:); % Correlation
            data_Y_tmp(5,:) = data_Y{y}(9,:); % Symmetric - When cluster shade is high, the embryo is not symmetric.
            data_Y_tmp(6,:) = data_Y{y}(11,:); % Energy - Textural Uniformity. 
            data_Y_tmp(7,:) = data_Y{y}(16,:); % Smoothness 
            data_Y_tmp(8,:) = data_Y{y}(25,:); % Roundness
            data_Y_tmp(9,:) = data_Y{y}(26,:); % developmental time
            data_Y{y}=data_Y_tmp;
        end
    end

    if strcmp(UseOldData,'TRUE') % Old   
        for o=1:length(data_O)
            [mo,no] = size(data_O{o});
            data_O_tmp = zeros(9,no);
            data_O_tmp(1,:) = data_O{o}(1,:); % area
            data_O_tmp(2,:) = data_O{o}(4,:); % Eccentricity - a measure of how much a conic section deviates from being circular,The eccentricity of a circle is zero.
            data_O_tmp(3,:) = data_O{o}(6,:); % Contrast
            data_O_tmp(4,:) = data_O{o}(7,:); % Correlation
            data_O_tmp(5,:) = data_O{o}(9,:); % Symmetric - When cluster shade is high, the embryo is not symmetric.
            data_O_tmp(6,:) = data_O{o}(11,:); % Energy - Textural Uniformity. 
            data_O_tmp(7,:) = data_O{o}(16,:); % Smoothness 
            data_O_tmp(8,:) = data_O{o}(25,:); % Roundness
            data_O_tmp(9,:) = data_O{o}(26,:); % developmental time
            data_O{o}=data_O_tmp;
        end
    end
end

%% Manual different morp for old and young (ks and glr), Reduced Morp Data for calssifier
if strcmp(UseM_D_46_O_Y_ReducedMorpData,'TRUE') 
    if strcmp(UseYoungData,'TRUE') % Young
        for y=1:length(data_Y)
            [my,ny] = size(data_Y{y});
            data_Y_tmp = zeros(19,ny);
            data_Y_tmp(1,:) = data_Y{y}(1,:); % Area
            data_Y_tmp(2,:) = data_Y{y}(2,:); % Diam
            data_Y_tmp(3,:) = data_Y{y}(3,:); % Peri
            data_Y_tmp(4,:) = data_Y{y}(4,:); % Eccentricity
            data_Y_tmp(5,:) = data_Y{y}(7,:); % Correlation
            data_Y_tmp(6,:) = data_Y{y}(9,:); % Symmetric (CS)
            data_Y_tmp(7,:) = data_Y{y}(10,:); % Disim
            data_Y_tmp(8,:) = data_Y{y}(11,:); % Energy - Textural Uniformity
            data_Y_tmp(9,:) = data_Y{y}(12,:); % Entropy
            data_Y_tmp(10,:) = data_Y{y}(16,:); % Smoothness
            data_Y_tmp(11,:) = data_Y{y}(21,:); % DE
            data_Y_tmp(12,:) = data_Y{y}(22,:); % IMC
            data_Y_tmp(13,:) = data_Y{y}(24,:); % IDM
            data_Y_tmp(14,:) = data_Y{y}(25,:); % Roundness
            data_Y_tmp(15,:) = data_Y{y}(28,:); % DWS
            data_Y_tmp(16,:) = data_Y{y}(31,:); % HP_spectrum_filter
            data_Y_tmp(17,:) = data_Y{y}(32,:); % BP_spectrum_filter 
            data_Y_tmp(18,:) = data_Y{y}(34,:); % HOG_m 
            data_Y_tmp(19,:) = data_Y{y}(46,:); % Developmental time
            data_Y{y}=data_Y_tmp;
        end
    end

    if strcmp(UseOldData,'TRUE') % Old   
        for o=1:length(data_O)
            [mo,no] = size(data_O{o});
            data_O_tmp = zeros(9,no);
            data_O_tmp(1,:) = data_O{o}(1,:); % Area
            data_O_tmp(2,:) = data_O{o}(2,:); % Diameter
            data_O_tmp(3,:) = data_O{o}(3,:); % Perimeter
            data_O_tmp(4,:) = data_O{o}(4,:); % Eccentricity
            data_O_tmp(5,:) = data_O{o}(6,:); % Contrast
            data_O_tmp(6,:) = data_O{o}(9,:); % Symmetric - When cluster shade is high, the embryo is not symmetric.
            data_O_tmp(7,:) = data_O{o}(25,:); % Roundness
            data_O_tmp(8,:) = data_O{o}(28,:); % DWS
            data_O_tmp(9,:) = data_O{o}(46,:); % Developmental time
            data_O{o}=data_O_tmp;
        end
    end
end

%% Manual different morp for old and young (ks and glr), Reduced Morp Data for calssifier
if strcmp(UseM_D_46_2_O_Y_ReducedMorpData,'TRUE') 
    if strcmp(UseYoungData,'TRUE') % Young
        for y=1:length(data_Y)
            [my,ny] = size(data_Y{y});
            data_Y_tmp = zeros(11,ny);
            data_Y_tmp(1,:) = data_Y{y}(1,:); % Area
            data_Y_tmp(2,:) = data_Y{y}(4,:); % Eccentricity
            data_Y_tmp(3,:) = data_Y{y}(7,:); % Correlation
            data_Y_tmp(4,:) = data_Y{y}(9,:); % Symmetric (CS)
            data_Y_tmp(5,:) = data_Y{y}(10,:); % Disim
            data_Y_tmp(6,:) = data_Y{y}(11,:); % Energy - Textural Uniformity
            data_Y_tmp(7,:) = data_Y{y}(16,:); % Smoothness
            data_Y_tmp(8,:) = data_Y{y}(22,:); % IMC
            data_Y_tmp(9,:) = data_Y{y}(31,:); % HP_spectrum_filter
            data_Y_tmp(10,:) = data_Y{y}(32,:); % BP_spectrum_filter 
            data_Y_tmp(11,:) = data_Y{y}(46,:); % Developmental time
            data_Y{y}=data_Y_tmp;
        end
    end

    if strcmp(UseOldData,'TRUE') % Old   
        for o=1:length(data_O)
            [mo,no] = size(data_O{o});
            data_O_tmp = zeros(8,no);
            data_O_tmp(1,:) = data_O{o}(1,:); % Area
            data_O_tmp(2,:) = data_O{o}(4,:); % Eccentricity
            data_O_tmp(3,:) = data_O{o}(6,:); % Contrast
            data_O_tmp(4,:) = data_O{o}(9,:); % Symmetric - When cluster shade is high, the embryo is not symmetric.
            data_O_tmp(5,:) = data_O{o}(25,:); % Roundness
            data_O_tmp(6,:) = data_O{o}(28,:); % DWS
            data_O_tmp(7,:) = data_O{o}(16,:); % Smoothness
            data_O_tmp(8,:) = data_O{o}(46,:); % Developmental time
            data_O{o}=data_O_tmp;
        end
    end
end

%% Manual different morp for old and young (ks and glr), Reduced Morp Data for calssifier
if strcmp(UseM_D_46_3_O_Y_ReducedMorpData,'TRUE') 
    if strcmp(UseYoungData,'TRUE') % Young
        for y=1:length(data_Y)
            [my,ny] = size(data_Y{y});
            data_Y_tmp = zeros(8,ny);
            data_Y_tmp(1,:) = data_Y{y}(1,:); % Area
            data_Y_tmp(2,:) = data_Y{y}(4,:); % Eccentricity
            data_Y_tmp(3,:) = data_Y{y}(7,:); % Correlation
            data_Y_tmp(4,:) = data_Y{y}(9,:); % Symmetric (CS)
            data_Y_tmp(5,:) = data_Y{y}(22,:); % IMC
            data_Y_tmp(6,:) = data_Y{y}(31,:); % HP_spectrum_filter
            data_Y_tmp(7,:) = data_Y{y}(32,:); % BP_spectrum_filter 
            data_Y_tmp(8,:) = data_Y{y}(46,:); % Developmental time
            data_Y{y}=data_Y_tmp;
        end
    end

    if strcmp(UseOldData,'TRUE') % Old   
        for o=1:length(data_O)
            [mo,no] = size(data_O{o});
            data_O_tmp = zeros(7,no);
            data_O_tmp(1,:) = data_O{o}(1,:); % Area
            data_O_tmp(2,:) = data_O{o}(4,:); % Eccentricity
            data_O_tmp(3,:) = data_O{o}(6,:); % Contrast
            data_O_tmp(4,:) = data_O{o}(9,:); % Symmetric - When cluster shade is high, the embryo is not symmetric.
            data_O_tmp(5,:) = data_O{o}(25,:); % Roundness
            data_O_tmp(6,:) = data_O{o}(16,:); % Smoothness
            data_O_tmp(7,:) = data_O{o}(46,:); % Developmental time
            data_O{o}=data_O_tmp;
        end
    end
end

%% Manual different morp for old and young (ks and glr), Reduced Morp Data for calssifier
if strcmp(UseM_D_46_4_O_Y_ReducedMorpData,'TRUE') 
    if strcmp(UseYoungData,'TRUE') % Young
        for y=1:length(data_Y)
            [my,ny] = size(data_Y{y});
            data_Y_tmp = zeros(9,ny);
            data_Y_tmp(1,:) = data_Y{y}(1,:); % Area
            data_Y_tmp(2,:) = data_Y{y}(4,:); % Eccentricity
            data_Y_tmp(3,:) = data_Y{y}(7,:); % Correlation
            data_Y_tmp(4,:) = data_Y{y}(9,:); % Symmetric (CS)
            data_Y_tmp(5,:) = data_Y{y}(11,:); % Energy - Textural Uniformity
            data_Y_tmp(6,:) = data_Y{y}(16,:); % Smoothness
            data_Y_tmp(7,:) = data_Y{y}(22,:); % IMC
            data_Y_tmp(8,:) = data_Y{y}(31,:); % HP_spectrum_filter (same results with BP) 
            data_Y_tmp(9,:) = data_Y{y}(46,:); % Developmental time
            data_Y{y}=data_Y_tmp;
        end
    end
    
    if strcmp(UseOldData,'TRUE') % Old   
        for o=1:length(data_O)
            [mo,no] = size(data_O{o});
            data_O_tmp = zeros(8,no);
            data_O_tmp(1,:) = data_O{o}(1,:); % Area
            data_O_tmp(2,:) = data_O{o}(2,:); % Diameter
            data_O_tmp(3,:) = data_O{o}(3,:); % Perimeter
            data_O_tmp(4,:) = data_O{o}(4,:); % Eccentricity
            data_O_tmp(5,:) = data_O{o}(6,:); % Contrast
            data_O_tmp(6,:) = data_O{o}(9,:); % Symmetric - When cluster shade is high, the embryo is not symmetric.
            data_O_tmp(7,:) = data_O{o}(25,:); % Roundness
            data_O_tmp(8,:) = data_O{o}(46,:); % Developmental time
            data_O{o}=data_O_tmp;
        end
    end
end

%% Manual different morp for old and young (ks and glr), Reduced Morp Data for calssifier
% including 6.6
if strcmp(UseM_D_46_5_O_Y_ReducedMorpData,'TRUE') 
    if strcmp(UseYoungData,'TRUE') % Young
        for y=1:length(data_Y)
            [my,ny] = size(data_Y{y});
            data_Y_tmp = zeros(10,ny);
            data_Y_tmp(1,:) = data_Y{y}(1,:); % Area
            data_Y_tmp(2,:) = data_Y{y}(5,:); % Auto Corr
            data_Y_tmp(3,:) = data_Y{y}(7,:); % Correlation
            data_Y_tmp(4,:) = data_Y{y}(15,:); % Varinace
            data_Y_tmp(5,:) = data_Y{y}(16,:); % Smoothness
            data_Y_tmp(6,:) = data_Y{y}(17,:); % Sum Average
            data_Y_tmp(7,:) = data_Y{y}(25,:); % Roundness
            data_Y_tmp(8,:) = data_Y{y}(30,:); % LP_spectrum_filter
            data_Y_tmp(9,:) = data_Y{y}(38,:); % Texture Skewness
            data_Y_tmp(10,:) = data_Y{y}(46,:); % Developmental time
            data_Y{y}=data_Y_tmp;
        end
    end
    
    if strcmp(UseOldData,'TRUE') % Old   
        for o=1:length(data_O)
            [mo,no] = size(data_O{o});
            data_O_tmp = zeros(8,no);
            data_O_tmp(1,:) = data_O{o}(1,:); % Area
            data_O_tmp(2,:) = data_O{o}(5,:); % Auto Corr
            data_O_tmp(3,:) = data_O{o}(15,:); % Variance
            data_O_tmp(4,:) = data_O{o}(17,:); % Sum Avergae
            data_O_tmp(5,:) = data_O{o}(27,:); % DWS
            data_O_tmp(6,:) = data_O{o}(31,:); % HP_Spectrum Filter
            data_O_tmp(7,:) = data_O{o}(38,:); % Texture skewness
            data_O_tmp(8,:) = data_O{o}(46,:); % Developmental time
            data_O{o}=data_O_tmp;
        end
    end
end

%% Reduce morp data, add time, and create survived vectors
[data_O,data_Y,ind_blasto_Y,ind_blasto_O] = reduce_data_dim_time(data_O,data_Y); % {embryo}[propertie X num of stages]

%% Normalize along embryo
if strcmp(UseNormalizeForData_YO,'TRUE')
    [data_O,data_Y] = normalization_method(data_O,data_Y,'s'); % normalize along embryo
end  

%% Linear regression model - for 26 features
if ~(strcmp(UseM_ReducedMorpData,'TRUE') || strcmp(UseM_D_46_5_O_Y_ReducedMorpData, 'TRUE') || strcmp(UseM_D_46_4_O_Y_ReducedMorpData, 'TRUE') || strcmp(UseM_D_46_3_O_Y_ReducedMorpData, 'TRUE') || strcmp(UseM_D_46_2_O_Y_ReducedMorpData, 'TRUE') || strcmp(UseM_D_46_O_Y_ReducedMorpData,'TRUE') || strcmp(UseM_D_O_Y_ReducedMorpData,'TRUE') || strcmp(UseM_S_O_Y_ReducedMorpData,'TRUE'))
    if strcmp(UseLinearRegressionModeling,'TRUE')
        tfig = 1000; % only for tree figures
        treefiguresdir = 'C:\Nati\Embryos\4Yoni\Embryo Deep learning\plot_nati\trees\';
        morp_list = {'area','diam','peri','ecce','autoc','contr','corr',...
            'cprom','cshad','dissi','energ','entro','homom',...
            'maxpr','var','smoot','savgh','svarh','senth',...
            'dvarh','denth','infh','indnc','idmnc','round','time'};

        for ind_stage = 1:6
            color_vec = [0 0.5 0.5;
            0.5 0 0.5;
            0.5 0.25 0;
            0 0.5 0;
            0.5 0 0;
            0 0 0.5];

            k=1;
            for i  = 1:length(ind_blasto_Y)
                [n_prop,n_stage] = size(data_Y{i});
                if n_stage>=ind_stage
                    vector_Y(k,:) = data_Y{i}(:,ind_stage);
                    ind_blasto_Y_stage(k) = ind_blasto_Y(i);
                    k=k+1;
                end    
            end

            k=1;
            for i  = 1:length(ind_blasto_O)
                [n_prop,n_stage] = size(data_O{i});
                if n_stage>=ind_stage
                    vector_O(k,:) = data_O{i}(:,ind_stage);
                    ind_blasto_O_stage(k) = ind_blasto_O(i);
                    k=k+1;
                end
            end

            % normalize along embryo
            [n,m] = size(vector_Y);
            E = repmat(mean(vector_Y),[n 1]);
            s = repmat(std(vector_Y),[n 1]);
            vector_Y = (vector_Y - E)./s;

            [n,m] = size(vector_O);
            E = repmat(mean(vector_O),[n 1]);
            s = repmat(std(vector_O),[n 1]);
            vector_O = (vector_O - E)./s;

            % perform KS test
            for cnt_morp = 1:m  %m = should be 26
                % Young
                v1_Y = vector_Y(find(ind_blasto_Y_stage==1),cnt_morp);
                v0_Y = vector_Y(find(ind_blasto_Y_stage==0),cnt_morp);
                [h,p] = kstest2(v1_Y,v0_Y);
                p_val_Y(ind_stage,cnt_morp) = p;

                % Old
                v1_O = vector_O(find(ind_blasto_O_stage==1),cnt_morp);
                v0_O = vector_O(find(ind_blasto_O_stage==0),cnt_morp);
                [h,p] = kstest2(v1_O,v0_O);
                p_val_O(ind_stage,cnt_morp) = p;
            end

            save p_values_YO p_val_Y p_val_O

            % find k-smallest elements of p_values
            kp = 6;
            [B, I] = mink(p_val_Y(ind_stage,:),kp);
            p_val_Y_r(ind_stage,:) = B;
            p_idx_Y_r(ind_stage,:) = I;
            [B, I] = mink(p_val_O(ind_stage,:),kp);
            p_val_O_r(ind_stage,:) = B;
            p_idx_O_r(ind_stage,:) = I;


            figure(fig);subplot(2,3,ind_stage);hold on;
            titleplot = sprintf('Young, ind stage = %d', ind_stage);
            title(titleplot);
            violinplot(vector_Y(find(ind_blasto_Y_stage==1),:),[],'ShowData',false,'ViolinColor',color_vec(1,:),'MedianColor',color_vec(1,:));
            violinplot(vector_Y(find(ind_blasto_Y_stage==0),:),[],'ShowData',false,'ViolinColor',color_vec(2,:),'MedianColor',color_vec(2,:));
            ax = gca;
            ax.XTick = 1:26; 
            ax.XTickLabels = morp_list;
            ax.XTickLabelRotation = 45;

            figure(fig+1);subplot(2,3,ind_stage);hold on;
            titleplot = sprintf('Old, ind stage = %d', ind_stage);
            title(titleplot);
            violinplot(vector_O(find(ind_blasto_O_stage==1),:),[],'ShowData',false,'ViolinColor',color_vec(1,:),'MedianColor',color_vec(1,:));
            violinplot(vector_O(find(ind_blasto_O_stage==0),:),[],'ShowData',false,'ViolinColor',color_vec(2,:),'MedianColor',color_vec(2,:));
            ax = gca;
            ax.XTick = 1:26; 
            ax.XTickLabels = morp_list;
            ax.XTickLabelRotation = 45;

            figure(fig+2);subplot(2,3,ind_stage);hold on;
            titleplot = sprintf('Young, ind stage = %d', ind_stage);
            title(titleplot);
            bar(p_val_Y(ind_stage,:));
            ax = gca;
            ax.XTick = 1:26; 
            ax.XTickLabels = morp_list;
            ax.XTickLabelRotation = 45;

            figure(fig+3);subplot(2,3,ind_stage);hold on;
            titleplot = sprintf('Old, ind stage = %d', ind_stage);
            title(titleplot);
            bar(p_val_O(ind_stage,:));
            ax = gca;
            ax.XTick = 1:26; 
            ax.XTickLabels = morp_list;
            ax.XTickLabelRotation = 45;

            % linerar regression
            VT = cell(1, n_prop);VT(:) = {'double'};
            T_Y = table('Size',[length(ind_blasto_Y) n_prop],'VariableTypes',VT);
            T_O = table('Size',[length(ind_blasto_O) n_prop],'VariableTypes',VT);
            T_Y.Properties.VariableNames = morp_list;
            T_O.Properties.VariableNames = morp_list;

            for i=1:n_prop
                T_Y{:,i} = vector_Y(:,i);
                T_O{:,i} = vector_O(:,i);
            end

            % Young
            mdl_Y{ind_stage} = fitglm(vector_Y,ind_blasto_Y_stage,'linear');% Create generalized linear regression model
            lda_Y{ind_stage} = fitcdiscr(vector_Y,ind_blasto_Y_stage);% Fit discriminant analysis classifier
            t_Y{ind_stage} = fitctree(T_Y,ind_blasto_Y_stage);

            for i=2:length(mdl_Y{ind_stage}.Coefficients.pValue)
                if isnan(mdl_Y{ind_stage}.Coefficients.pValue(i))
                    p_glr_Y(i-1,ind_stage) = 0;
                else
                    p_glr_Y(i-1,ind_stage) = mdl_Y{ind_stage}.Coefficients.pValue(i);
                end
            end
            p_glr_Y = p_glr_Y';

            before = findall(groot,'Type','figure'); % Find all figures
            view(t_Y{ind_stage},'Mode','graph');
            after = findall(groot,'Type','figure');
            h = setdiff(after,before); % Get the figure handle of the tree viewer
            saveas(h,'t_tmp','tif')
            im = imread('t_tmp.tif');
            figure(tfig);
            h1 = imshow(im);
            [HeightIm,~,~] = size(im);
            hT1 = title(sprintf('Morphological Grpah view of Young Embryo in ind stage = %d', ind_stage));
            T1Pos = round(get(hT1,'Position')); 
            hT1_2 = text(T1Pos(1),T1Pos(2) + HeightIm+50,'Classes:  0 - Embryo did not survive, 1 - Embryo survived','HorizontalAlignment','center'); %// Place the text
            saveas(h1,strcat(treefiguresdir, sprintf('Young morp Tree in ind stage = %d', ind_stage)), 'tif');
            tfig = tfig + 1;

            % Old
            mdl_O{ind_stage} = fitglm(vector_O,ind_blasto_O_stage,'linear');% Create generalized linear regression model
            lda_O{ind_stage} = fitcdiscr(vector_O,ind_blasto_O_stage);% Fit discriminant analysis classifier
            t_O{ind_stage} = fitctree(T_O,ind_blasto_O_stage);

            for i=2:length(mdl_O{ind_stage}.Coefficients.pValue)
                if isnan(mdl_O{ind_stage}.Coefficients.pValue(i))
                    p_glr_O(i-1,ind_stage) = 0;
                else
                    p_glr_O(i-1,ind_stage) = mdl_O{ind_stage}.Coefficients.pValue(i);
                end
            end
            p_glr_O = p_glr_O';

            before = findall(groot,'Type','figure'); % Find all figures
            view(t_O{ind_stage},'Mode','graph');
            after = findall(groot,'Type','figure');
            h = setdiff(after,before); % Get the figure handle of the tree viewer
            saveas(h,'t_tmp','tif')
            im = imread('t_tmp.tif');
            figure(tfig);
            h1 = imshow(im);
            [HeightIm,~,~] = size(im);
            hT1 = title(sprintf('Morphological Grpah view of Old Embryo in ind stage = %d', ind_stage));
            T1Pos = round(get(hT1,'Position')); 
            hT1_2 = text(T1Pos(1),T1Pos(2) + HeightIm+50,'Classes:  0 - Embryo did not survive, 1 - Embryo survived','HorizontalAlignment','center'); %// Place the text
            saveas(h1,strcat(treefiguresdir, sprintf('Old morp Tree in ind stage = %d', ind_stage)), 'tif');
            tfig = tfig + 1;

            figure(fig+4);subplot(2,3,ind_stage);hold on;
            titleplot = sprintf('Young, ind stage = %d', ind_stage);
            title(titleplot);
            w1 = 0.5;
            ax = gca;
            ax.XTick = 1:26; 
            ax.XTickLabels = morp_list;
            ax.XTickLabelRotation = 45;
            bar(ax.XTick,p_val_Y(ind_stage,:),w1,'FaceColor',[0.2 0.2 0.5]);
            hold on
            w2 = .25;
            bar(ax.XTick,p_glr_Y(ind_stage,:),w2,'FaceColor',[0 0.7 0.7]);
            grid on
            ylabel('Coefficients')
            legend({'Two-sample Kolmogorov-Smirnov test','generalized linear regression model test'},'Location','northwest')
            hold off 

            figure(fig+5);subplot(2,3,ind_stage);hold on;
            titleplot = sprintf('Old, ind stage = %d', ind_stage);
            title(titleplot);
            w1 = 0.5;
            ax = gca;
            ax.XTick = 1:26; 
            ax.XTickLabels = morp_list;
            ax.XTickLabelRotation = 45;
            bar(ax.XTick,p_val_O(ind_stage,:),w1,'FaceColor',[0.2 0.2 0.5]);
            hold on
            w2 = .25;
            bar(ax.XTick,p_glr_O(ind_stage,:),w2,'FaceColor',[0 0.7 0.7]);
            grid on
            ylabel('Coefficients')
            legend({'Two-sample Kolmogorov-Smirnov test','generalized linear regression model test'},'Location','northwest')
            hold off 

            % plot cdf
            % Young
            pd_gamma_p12 = makedist('Gamma','a',1,'b',2);
            ax = gca;
            ax.XTick = 1:26;
            cdf_gamma_y_ks = cdf(pd_gamma_p12,p_val_Y(ind_stage,:));
            cdf_gamma_y_glr = cdf(pd_gamma_p12,p_glr_Y(ind_stage,:));
            figure(fig+6);
            subplot(2,3,ind_stage);hold on;
            titleplot = sprintf('Young, ind stage = %d, Gamma function', ind_stage);
            title(titleplot);
            J = plot(ax.XTick,cdf_gamma_y_ks,'color',[0.2 0.2 0.5]);
            hold on;
            L = plot(ax.XTick,cdf_gamma_y_glr,'m-.');
            set(J,'LineWidth',2);
            legend([J L],'KS','GLR','Location','southoutside');
            xlim([1 26])
            ax.XTickLabels = morp_list;
            ax.XTickLabelRotation = 45;
            hold off;

            % Old
            pd_gamma_p12 = makedist('Gamma','a',1,'b',2);
            ax = gca;
            ax.XTick = 1:26;
            cdf_gamma_o_ks = cdf(pd_gamma_p12,p_val_O(ind_stage,:));
            cdf_gamma_o_glr = cdf(pd_gamma_p12,p_glr_O(ind_stage,:));
            figure(fig+7);
            subplot(2,3,ind_stage);hold on;
            titleplot = sprintf('Old, ind stage = %d, Gamma function', ind_stage);
            title(titleplot);
            J = plot(ax.XTick,cdf_gamma_o_ks,'color',[0.2 0.2 0.5]);
            hold on;
            L = plot(ax.XTick,cdf_gamma_o_glr,'m-.');
            set(J,'LineWidth',2);
            legend([J L],'KS','GLR','Location','southoutside');
            xlim([1 26])
            ax.XTickLabels = morp_list;
            ax.XTickLabelRotation = 45;
            hold off;

            % Create glr threshold
            kp = 6;
            [B, I] = mink(p_glr_Y(ind_stage,:),kp);
            p_glr_Y_r(ind_stage,:) = B;
            p_glr_idx_Y_r(ind_stage,:) = I;
            [B, I] = mink(p_val_O(ind_stage,:),kp);
            p_glr_O_r(ind_stage,:) = B;
            p_glr_idx_O_r(ind_stage,:) = I;

        end

        fig = fig + 8;
        save mdel_Y lda_Y t_Y mdl_Y
        save mdel_O lda_O t_O mdl_O
    end
end
%% Reduced Morp Data for calssifier per each ind_stage
if strcmp(UseA_ReducedMorpData,'TRUE') 
    if strcmp(UseYoungData,'TRUE') % Young
        if strcmp(Use_GLR_Threshold,'TRUE')
            tv = p_glr_idx_Y_r;
        end
        if strcmp(Use_KS_Threshold,'TRUE')
            tv = p_idx_Y_r;
        end
        for y=1:length(data_Y)
            [my,ny] = size(data_Y{y});
            if ny < 7
                data_Y_tmp = zeros(kp,ny);
                for ns=1:ny
                    for m=1:kp
                        data_Y_tmp(m,ns) = data_Y{y}(tv(ns,m),ns); 
                    end 
                end
            else
                data_Y_tmp = zeros(kp,ny-1);
                for ns=1:(ny-1)
                    for m=1:kp
                        data_Y_tmp(m,ns) = data_Y{y}(tv(ns,m),ns); 
                    end 
                end
            end 
            data_Y_RS{y}=data_Y_tmp;
        end
    end

    if strcmp(UseOldData,'TRUE') % Old   
        if strcmp(Use_GLR_Threshold,'TRUE')
            tv = p_glr_idx_O_r;
        end
        if strcmp(Use_KS_Threshold,'TRUE')
            tv = p_idx_O_r;
        end
        for o=1:length(data_O)
            [mo,no] = size(data_O{o});
            if no < 7      
                data_O_tmp = zeros(kp,no);
                for ns=1:no
                    for m=1:kp
                        data_O_tmp(m,ns) = data_O{o}(tv(ns,m),ns); 
                    end 
                end
            else
               data_O_tmp = zeros(kp,no-1);
               for ns=1:(no-1)
                    for m=1:kp
                        data_O_tmp(m,ns) = data_O{o}(tv(ns,m),ns); 
                    end 
                end
            end
            data_O_RS{o}=data_O_tmp;
        end
    end
end

%% 2D t-SNE and PCA
clear fig
hfigs = findall(0,'Type','figure', '-not', 'HandleVisibility', 'on');close(hfigs);close all;
fig = 100;
PlotPCA = 'TRUE';
PlotTSNE = 'FALSE';
UseYoungData = 'TRUE';
UseOldData = 'FALSE';
for ind_stage=5:6 
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
clear ind_blasto_Y_stage ind_blasto_O_stage vector_Y
clear ind_blasto_O_stage ind_blasto_O_stage vector_O
    % 2D t-SNE
    if strcmp(UseYoungData,'TRUE') % Young
        k=1;
        for i  = 1:length(ind_blasto_Y)
            [n_prop,n_stage] = size(data_Y{i});
            if n_stage>=ind_stage;
                vector_Y(k,:) = data_Y{i}(:,ind_stage);
                ind_blasto_Y_stage(k) = ind_blasto_Y(i);
                k=k+1;
            end    
        end

        if strcmp(NormalizedVector,'TRUE') % normalize along embryo
            [n,m] = size(vector_Y);
            E = repmat(mean(vector_Y),[n 1]);
            s = repmat(std(vector_Y),[n 1]);
            vector_Y = (vector_Y - E)./s;
        end

        Y = tsne(vector_Y,'distance','seuclidean');
        if strcmp(PlotTSNE,'TRUE') 
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
    end

    if strcmp(UseOldData,'TRUE') % Old    
        k=1;
        for i  = 1:length(ind_blasto_O)
            [n_prop,n_stage] = size(data_O{i});
            if n_stage>=ind_stage;
                vector_O(k,:) = data_O{i}(:,ind_stage);
                ind_blasto_O_stage(k) = ind_blasto_O(i);
                k=k+1;
            end
        end

        if strcmp(NormalizedVector,'TRUE') % normalize along embryo
            [n,m] = size(vector_O);
            E = repmat(mean(vector_O),[n 1]);
            s = repmat(std(vector_O),[n 1]);
            vector_O = (vector_O - E)./s;
        end

        O = tsne(vector_O,'distance','seuclidean');
        if strcmp(PlotTSNE,'TRUE')
            figure(fig);hold on
            plot(O(:,1),O(:,2),'ok');
            plot(O(find(ind_blasto_O_stage==1),1),O(find(ind_blasto_O_stage==1),2),'.g');
            plot(O(find(ind_blasto_O_stage==0),1),O(find(ind_blasto_O_stage==0),2),'.r');
            hold off
            grid
            legend({'All embryos','survived','not survived'}, 'Location', 'best');
            %titleplot = sprintf('2D tsne - Old Embryos in indication stage = %d', ind_stage);
            titleplot = sprintf('Embryos in indication stage = %s', s_stage);
            title({'t-SNE',titleplot});
            fig = fig +1;
        end
    end

    % PCA
    if strcmp(UseYoungData,'TRUE') % Young
        [coeff,score,~,~,explained,~] = pca(vector_Y);
        if strcmp(PlotPCA,'TRUE')
            mapcaplot(vector_Y);
            figure(fig);hold on
            plot(score(:,1),score(:,2),'ok');
            plot(score(find(ind_blasto_Y_stage==1),1),score(find(ind_blasto_Y_stage==1),2),'.g');
            plot(score(find(ind_blasto_Y_stage==0),1),score(find(ind_blasto_Y_stage==0),2),'.r');
            % axis 1-2
            %titleplot = sprintf('PCA - Young Embryos in indication stage = %d', ind_stage);
            titleplot = sprintf('Embryos in indication stage = %s', s_stage);
            title({'PCA',titleplot});
            legend({'All embryos','survived','not survived'}, 'Location', 'best');
            fig = fig +1;
            
            figure(fig);hold on
            plot(score(:,2),score(:,3),'ok');
            plot(score(find(ind_blasto_Y_stage==1),2),score(find(ind_blasto_Y_stage==1),3),'.g');
            plot(score(find(ind_blasto_Y_stage==0),2),score(find(ind_blasto_Y_stage==0),3),'.r');
            % axis 2-3 
            %titleplot = sprintf('PCA - Young Embryos in indication stage = %d', ind_stage);
            titleplot = sprintf('Embryos in indication stage = %s', s_stage);
            title({'PCA',titleplot});
            legend({'All embryos','survived','not survived'}, 'Location', 'best');
            fig = fig +1;
            
            figure(fig);hold on
            plot(score(:,1),score(:,3),'ok');
            plot(score(find(ind_blasto_Y_stage==1),1),score(find(ind_blasto_Y_stage==1),3),'.g');
            plot(score(find(ind_blasto_Y_stage==0),1),score(find(ind_blasto_Y_stage==0),3),'.r');
            % axis 1-3 
            %titleplot = sprintf('PCA - Young Embryos in indication stage = %d', ind_stage);
            titleplot = sprintf('Embryos in indication stage = %s', s_stage);
            title({'PCA',titleplot});
            legend({'All embryos','survived','not survived'}, 'Location', 'best');
            fig = fig +1;
        end
    end

    if strcmp(UseOldData,'TRUE') % Old
        [coeff,score,~,~,explained,~] = pca(vector_O);
        if strcmp(PlotPCA,'TRUE')
            mapcaplot(vector_O);
            figure(fig);hold on
            plot(score(:,1),score(:,2),'ok');
            plot(score(find(ind_blasto_O_stage==1),1),score(find(ind_blasto_O_stage==1),2),'.g');
            plot(score(find(ind_blasto_O_stage==0),1),score(find(ind_blasto_O_stage==0),2),'.r');
            % axis 1-2
            %titleplot = sprintf('PCA - Old Embryos in indication stage = %d', ind_stage);
            titleplot = sprintf('Embryos in indication stage = %s', s_stage);
            title({'PCA',titleplot});
            legend({'All embryos','survived','not survived'}, 'Location', 'best');
            fig = fig +1;

            figure(fig);hold on
            plot(score(:,2),score(:,3),'ok');
            plot(score(find(ind_blasto_O_stage==1),2),score(find(ind_blasto_O_stage==1),3),'.g');
            plot(score(find(ind_blasto_O_stage==0),2),score(find(ind_blasto_O_stage==0),3),'.r');
            % axis 2-3 
            %titleplot = sprintf('PCA - Old Embryos in indication stage = %d', ind_stage);
            titleplot = sprintf('Embryos in indication stage = %s', s_stage);
            title({'PCA',titleplot});
            legend({'All embryos','survived','not survived'}, 'Location', 'best');
            fig = fig +1;
            
            figure(fig);hold on
            plot(score(:,1),score(:,3),'ok');
            plot(score(find(ind_blasto_O_stage==1),1),score(find(ind_blasto_O_stage==1),3),'.g');
            plot(score(find(ind_blasto_O_stage==0),1),score(find(ind_blasto_O_stage==0),3),'.r');
            % axis 1-3 
            %titleplot = sprintf('PCA - Old Embryos in indication stage = %d', ind_stage);
            titleplot = sprintf('Embryos in indication stage = %s', s_stage);
            title({'PCA',titleplot});
            legend({'All embryos','survived','not survived'}, 'Location', 'best');
            fig = fig +1;
        end
    end
end
hfigs = findall(0,'Type','figure', '-not', 'HandleVisibility', 'on');close(hfigs);