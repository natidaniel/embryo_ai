clear
close all
clc


%% Total clusters of cells
clear

Only_2cell_Transition_morp_ckpt = 'TRUE';
Onecell_mean_morp_ckpt = 'FALSE';
All_morp_time = 'FALSE';

color_vec = [0 0.5 0.5;
    0.5 0 0.5;
    0 0 1;
    1 0 0;
    0.5 0 0;
    0 0 0.5];

%  load('C:\Nati\Embryos\4Yoni\data\manual_time_survive_ind.mat');
load('C:\Nati\Embryos\4Yoni\data\machine_time_survive_ind.mat');

% 2 cell
x_common_2_cell = [0:6];
name_2_cell = {'2-cell', '4-cell', '8-cell','Compaction','Morula','Early Blastocyst','Blastocyst'};
x_common_4_cell = [0:5];
name_4_cell = {'4','8','M','C','EB','B'};


x_machine= [0:5];
name_machine = {'2-cell', '4-cell', '8-cell','Morula','Early Blastocyst','Blastocyst'};

 morp_list_y = {'Area','AutoCorr','Correlation','Varinace','Smoothness','SumAverage','Roundness','LPspectrumFilter','TextureSkewness','Time'};
    morp_list_o = {'Area','AutoCorr','Varinace','SumAverage','DWS','HPspectrumFilter','TextureSkewness','Time'};


morp_name = {'Area';
         'Diameter'
        'Perimeter'
         'Eccentricity'
        'Autocorrelation'
         'Contrast'
         'Correlation'
        'ClusterProminence'
         'ClusterShade'
        'Dissimilarity'
         'Energy'
         'Entropy'
         'Homogeneity'
         'MaximumProbability'
        'Variance'
       'Smoothness'
       'SumEverage'
       'SumVariance'
        'SumEntropy'
        'DifferenceVariance'
      'DifferenceEntropy'
     'InfoMeasureOfCorrelation'
        'InverseDifferenceNormalized'
        'InverseDifferenceMoment'
       'Roundness'
        'HWS'
         'VWS'
       'DWS'
         'GWS'
        'LPSF_T_V'
        'HPSF_T_V'
        'BPSF_T_V'
       'HOG_m'
      'm_Gmag_v'
       'm_Gdir_v'
         'v_Gmag_v'
        'v_Gdir_v'
        'TextureSkewness'
       'GradientMean'
       'GradientStd'
     'GradientGlobalmean'
       'GradientUniformity'%irrelevant data
      'GradientEntropy' %irrelevant data
       'GradientSkewness'
'GradientCorrelation' %irrelevant data
       'Time'
   };

close all

load('C:\Nati\Embryos\4Yoni\data\machine_morp_data.mat')

%% create matrices for clsification and dimenstionality reduction
if strcmp(Only_2cell_Transition_morp_ckpt,'TRUE')
    ind_age_full = logical([zeros(size(ind_blasto_Y)) ones(size(ind_blasto_O))]');
    ind_survived_full = logical([ind_blasto_Y ind_blasto_O]');

    for cnt_emb = 1:length(ind_blasto_Y)

        time =  data_Y_R{cnt_emb}(46,1:end-1)+1;
        data_0 = data_Y{cnt_emb}(:,time);

    %         data_p1 = data_Y{cnt_emb}(:,time+1);
    %     data_m1 = data_Y{cnt_emb}(:,time-1);

        data_0(end,:) = time;

        data_y_R2{cnt_emb} = data_0;

    end


    for cnt_emb = 1:length(ind_blasto_O)

        time =  data_O_R{cnt_emb}(46,1:end-1)+1;
        data_0 = data_O{cnt_emb}(:,time);

    %         data_p1 = data_Y{cnt_emb}(:,time+1);
    %     data_m1 = data_Y{cnt_emb}(:,time-1);

        data_0(end,:) = time;

        data_o_R2{cnt_emb} = data_0;

    end

    data_R2 =  [data_y_R2 data_o_R2];;
end

if strcmp(Onecell_mean_morp_ckpt,'TRUE')
    ind_age_full = logical([zeros(size(ind_blasto_Y)) ones(size(ind_blasto_O))]');
    ind_survived_full = logical([ind_blasto_Y ind_blasto_O]');
    data_y_R2 = data_Y_R;
    data_o_R2 = data_O_R;
    data_R2 =  [data_y_R2 data_o_R2];;
end

if strcmp(All_morp_time,'TRUE')
    ind_age_full = logical([zeros(size(ind_blasto_Y)) ones(size(ind_blasto_O))]');
    ind_survived_full = logical([ind_blasto_Y ind_blasto_O]');
    data_y_R2 = data_Y;
    data_o_R2 = data_O;
    data_R2 =  [data_y_R2 data_o_R2];
    data_time_mat =  [time_mat_machine ; time_mat_o_machine];
end

%%
% ind_features = [1 4 7 46];
% ind_features = [25 46];
ind_features = 1:46;

%% loop over yonung
if strcmp(Only_2cell_Transition_morp_ckpt,'TRUE')
    data_morph = data_R2(~ind_age_full);
    ind_survived = find(ind_survived_full(~ind_age_full));
    ind_not_survived = find(~(ind_survived_full(~ind_age_full)));

    close all

    for cnt_features = 1:length(ind_features)

        %     figure(cnt_features)
        if strcmp(Only_2cell_Transition_morp_ckpt,'TRUE')
            data = NaN*ones(length(data_morph),6);
        end
        if strcmp(Onecell_mean_morp_ckpt,'TRUE')
             data = NaN*ones(length(data_morph),7);
        end

        for cnt_embryo =1: length(data_morph)

            [F,T] = size(data_morph{cnt_embryo});%size(data_Y_R{cnt_embryo}(ind_features(cnt_features),:));
            ind_end = T;


            data(cnt_embryo,1:ind_end) = data_morph{cnt_embryo}(ind_features(cnt_features),1:ind_end);
        end

        mean_Y_s(cnt_features,:) = nanmean(data(ind_survived,:));
        mean_Y_ns(cnt_features,:)  = nanmean(data(ind_not_survived,:));

        figure(cnt_features);title(morp_name(ind_features(cnt_features)))
        vs = violinplot_ys_lite(data(ind_survived,:),x_machine+1,1,'ShowData',false,'ViolinColor',color_vec(1,:),'MedianColor',color_vec(1,:));
        vs = violinplot_ys_lite(data(ind_not_survived,1:5),x_machine(1:5)+1,1,'ShowData',false,'ViolinColor',color_vec(3,:),'MedianColor',color_vec(3,:));

          % KS test p values
        for cnt_stage= 1:5

            [temp,ks_p_y(cnt_features,cnt_stage)] = kstest2(data(ind_survived,cnt_stage),data(ind_not_survived,cnt_stage));


        end

    end
end

%% loop over old
if strcmp(Only_2cell_Transition_morp_ckpt,'TRUE')
    data_morph = data_R2(ind_age_full);
    ind_survived = find(ind_survived_full(ind_age_full));
    ind_not_survived = find(~(ind_survived_full(ind_age_full)));

    for cnt_features = 1:length(ind_features)

        %     figure(cnt_features)
        if strcmp(Only_2cell_Transition_morp_ckpt,'TRUE')
            data = NaN*ones(length(data_morph),6);
        end
        if strcmp(Onecell_mean_morp_ckpt,'TRUE')
             data = NaN*ones(length(data_morph),7);
        end

        for cnt_embryo =1: length(data_morph)

            [F,T] = size(data_morph{cnt_embryo});%size(data_Y_R{cnt_embryo}(ind_features(cnt_features),:));
            ind_end = T;


            data(cnt_embryo,1:ind_end) = data_morph{cnt_embryo}(ind_features(cnt_features),1:ind_end);
        end


        figure(cnt_features*100);title(morp_name(ind_features(cnt_features)))

        vs = violinplot_ys_lite(data(ind_survived,:),x_machine+1,1,'ShowData',false,'ViolinColor',color_vec(2,:),'MedianColor',color_vec(2,:));
        vs = violinplot_ys_lite(data(ind_not_survived,1:5),x_machine(1:5)+1,1,'ShowData',false,'ViolinColor',color_vec(4,:),'MedianColor',color_vec(4,:));

        mean_O_s(cnt_features,:) = nanmean(data(ind_survived,:));
        mean_O_ns(cnt_features,:)  = nanmean(data(ind_not_survived,:));

        % KS test p values
        for cnt_stage= 1:5
            [temp,ks_p_o(cnt_features,cnt_stage)] = kstest2(data(ind_survived,cnt_stage),data(ind_not_survived,cnt_stage));
        end
    end
end

%% loop over ALL

data_morph = data_R2
ind_survived = ind_survived_full;
ind_not_survived = ~ind_survived_full;
ind_features = 1:46;
for cnt_features = 1:length(ind_features)
    
    %     figure(cnt_features)
    if strcmp(Only_2cell_Transition_morp_ckpt,'TRUE')
        data = NaN*ones(length(data_morph),6);
    end
    if strcmp(Onecell_mean_morp_ckpt,'TRUE')
         data = NaN*ones(length(data_morph),7);
    end
    if strcmp(All_morp_time,'TRUE')
         data = NaN*ones(length(data_morph),97);
    end
    
    for cnt_embryo =1: length(data_morph)
        
        [F,T] = size(data_morph{cnt_embryo});%size(data_Y_R{cnt_embryo}(ind_features(cnt_features),:));
        ind_end = T;
        
        
        data(cnt_embryo,1:ind_end) = data_morph{cnt_embryo}(ind_features(cnt_features),1:ind_end);
        
        data_features{cnt_features} = data;
    end
    
    
%     figure(cnt_features*1000);title(morp_name(ind_features(cnt_features)))
%     
%     vs = violinplot_ys_lite(data(ind_survived,:),x_machine+1,1,'ShowData',false,'ViolinColor',color_vec(2,:),'MedianColor',color_vec(2,:));
%     vs = violinplot_ys_lite(data(ind_not_survived,1:5),x_machine(1:5)+1,1,'ShowData',false,'ViolinColor',color_vec(4,:),'MedianColor',color_vec(4,:));
%     
    mean_T_s(cnt_features,:) = nanmean(data(ind_survived,:));
    mean_T_ns(cnt_features,:)  = nanmean(data(ind_not_survived,:));
    
    if strcmp(Only_2cell_Transition_morp_ckpt,'TRUE')  
        % KS test p values
        for cnt_stage= 1:5
            [temp,ks_p_T(cnt_features,cnt_stage)] = kstest2(data(ind_survived,cnt_stage),data(ind_not_survived,cnt_stage));
        end
    end
end

%% plot the significant 
if strcmp(Only_2cell_Transition_morp_ckpt,'TRUE')
    close all
    figure(1);
    for cnt_stage =1:5

    subplot(5,2,(cnt_stage-1)*2+1);hold on;
    bar(-log(ks_p_T(:,cnt_stage)));
    xlim([-0.5,46.5]);
    set(gca,'xtick',1:46,'xticklabel',morp_name)

    set(gca,'XTickLabelRotation',-30);

    Set_fig_YS(gca,8,8,18);

    M = max(-log(ks_p_T(1:45,cnt_stage)));
    m = min(-log(ks_p_T(1:45,cnt_stage)));

    p_cutoff =graythresh((-log(ks_p_T(1:45,cnt_stage))-m)/(M-m)  );
    p_cutoff = p_cutoff*(M-m)+m;
    p_cutoff_vec(cnt_stage) = p_cutoff;
    refline(0,(p_cutoff));

    ind_sig{cnt_stage} = find(-log(ks_p_T(:,cnt_stage))>=p_cutoff);

    ylim([0 12])
    end


    %%
    figure(2)
    ind_vec = zeros(46,5);

    for cnt_stage = 1:5

        ind_vec(ind_sig{cnt_stage} ,cnt_stage) =1;

    end

    [val,ind] = sort(sum(ind_vec,2),'descend');

    imagesc(ind_vec(ind,:));

    set(gca,'ytick',1:46,'YTickLabel',morp_name(ind));

    set(gca,'xtick',1:5,'xticklabel',name_machine)

    set(gca,'XTickLabelRotation',-30);

    box off

    ind_super_sig = ind(find(val>=2));
end

%% Size control
close all
% plot the area as a funciton of time
area_f = data_features{1};
time_f = data_features{46};
d_time = diff(time_f,1,2);
d_area = diff(area_f,1,2)./area_f(:,1:end-1);

if strcmp(Only_2cell_Transition_morp_ckpt,'TRUE')
    num_stg = 6;
end
if strcmp(Onecell_mean_morp_ckpt,'TRUE')
    num_stg = 7;
end
if strcmp(All_morp_time,'TRUE')
    num_stg = 97;
    [ms, ns] = size(time_f)
    for i=1:ms
        [~, col] = find(isnan(time_f(i,:)));
        if isempty(col)
            time_f(i,:) = [1:ns];
        else
            time_f(i,:) = [1:(col-1),time_f(i,col)];
        end
    end
    d_time = diff(time_f,1,2);
end

if ~strcmp(All_morp_time,'TRUE')
    figure(1);hold on
    for cnt_stage = 1:num_stg
        plot(time_f(:,cnt_stage),area_f(:,cnt_stage),'o');
    end
else
    figure(1);hold on
    for cnt_stage = 1:num_stg
        plot(median(time_f(:,cnt_stage)),median(area_f(:,cnt_stage)),'o');
    end
end

figure(2);hold on
for cnt_embryo = 1:length(time_f)
    plot(time_f(cnt_embryo,:),area_f(cnt_embryo,:));
    %plot(time_f(cnt_embryo,[1,75,80,85,90]),area_f(cnt_embryo,[1,75,80,85,90]));
end

if strcmp(Only_2cell_Transition_morp_ckpt,'TRUE')
    x = [1:5];
    name_diff = {'\Delta_{4,2}' '\Delta_{8,4}' '\Delta_{M,8}' '\Delta_{EB,M}' '\Delta_{B,EB}'}
    figure(3)
    violinplot_ys_lite(d_area,x,1,'ShowData',false,'ViolinColor',color_vec(1,:),'MedianColor',color_vec(1,:));
    set(gca,'xtick',x,'xticklabel',name_diff )
    set(gca,'XTickLabelRotation',0)
    Set_fig_YS(gca,14,14,14)
end
if strcmp(Onecell_mean_morp_ckpt,'TRUE')
    x = [1:6];
    name_diff = {'\Delta_{2,1}' '\Delta_{4,2}' '\Delta_{8,4}' '\Delta_{M,8}' '\Delta_{EB,M}' '\Delta_{B,EB}'}
    figure(3)
    violinplot_ys_lite(d_area,x,1,'ShowData',false,'ViolinColor',color_vec(1,:),'MedianColor',color_vec(1,:));
    set(gca,'xtick',x,'xticklabel',name_diff )
    set(gca,'XTickLabelRotation',0)
    Set_fig_YS(gca,14,14,14)
end

if strcmp(All_morp_time,'FALSE')
    figure(4)
    violinplot_ys_lite(d_area./d_time,x,1,'ShowData',false,'ViolinColor',color_vec(1,:),'MedianColor',color_vec(1,:));
    set(gca,'xtick',x,'xticklabel',name_diff )
    set(gca,'XTickLabelRotation',0)
    Set_fig_YS(gca,14,14,14)
end

if strcmp(All_morp_time,'FALSE')
    for z = 1:num_stg
        figure(z*10);hold on
        plot(area_f(:,1),area_f(:,z),'o');
        ylabel('Area stage');
        if strcmp(Only_2cell_Transition_morp_ckpt,'TRUE')
            xlabel('Area 2 cell')
        end
        if strcmp(Onecell_mean_morp_ckpt,'TRUE')
            xlabel('Area 1 cell')
        end
    end
else
    data_time_mat_1 = data_time_mat - 1;
    for k=1:6
        switch k % reducing 1cell
        case 1
            CT = 69;
        case 2
            CT = 74;
        case 3
            CT = 79;
        case 4
            CT = 84;
        case 5
            CT = 89;
        case 6
            CT = 94;
        end
        figure(5);hold on
        subplot(2,6,k);
        plot(area_f(:,median(data_time_mat_1(:,1))),area_f(:,CT),'o');
        ylabel({'Area stage', CT});
        xlabel('Area 1 cell')
        subplot(2,6,6+k);
        [nan_m, nan_n] = find(isnan((data_time_mat_1(:,2))));
        if isempty(nan_n)
            plot(area_f(:,median(data_time_mat_1(:,2))),area_f(:,CT),'o');
        else
            data_time_mat_1(nan_m,2) = 10^6;
            plot(area_f(:,median(data_time_mat_1(:,2))),area_f(:,CT),'o');
        end
        ylabel({'Area stage', CT});
        xlabel('Area 2 cell')
    end
end

if strcmp(All_morp_time,'FALSE')
    figure(80)
    plot(area_f(:,1), area_f(:,end-1) - area_f(:,1),'o')
    ylabel('\Delta{B,1}');
    if strcmp(Only_2cell_Transition_morp_ckpt,'TRUE')
        xlabel('Area 2 cell')
    end
    if strcmp(Onecell_mean_morp_ckpt,'TRUE')
        xlabel('Area 1 cell')
    end
end

if strcmp(Only_2cell_Transition_morp_ckpt,'TRUE')
    figure(81)
    plot(area_f(:,1), time_f(:,end-1) - time_f(:,1),'o')
    ylabel('\Delta{T,2}');xlabel('Area 2 cell')
end

if strcmp(All_morp_time,'TRUE')
    for j=1:6
        figure(90);hold on
        plot(area_f(:,median(data_time_mat_1(:,1))),area_f(:,69+5*(j-1)) - area_f(:,median(data_time_mat_1(:,2))),'o')
        ylabel('\Delta{comb time from 94-to-69 (+/-5, 6 stages) , 1}');
        xlabel('Area 1 cell')
    end
end

for z = 1:num_stg
    figure(200);hold all
    if strcmp(All_morp_time,'FALSE')
        plot(area_f(:,num_stg),area_f(:,z),'o');
    else
        [nan_m, nan_n] = find(isnan((data_time_mat_1(:,end))));
        data_time_mat_1(nan_m,end) = 10^6;
        plot(area_f(:,median(data_time_mat_1(:,end))),area_f(:,z),'o');
    end
    ylabel('Area stage z');xlabel('Area')    
end

%growth rate
if strcmp(All_morp_time,'TRUE')
    for i=1:length(area_f)
        figure(201);hold all
        plot(time_f(i,:),log(area_f(i,:)))
        ylabel('log(Area)');xlabel('Time') 
    end
end
if strcmp(Only_2cell_Transition_morp_ckpt,'TRUE')
    figure(201);hold all
    %remove the outlier embryo
    l = find(time_f(:,1)==2);
    time_f(l,:) = [];
    area_f(l,:) = [];
    plot(time_f(:,1),log(area_f(:,1)),'o')
    ylabel('log(Area 2 cell)');xlabel('Time')
    
    figure(203);
    log_eb_2 = log(area_f(:,end-1)./area_f(:,1));
    dt_eb_2 = ((time_f(:,end-1)-time_f(:,1))*log(2))./(log(area_f(:,end-1))-log(area_f(:,1)));
    gg = log_eb_2./dt_eb_2;
    plot(area_f(:,1),gg,'o')
    ylabel('DTlog(Aeb/Area2)');xlabel('Area2')
end

%%
for z = 1:(num_stg-1)
    figure(z);hold on
    plot(data_features{1}(:,z),data_features{1}(:,z+1)-data_features{1}(:,z),'ko');
    plot( data_features{1}(find(ind_not_survived),z),data_features{1}(find(ind_not_survived),z+1)-data_features{1}(find(ind_not_survived),z),'ro');
end

%%
figure(1);hold on
plot(data_features{1}(:,1),(data_features{1}(:,end-1)-data_features{1}(:,1))./data_features{1}(:,1),'ko');
%plot( data_features{1}(find(ind_not_survived),z),data_features{1}(find(ind_not_survived),z+1)-data_features{1}(find(ind_not_survived),z),'ro');

%%       
figure(3);hold on
for z = 1:(num_stg-1)
    figure(z);hold on
    plot(data_features{1}(:,z),(data_features{1}(:,z+1)-data_features{1}(:,z))/data_features{1}(:,z),'ko');
    plot( data_features{1}(find(ind_not_survived),z),data_features{1}(find(ind_not_survived),z+1)-data_features{1}(find(ind_not_survived),z),'ro');

%         figure(z*10);hold on
% 
%     plot(data_features{1}(:,z),data_features{46}(:,z+1),'ko');

%     plot(data_features{1}(find(ind_not_survived),z),data_features{1}(find(ind_not_survived),z+1),'ro');
% % 
    x = data_features{1}(:,z)
    y = data_features{1}(:,z+1);
    
    ind_x =~isnan(x);
    ind_y = ~isnan(y);
    ind = logical(ind_y.*ind_x);
    
    x = x(ind);
    y = y(ind);
    
    s = fit(x,y,'a*x+b','Exclude', x > 60000);
    
%         s = fit(x,y,'a*x+b');
% 
    slope(z) = s.a;
    intersect(z) = s.b;
    
%     plot(x,s(x),'g');
    
    
    figure(z*10);hold on
    plot( data_features{46}(:,z),data_features{1}(:,z+1)-data_features{1}(:,z),'ko');

        plot( data_features{46}(find(ind_not_survived),z),data_features{1}(find(ind_not_survived),z+1)-data_features{1}(find(ind_not_survived),z),'ro');

        
% plot3(data_features{ind(2)}(find(ind_not_survived),z),data_features{ind(1)}(find(ind_not_survived),z),z*ones(size(data_features{46}(find(ind_not_survived),z))),'ro');


end

figure
bar(slope)
figure
bar(intersect)
%% PCA


% ind_features = [1 5  28 46];
ind_features = ind_super_sig

data = [];
data_time = []
data_age =[];
data_survived = [];
data_emb = [];

time = [];

% ind_features = 1:46;

for i = 1:62
    
    [F,T] = size(data_y_R2{i}(ind_features,:));
    
    data =[ data data_y_R2{i}(ind_features,1:T)];
    time = [time data_y_R2{i}(46,1:T)];
    
    data_time = [data_time repmat([1:T],[F 1])];
    data_age = [data_age zeros(1,T)];
    data_survived = [data_survived ind_blasto_Y(i)*ones(1,T)];
    data_emb = [data_emb i*ones(1,T)];
    
end

k = 1;
for i = [1:31 33:41]
    
        
    [F,T] = size(data_o_R2{i}(ind_features,:));
    
    data =[ data data_o_R2{i}(ind_features,1:T-1)];
        time = [time data_o_R2{i}(46,1:T-1)];

    data_time = [data_time repmat([1:T-1],[F 1])];
    
    data_age = [data_age ones(1,T-1)];
    data_survived = [data_survived ind_blasto_O(i)*ones(1,T-1)];
    data_emb = [data_emb (k+62)*ones(1,T-1)];
    
    k=k+1;
end


data = zscore(data);
% data = (data');

[coeff,score,latent] = pca(data');
latent/sum(latent);



close all
figure(1)
scatter3(score(:,1),score(:,2),score(:,3),[],data_emb(1,:))

figure(2)
scatter3(score(:,1),score(:,2),score(:,3),[],data_age)

figure(3)
scatter3(score(:,1),score(:,2),score(:,3),[],data_time(1,:))

figure(4)
scatter3(score(:,1),score(:,2),time,[],data_survived(:))

figure(5)
scatter3(score(:,1),score(:,2),score(:,3),[],data_survived(1,:))

%% Tsne

Y = tsne(data','Distance','seuclidean');

figure(6)
scatter(Y(:,1),Y(:,2),[],data_time(1,:))

figure(7);hold on
scatter(Y(:,1),Y(:,2),[],data_age)
text(Y(:,1),Y(:,2),num2str(data_emb'))

figure(8);hold on
scatter(Y(:,1),Y(:,2),[],data_survived(1,:))


figure(9);hold on
scatter(Y(:,1),Y(:,2),[],data_emb(1,:))


figure(10);hold on
scatter3(Y(:,1),Y(:,2),time,[],data_time(1,:))

%%
    

cnt_sig_feat = 1;

clear sig_feat_ind 

figure(2);hold all
for cnt_feature = 1:length(ks_p_T)
    
    if ~isempty(find(ks_p_T(cnt_feature,:)<p_cutoff))
    
        ind = find(ks_p_T(cnt_feature,:)<p_cutoff);
        
        plot(ones(size(ind))*cnt_sig_feat,ind,'ok')
        sig_feat_ind(cnt_sig_feat) = cnt_feature;
        
        cnt_sig_feat = cnt_sig_feat+1;
        
    end
    

end
set(gca,'xtick',1:length(sig_feat_ind),'xticklabel',morp_name(sig_feat_ind))

set(gca,'XTickLabelRotation',-30)
%%


   cnt_sig_feat =1;
clear sig_feat_ind 

figure(2);hold all
for cnt_feature = 1:length(ks_p_o)
    
    if ~isempty(find(ks_p_o(cnt_feature,:)<p_cutoff))
    
        ind = find(ks_p_o(cnt_feature,:)<p_cutoff);
        
        plot(ones(size(ind))*cnt_sig_feat,ind,'ok')
        sig_feat_ind(cnt_sig_feat) = cnt_feature;
        
        cnt_sig_feat = cnt_sig_feat+1;
        
    end
    

end

set(gca,'xtick',1:length(sig_feat_ind),'xticklabel',morp_name(sig_feat_ind))

set(gca,'XTickLabelRotation',-30)





 