for morp_id=1:1 %possible to use 1-41, 44,46
    % morp_id map
    switch morp_id
        case 1
            morp_name = 'Area';
        case 2
            morp_name = 'Diameter';
        case 3
            morp_name = 'Perimeter';
        case 4
            morp_name = 'Eccentricity';
        case 5
            morp_name = 'Autocorrelation';
        case 6
            morp_name = 'Contrast';
        case 7
            morp_name = 'Correlation';
        case 8
            morp_name = 'ClusterProminence';
        case 9
            morp_name = 'ClusterShade';
        case 10
            morp_name = 'Dissimilarity';
        case 11
            morp_name = 'Energy';
        case 12
            morp_name = 'Entropy';
        case 13
            morp_name = 'Homogeneity';
        case 14
            morp_name = 'MaximumProbability';
        case 15
            morp_name = 'Variance';
        case 16
            morp_name = 'Smoothness';
        case 17
            morp_name = 'SumEverage';
        case 18
            morp_name = 'SumVariance';
        case 19
            morp_name = 'SumEntropy';
        case 20
            morp_name = 'DifferenceVariance';
        case 21
            morp_name = 'DifferenceEntropy';
        case 22
            morp_name = 'InfoMeasureOfCorrelation';
        case 23
            morp_name = 'InverseDifferenceNormalized';
        case 24
            morp_name = 'InverseDifferenceMoment';
        case 25
            morp_name = 'Roundness';
        case 26
            morp_name = 'HWS';
        case 27
            morp_name = 'VWS';
        case 28
            morp_name = 'DWS';
        case 29
            morp_name = 'GWS';
        case 30
            morp_name = 'LPSF_T_V';
        case 31
            morp_name = 'HPSF_T_V';
        case 32
            morp_name = 'BPSF_T_V';
        case 33
            morp_name = 'HOG_m';
        case 34
            morp_name = 'm_Gmag_v';
        case 35
            morp_name = 'm_Gdir_v';
        case 36
            morp_name = 'v_Gmag_v';
        case 37
            morp_name = 'v_Gdir_v';
        case 38
            morp_name = 'TextureSkewness';
        case 39
            morp_name = 'GradientMean';
        case 40
            morp_name = 'GradientStd';
        case 41
            morp_name = 'GradientGlobalmean';
        case 42
            morp_name = 'GradientUniformity'; %irrelevant data
        case 43
            morp_name = 'GradientEntropy'; %irrelevant data
        case 44
            morp_name = 'GradientSkewness';
        case 45
            morp_name = 'GradientCorrelatsion'; %irrelevant data
        case 46
            morp_name = 'Time';
    end
    % Prepare morp matrices for old and young
    run('C:\Nati\Embryos\4Yoni\Embryo Deep learning\ReadEmbryoData.m')
    [data_O_R,data_Y_R] = reduce_data_dim(data_O,data_Y);
    % morp data
    % Old
    data_O_M = zeros(length(data_O_R),7);
    for ne = 1: length(data_O_R)
        [~,nc] = size(data_O_R{1,ne}(morp_id,:));
        data_O_M(ne,1:nc) = data_O_R{1,ne}(morp_id,:);
    end
    data_O_M(data_O_M==0) = NaN;

    % Young
    data_Y_M = zeros(length(data_Y_R),7);
    for ne = 1: length(data_Y_R)
        [~,nc] = size(data_Y_R{1,ne}(morp_id,:));
        data_Y_M(ne,1:nc) = data_Y_R{1,ne}(morp_id,:);
    end
    data_Y_M(data_Y_M==0) = NaN;

    % remove the zygote values
    data_O_M = data_O_M (:,2:end);
    data_Y_M = data_Y_M (:,2:end);
    % Machine data
    fig = 1;
    x_common_2_cell = [0:5];
    name_2_cell = {'2-cell', '4-cell', '8-cell','Morula','Early Blastocyst','Blastocyst'};
    x_common_4_cell = [0:4];
    name_4_cell = {'4','8','M','EB','B'};
    ind_main = [2:8];

    % Plot the data usrvival curves
    color_vec = [0 0.5 0.5;
        0.5 0 0.5;
        0.5 0.25 0;
        0 0.5 0;
        0.5 0 0;
        0 0 0.5];

    % 2 cell
    for i = 1:2 %old and young
        if i==1
            morp_data = data_Y_M;
        else
            morp_data = data_O_M;
        end
        [survival_time,cen,xx,f,flow,fup,morp_data_mat] = time2survival(morp_data,x_common_2_cell);
        figure(fig);hold on;
        stairs(xx,f,'color',color_vec(i,:),'linewidth',2);
    end
    set(gca,'xtick',x_common_2_cell,'xticklabel',name_2_cell)
    ylim([0 1.05]);
    Set_fig_YS(gca,14,14,14)
    set(gca,'XTickLabelRotation',-30)
    fig = fig + 1;

    % 4 cell
    for i = 1:2
        if i==1
            morp_data = data_Y_M;
        else
            morp_data = data_O_M;
        end
        [survival_time,cen,xx,f,flow,fup,morp_data_mat] = time2survival(morp_data(:,2:end),x_common_4_cell);
        figure(fig);hold on
        stairs(xx,f,'color',color_vec(i,:),'linewidth',2);
    end
    set(gca,'xtick',x_common_4_cell,'xticklabel',name_4_cell)
    ylim([0.4 1.05]);
    Set_fig_YS(gca,18,18,18)
    fig = fig + 1;
    % Compare young and old HR for 21%
    morpA =  data_Y_M; % Young
    morpB =  data_O_M; % old
    [HR(1),p,NA,NB] = HRfromTime(morpA,morpB,x_common_2_cell)
    [HR(2),p,NA,NB] = HRfromTime(morpA(:,2:end),morpB(:,2:end),x_common_2_cell)

    figure(fig);
    b = bar([HR(1:2)],'FaceAlpha',0.3);
    ylim([0.8 1.8]);
    fig = fig + 1;
    
    % Plot the morp for young 21%
    if strcmp(morp_name,'Time')
        %load('C:\Nati\Embryos\4Yoni\Embryo Deep learning\time_young.mat');
        % including 6.6
        load('C:\Nati\Embryos\4Yoni\Embryo Deep learning\time_young_14_03.mat');
        morp_data = time; 
        time_young = time;
        clear time
    else
        morp_data =  data_Y_M;
    end
    [survival_time,cen,xx,f,flow,fup,morp_data_mat] = time2survival(morp_data,x_common_2_cell);
    ind_survived = find(cen==1);
    ind_not_survived = find(cen==0);

    figure(fig);hold on
    try
        vs = violinplot(morp_data_mat(ind_survived,:),[],'ShowData',false,'ViolinColor',color_vec(2,:),'MedianColor',color_vec(2,:));
    catch
    end
    try
        [n,m]=size(morp_data_mat(ind_not_survived,:))
        if n==1
            plot(morp_data_mat(ind_not_survived,:),'o','color',color_vec(2,:),'markerfacecolor',color_vec(4,:));
        else
            vns = violinplot(morp_data_mat(ind_not_survived,:),[],'ShowData',false,'ViolinColor',color_vec(4,:),'MedianColor',color_vec(4,:));
        end
    catch
    end
    set(gca,'xtick',x_common_2_cell+1,'xticklabel',name_2_cell)
    Set_fig_YS(gca,14,14,14)
    set(gca,'XTickLabelRotation',-30)
    caption = sprintf('morphology = %s', morp_name);
    ylabel(caption);
    title({'The probability density of the Embryos data','at different developmental stages','\fontsize{7}{\color[rgb]{.5 0 .5}Embryo survived \color[rgb]{0 0 0}- \color[rgb]{0 .5 0}Embryo did not survive}'},'FontSize',12);
    % Calcuate KS test
    for i= 1:7
        deaths(i) = length(find(survival_time==i));
        if i == 1
            alive(i) = NA;
        else
            alive(i) = alive(i-1)-deaths(i-1);
        end

        try
            [temp,ks_p(i)] = kstest2(morp_data_mat(ind_survived,i),morp_data_mat(ind_not_survived,i));
        catch
        end
    end
    p_young = exp(diff(log(alive)));
    fig = fig + 1;

    % Plot the morp for old 21%
    if strcmp(morp_name,'Time')
        %load('C:\Nati\Embryos\4Yoni\Embryo Deep learning\time_old.mat');
        % including 6.6
        load('C:\Nati\Embryos\4Yoni\Embryo Deep learning\time_old_14_03.mat');
        morp_data = time;
        time_old = time;
        clear time
    else
        morp_data =  data_O_M;
    end
    [survival_time,cen,xx,f,flow,fup,morp_data_mat] = time2survival(morp_data,x_common_2_cell);
    ind_survived = find(cen==1);
    ind_not_survived = find(cen==0);

    figure(fig);hold on
    try
        vs = violinplot(morp_data_mat(ind_survived,:),[],'ShowData',false,'ViolinColor',color_vec(2,:),'MedianColor',color_vec(2,:));
    catch
    end
    try
        [n,m]=size(morp_data_mat(ind_not_survived,:))
        if n==1
            plot(morp_data_mat(ind_not_survived,:),'o','color',color_vec(2,:),'markerfacecolor',color_vec(4,:));
        else
            vs = violinplot(morp_data_mat(ind_not_survived,:),[],'ShowData',false,'ViolinColor',color_vec(4,:),'MedianColor',color_vec(4,:));
        end
    catch
    end
    set(gca,'xtick',x_common_2_cell+1,'xticklabel',name_2_cell)
    Set_fig_YS(gca,14,14,14)
    set(gca,'XTickLabelRotation',-30)
    caption = sprintf('morphology = %s', morp_name);
    ylabel(caption);
    title({'The probability density of the Embryos data','at different developmental stages','\fontsize{7}{\color[rgb]{.5 0 .5}Embryo survived \color[rgb]{0 0 0}- \color[rgb]{0 .5 0}Embryo did not survive}'},'FontSize',12);
    % Calcuate KS test
    for i= 1:7
        deaths(i) = length(find(survival_time==i));
        if i == 1
            alive(i) = NA;
        else
            alive(i) = alive(i-1)-deaths(i-1);
        end

        try
            [temp,ks_p(i)] = kstest2(morp_data_mat(ind_survived,i),morp_data_mat(ind_not_survived,i));
        catch
        end
    end

    p_old = exp(diff(log(alive)));
    fig = fig + 1;

    % plot the morp for survived
    if strcmp(morp_name,'Time')
        [survival_time,cen,xx,f,flow,fup,morp_data] = time2survival(time_young,x_common_2_cell);
        [survival_time,cen_o,xx,f,flow,fup,morp_data_mat_o] = time2survival(time_old,x_common_2_cell);
    else
        morp =  data_Y_M;
        [survival_time,cen,xx,f,flow,fup,morp_data] = time2survival(morp,x_common_2_cell);
        morp =  data_O_M;
        [survival_time,cen_o,xx,f,flow,fup,morp_data_mat_o] = time2survival(morp,x_common_2_cell);
    end
    
    ind_survived = find(cen==1);
    ind_survived_o = find(cen_o==1);

    figure(fig);hold on

    vs = violinplot(morp_data(ind_survived,:),[],'ShowData',false,'ViolinColor',color_vec(2,:),'MedianColor',color_vec(2,:));
    vs_o = violinplot(morp_data_mat_o(ind_survived_o,:),[],'ShowData',false,'ViolinColor',color_vec(4,:),'MedianColor',color_vec(4,:));

    set(gca,'xtick',x_common_2_cell+1,'xticklabel',name_2_cell)
    Set_fig_YS(gca,14,14,14)
    set(gca,'XTickLabelRotation',-30)
    caption = sprintf('morphology = %s', morp_name);
    ylabel(caption);
    title({'The probability density of the Survived Embryos data','at different developmental stages','\fontsize{7}{\color[rgb]{.5 0 .5}Young Embryo \color[rgb]{0 0 0}- \color[rgb]{0 .5 0}Old Embryo}'},'FontSize',12); 
    fig = fig + 1;

    % save all the figures
    saveFigs(morp_name);
    pause(6)
    close all;
    clc;
    clear;
end