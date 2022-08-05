%% figure 2 code


%% Load data and adjust
clear all
close all
clc

load dataYO_with_indications_plus_minus1.mat
color_vec = [0 0.5 0.5;
    0.5 0 0.5;
    0 0 1;
    1 0 0;
    0.5 0 0;
    0 0 0.5];

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

x_machine= [0:5];
name_machine = {'2-cell', '4-cell', '8-cell','Morula','Early Blastocyst','Blastocyst'};

%

for cnt_prop = 1:46
    
    p_Y{cnt_prop} = ones(62,6)*NaN;
    p_O{cnt_prop} = ones(41,6)*NaN;
    
    for cnt_embryo = 1:62
        
        ind_end = length(data_Y{cnt_embryo}(cnt_prop,1:end));
        
        p_Y{cnt_prop}(cnt_embryo,1:ind_end) = data_Y{cnt_embryo}(cnt_prop,1:end);
        
    end
    
    for cnt_embryo = 1:41
        
        ind_end = length(data_O{cnt_embryo}(cnt_prop,1:end));
        
        p_O{cnt_prop}(cnt_embryo,1:ind_end) = data_O{cnt_embryo}(cnt_prop,1:end);
        
    end
    
end

% adjust time
 p_Y{46} =  p_Y{46}-1;
 p_O{46} =  p_O{46}-1;

%% 2A surival plot

figure(1);hold on;
[survival_time,cen_Y,xx,f,flow,fup,time_mat] = time2survival(p_Y{46},x_machine);
stairs(xx,f,'color',color_vec(1,:),'linewidth',2);
% stairs(xx,flow,'color',color_vec(1,:),'linewidth',1);
% stairs(xx,fup,'color',color_vec(1,:),'linewidth',1);

plot([0 xx(end)],[f(end) f(end)],'--','color',color_vec(1,:));

[survival_time,cen_O,xx,f,flow,fup,time_mat] = time2survival(p_O{46},x_machine);
stairs(xx,f,'color',color_vec(2,:),'linewidth',2);
% stairs(xx,flow,'color',color_vec(2,:),'linewidth',1);
% stairs(xx,fup,'color',color_vec(2,:),'linewidth',1);

plot([0 xx(end)],[f(end) f(end)],'--','color',color_vec(2,:));

set(gca,'xtick',x_machine,'xticklabel',name_machine);

ylim([0.5 1.05]);
set(gca,'XTickLabelRotation',-30)

Set_fig_YS(gca,14,14,14)

[HR(1),p,NA,NB] = HRfromTime(p_Y{46},p_O{46},x_machine)
%% calculate entorpy

for cnt_stage = 1:6
    num_alive_Y(cnt_stage) = length(find(~isnan(p_Y{46}(:,cnt_stage))));
    num_alive_O(cnt_stage) = length(find(~isnan(p_O{46}(:,cnt_stage))));
    
end

p_alive_Y = num_alive_Y(end)./num_alive_Y(1:end-1);

p_alive_O = num_alive_O(end)./num_alive_O(1:end-1);

H_Y = - (p_alive_Y.*log2(p_alive_Y) + (1-p_alive_Y).*log2(1-p_alive_Y));
H_O = - (p_alive_O.*log2(p_alive_O) + (1-p_alive_O).*log2(1-p_alive_O));

figure(2)
b = bar([1-H_Y',1-H_O']);ylim([0 1]);

% b.CData([:,:) = [.5 0 .5];

ylabel('MI');

%% add paramter information
close all

% young
cen = cen_Y;
p = p_Y;

for cnt_stage = 1:5
    
    for cnt_prop = 1:46
        param = p{cnt_prop}(:,cnt_stage);
        param_given_alive = param(find(cen==1));
        param_given_dead = param(find(cen==0));
        param_given_dead = param_given_dead(find(~isnan(param_given_dead)));
        
        p_alive = p_alive_Y(cnt_stage);
        
        H_Y_given_prop(cnt_prop,cnt_stage)= MI(param,param_given_alive,param_given_dead,p_alive);
        
        
        % calculating basal entropy
        
        for cnt_rep = 1:100
            tic
            cen_rand = cen(randperm(length(cen)));
            
            param_given_alive_rand = param(find(cen_rand==1));
            param_given_dead_rand  = param(find(cen_rand==0));
            param_given_dead_rand  = param_given_dead_rand(find(~isnan(param_given_dead_rand)));
            
            H_Y_given_prop_rand(cnt_prop,cnt_stage,cnt_rep)= MI(param,param_given_alive_rand,param_given_dead_rand,p_alive);
            
            toc
        end
        
        mean_HY(cnt_prop,cnt_stage) = mean(H_Y_given_prop_rand(cnt_prop,cnt_stage,:));
        std_HY(cnt_prop,cnt_stage) = std(H_Y_given_prop_rand(cnt_prop,cnt_stage,:));
        
        if H_Y_given_prop(cnt_prop,cnt_stage)< mean_HY(cnt_prop,cnt_stage)- std_HY(cnt_prop,cnt_stage);
            prop_sig_Y(cnt_prop,cnt_stage) = 1;
        else
            prop_sig_Y(cnt_prop,cnt_stage) = 0;
        end
        
    end
end

%%
% figure
% for cnt_stage = 1:5
%     subplot(5,1,cnt_stage)
%
%     ones_vec = ones(size(H_Y_given_prop(ind_sig,cnt_stage)));
%
%
%
%     barh([1-ones_vec*H_Y(cnt_stage)-H_Y_given_prop(ind_sig,cnt_stage)+mean_HY(ind_sig,cnt_stage)],'stacked');hold on
%     barh(1-ones_vec*H_Y(cnt_stage));
%
%    xlim([0 1])
% end
%
% figure(2)
% delta_I = prop_sig.*(-H_Y_given_prop+mean_HY);
%
% imagesc(delta_I);colormap(redbluecmap)
%%

% old
cen = cen_O;
p = p_O;

for cnt_stage = 1:5
    
    for cnt_prop = 1:46
        param = p{cnt_prop}(:,cnt_stage);
        param_given_alive = param(find(cen==1));
        param_given_dead = param(find(cen==0));
        param_given_dead = param_given_dead(find(~isnan(param_given_dead)));
        
        p_alive = p_alive_O(cnt_stage);
        
        H_O_given_prop(cnt_prop,cnt_stage)= MI(param,param_given_alive,param_given_dead,p_alive);
        
        
        % calculating basal entropy
        
        for cnt_rep = 1:100
            
            cen_rand = cen(randperm(length(cen)));
            
            param_given_alive_rand = param(find(cen_rand==1));
            param_given_dead_rand  = param(find(cen_rand==0));
            param_given_dead_rand  = param_given_dead_rand(find(~isnan(param_given_dead_rand)));
            
            H_O_given_prop_rand(cnt_prop,cnt_stage,cnt_rep)= MI(param,param_given_alive_rand,param_given_dead_rand,p_alive);
            
            
        end
        
        mean_HO(cnt_prop,cnt_stage) = mean(H_O_given_prop_rand(cnt_prop,cnt_stage,:));
        std_HO(cnt_prop,cnt_stage) = std(H_O_given_prop_rand(cnt_prop,cnt_stage,:));
        
        if H_O_given_prop(cnt_prop,cnt_stage)< mean_HO(cnt_prop,cnt_stage)- std_HO(cnt_prop,cnt_stage);
            prop_sig_O(cnt_prop,cnt_stage) = 1;
        else
            prop_sig_O(cnt_prop,cnt_stage) = 0;
        end
        
    end
end



%%

load data_figure_2

[map,num,typ,scheme] = brewermap(50,'PuRd');

delta_I_Y = prop_sig_Y.*(-H_Y_given_prop+mean_HY);
delta_I_O = prop_sig_O.*(-H_O_given_prop+mean_HO);

[val,ind_sort] = sort(mean(delta_I_Y,2),'descend')

max_I = max(max([delta_I_Y;delta_I_O]))

figure(2)
subplot(1,2,1)
imagesc(delta_I_Y(ind_sort,:));colormap(map);
set(gca,'xtick',[1:5],'XTickLabel',name_machine(1:5),'XTickLabelRotation',45,'YTick',(1:45),'YTickLabel',morp_name)
caxis([0 max_I])
box off
subplot(1,2,2)


imagesc(delta_I_O(ind_sort,:));colormap(map)

set(gca,'xtick',[1:5],'XTickLabel',name_machine(1:5),'XTickLabelRotation',45,'YTick',(1:45),'YTickLabel',{})
box off
caxis([0 max_I]);
Set_fig_YS(gca,18,18,18)
colorbar


figure(3)
subplot(2,1,1)
[map,num,typ,scheme] = brewermap(50,'PuBuGn');

imagesc(delta_I_Y(ind_sort,:)');colormap(map);
set(gca,'ytick',[1:5],'yTickLabel',name_machine(1:5),'xTickLabelRotation',45,'xTick',(1:45),'xTickLabel',{})
caxis([0 max_I])
box off

subplot(2,1,2)
imagesc(delta_I_O(ind_sort,:)');colormap(map)

set(gca,'ytick',[1:5],'yTickLabel',name_machine(1:5),'xTickLabelRotation',45,'xTick',(1:45),'xTickLabel',morp_name(ind_sort))
caxis([0 max_I])
box off


[map,num,typ,scheme] = brewermap(50,'Reds');

figure(4)
subplot(2,1,1)

imagesc(delta_I_Y(ind_sort,:)');colormap(map);
set(gca,'ytick',[1:5],'yTickLabel',name_machine(1:5),'xTickLabelRotation',45,'xTick',(1:45),'xTickLabel',{})
caxis([0 max_I])
box off

subplot(2,1,2)
imagesc(delta_I_O(ind_sort,:)');colormap(map)

set(gca,'ytick',[1:5],'yTickLabel',name_machine(1:5),'xTickLabelRotation',45,'xTick',(1:45),'xTickLabel',morp_name(ind_sort))
caxis([0 max_I])
box off

colorbar
%%
ind_sig_Y = (find(sum(prop_sig_Y,2)>=4))
ind_sig_O = (find(sum(prop_sig_O,2)>=4))

ind_sig_union = union(ind_sig_Y,ind_sig_O)
ind_sig_intersection = intersect(ind_sig_Y,ind_sig_O)




morp_name(union(ind_sig_Y,ind_sig_O))


figure(4)
subplot(2,1,1)
hold on;
bar([1:5],1-H_Y+delta_I_Y(ind_sig_intersection,:),'FaceColor',[0.5 0.5 0.5])
bar([1:5],1-H_Y,'FaceColor',color_vec(1,:))

er = errorbar([1:5],1-H_Y+delta_I_Y(ind_sig_intersection,:),std_HY(ind_sig_intersection,:)/2,std_HY(ind_sig_intersection,:)/2);
er.Color = [0 0 0];
er.LineStyle = 'none';

hold off

set(gca,'xtick',[1:5],'xticklabel',{});

set(gca,'XTickLabelRotation',-30)

Set_fig_YS(gca,14,14,14)

ylim([0 1])

subplot(2,1,2)
hold on;
bar([1:5],1-H_O+delta_I_O(ind_sig_intersection,:),'FaceColor',[0.5 0.5 0.5])
bar([1:5],1-H_O,'FaceColor',color_vec(2,:))

er = errorbar([1:5],1-H_O+delta_I_O(ind_sig_intersection,:),std_HO(ind_sig_intersection,:)/2,std_HO(ind_sig_intersection,:)/2);
er.Color = [0 0 0];
er.LineStyle = 'none';

hold off


set(gca,'xtick',[1:5],'xticklabel',name_machine);

set(gca,'XTickLabelRotation',-30)

Set_fig_YS(gca,14,14,14)
ylim([0 1])

%%
figure(5)
hold on;
vec_1 = [1:3:15];
vec_2 = [2:3:15];
vec_3 = [1.5:3:15];
bar(vec_1,1-H_Y+delta_I_Y(ind_sig_intersection,:),'FaceColor',[0.5 0.5 0.5],'BarWidth',0.25)
bar(vec_1,1-H_Y,'FaceColor',color_vec(1,:),'BarWidth',0.25)

er = errorbar(vec_1,1-H_Y+delta_I_Y(ind_sig_intersection,:),std_HY(ind_sig_intersection,:)/2,std_HY(ind_sig_intersection,:)/2);
er.Color = [0 0 0];
er.LineStyle = 'none';

hold off


hold on;
bar(vec_2,1-H_O+delta_I_O(ind_sig_intersection,:),'FaceColor',[0.5 0.5 0.5],'BarWidth',0.25)
bar(vec_2,1-H_O,'FaceColor',color_vec(2,:),'BarWidth',0.25)

er = errorbar(vec_2,1-H_O+delta_I_O(ind_sig_intersection,:),std_HO(ind_sig_intersection,:)/2,std_HO(ind_sig_intersection,:)/2);
er.Color = [0 0 0];
er.LineStyle = 'none';

hold off
set(gca,'xtick',vec_3,'xticklabel',name_machine);

set(gca,'XTickLabelRotation',-30)

Set_fig_YS(gca,14,14,14)
ylim([0 1]);xlim([0 15])

%% Run classifer
% clear all
% load data_figure_2
% 
% N_rep = 1
% for cnt_stage = 1:5
%        tic
%     for cnt_rep = 1:N_rep
% 
%      
%         clear class_Y_stage
%         for cnt_prop = 1:length(ind_sig_union)
%             
%             class_Y = p_Y{ind_sig_union(cnt_prop)};
%             
%             
%             temp_class = class_Y(:,cnt_stage);
%             
%             ind_nan = find(~isnan(temp_class(:,1)));
%             
%             class_Y_stage(:,cnt_prop) = class_Y(ind_nan,cnt_stage);
%             
%             
%         end
%         class_Y_stage(:,cnt_prop+1) = cen_Y(ind_nan);
%         
%         
%         % only time
%         
%         trainingData = class_Y_stage(:,[end-1,end]);
%                 
%         [trainedClassifier_only, validationAccuracy_only(cnt_stage),validationPredictions] = trainClassifierOnlyTimeSubsSpace(trainingData);
%         GT = trainingData(:,end);
%         Predict = trainedClassifier_only.predictFcn(trainingData(:,1:end-1));
%         
%         [TPR_Y_only(cnt_stage,cnt_rep),TNR_Y_only(cnt_stage,cnt_rep),Acc_Y_only(cnt_stage,cnt_rep),PPV_Y_only(cnt_stage,cnt_rep)] = ClassPrefYS(GT,Predict);
%         
%         
%         %w/o time
%         trainingData = class_Y_stage(:,[1:end-2,end]);
%         [trainedClassifier_woTime, validationAccuracy_woTime(cnt_stage)] = trainClassifierAllWOtimeSubsSpace(trainingData);
%         
%         GT = trainingData(:,end);
%         Predict = trainedClassifier_woTime.predictFcn(trainingData(:,1:end-1));
%         
%         [TPR_Y_woTime(cnt_stage,cnt_rep),TNR_Y_woTime(cnt_stage,cnt_rep),Acc_Y_woTime(cnt_stage,cnt_rep),PPV_Y__woTime(cnt_stage,cnt_rep)] = ClassPrefYS(GT,Predict);
%         
%         
%         %w time
%         trainingData = class_Y_stage;
%         [trainedClassifier_all, validationAccuracy_all(cnt_stage)] = trainClassifierAllSubsSpace(trainingData);
%         
%         GT = trainingData(:,end);
%         Predict = trainedClassifier_all.predictFcn(trainingData(:,1:end-1));
%         
%         [TPR_Y_all(cnt_stage,cnt_rep),TNR_Y_all(cnt_stage,cnt_rep),Acc_Y_all(cnt_stage,cnt_rep),PPV_Y__all(cnt_stage,cnt_rep)] = ClassPrefYS(GT,Predict);
%         
%         
%         
%         
%      
%     end
%        toc
% end

%% bar plot

figure(5)
hold on;
vec_1 = [1:3:15];
vec_2 = [2:3:15];
vec_3 = [1.5:3:15];
bar(vec_1,1-H_Y+delta_I_Y(ind_sig_intersection,:),'FaceColor',[0.5 0.5 0.5],'BarWidth',0.25)
bar(vec_1,1-H_Y,'FaceColor',color_vec(1,:),'BarWidth',0.25)

er = errorbar(vec_1,1-H_Y+delta_I_Y(ind_sig_intersection,:),std_HY(ind_sig_intersection,:)/2,std_HY(ind_sig_intersection,:)/2);
er.Color = [0 0 0];
er.LineStyle = 'none';

hold off


hold on;
bar(vec_2,1-H_O+delta_I_O(ind_sig_intersection,:),'FaceColor',[0.5 0.5 0.5],'BarWidth',0.25)
bar(vec_2,1-H_O,'FaceColor',color_vec(2,:),'BarWidth',0.25)

er = errorbar(vec_2,1-H_O+delta_I_O(ind_sig_intersection,:),std_HO(ind_sig_intersection,:)/2,std_HO(ind_sig_intersection,:)/2);
er.Color = [0 0 0];
er.LineStyle = 'none';

hold off
set(gca,'xtick',vec_3,'xticklabel',name_machine);

set(gca,'XTickLabelRotation',-30)

Set_fig_YS(gca,14,14,14)
ylim([0 1]);xlim([0 15])


%% roc plot

% [map,num,typ,scheme] = brewermap(7,'YlGnBu');
% figure(1);hold on
% for cnt_stage = 1:5
%     plot(1-TNR_Y_only(cnt_stage,:),TPR_Y_only(cnt_stage,:),'o'...
%         ,'MarkerEdgeColor',map(cnt_stage+2,:),'MarkerFaceColor',map(cnt_stage+2,:))
%  
% end
% xlim([0 1]);ylim([0 1]);
% Set_fig_YS(gca,18,18,18);box off
% 
% 
% [map,num,typ,scheme] = brewermap(7,'YlOrBr');
% figure(1);hold on
% for cnt_stage = 1:5
%     plot(1-TNR_Y_woTime(cnt_stage,:),TPR_Y_woTime(cnt_stage,:),'sq'...
%         ,'MarkerEdgeColor',map(cnt_stage+2,:),'MarkerFaceColor',map(cnt_stage+2,:))
%  
% end
% xlim([0 1]);ylim([0 1]);
% Set_fig_YS(gca,18,18,18);box off
% 
% 
% [map,num,typ,scheme] = brewermap(7,'YlGn');
% figure(1);hold on
% for cnt_stage = 1:5
%     plot(1-TNR_Y_all(cnt_stage,:),TPR_Y_all(cnt_stage,:),'o'...
%         ,'MarkerEdgeColor',map(cnt_stage+2,:),'MarkerFaceColor',map(cnt_stage+2,:))
%  
% end
% xlim([0 1]);ylim([0 1]);
% Set_fig_YS(gca,18,18,18);box off

% %% spider plots
% clear data
% color_mat = [repmat([0.5 0 0],[N_rep 1]);repmat([0 0 0.5],[N_rep 1])]
% figure(1)
% 
% for cnt_stage = 1:5
%     
%     subplot(1,5,cnt_stage)
%     
%     data(:,1) = [TPR_Y_only(cnt_stage,:)';TPR_Y_all(cnt_stage,:)'];
%     data(:,2) = [TNR_Y_only(cnt_stage,:)';TNR_Y_all(cnt_stage,:)'];
%     data(:,3) = [Acc_Y_only(cnt_stage,:)';Acc_Y_all(cnt_stage,:)'];
%     data(:,4) = [PPV_Y_only(cnt_stage,:)';PPV_Y__all(cnt_stage,:)'];
% 
%     spider_plot(data,'AxesLabels',P_labels,'color',color_mat,'AxesLimits',[0 0 0 0;1 1 1 1],'AxesColor', [0.6, 0.6, 0.6])
% end


%     P_labels = {'TPR','TNR','ACC','PPV'}
% 
%   spider_plot([TPR,TNR,Acc,PPV],'AxesLabels',P_labels, 'AxesLimits',[0 0 0 0;1 1 1 1],'Color', [1, 0, 0],'AxesColor', [0.6, 0.6, 0.6])
%        spider_plot([TPR/2,TNR,Acc,PPV],'AxesLabels',P_labels, 'AxesLimits',[0 0 0 0;1 1 1 1],'Color', [1, 0, 0],'AxesColor', [0.6, 0.6, 0.6])

   

%% classifer results

load('R_100run_NN_Final_latest.mat')

% 
% 
% figure(6)
% hold on;
% vec_1 = [1:6:30];
% vec_2 = [2:6:30];
% vec_3 = [3:6:30];
% vec_4 = [4:6:30];
% 
% bar(vec_1,Y_final_baseline_rcell_eb,'FaceColor',color_vec(1,:),'BarWidth',0.1)
% bar(vec_2,mean_Y_WOT(3,:),'FaceColor',[0.5 0.5 0],'BarWidth',0.1)
% bar(vec_3,mean_Y_OT(3,:),'FaceColor',[0.5 0 0.5],'BarWidth',0.1)
% bar(vec_4,mean_Y_WT(3,:),'FaceColor',[0.5 0.5 0.5],'BarWidth',0.1)
% 
% er = errorbar(vec_2,mean_Y_WOT(3,:),std_Y_WT(3,:)/2,std_Y_WOT(3,:)/2);
% er.Color = [0 0 0];
% er.LineStyle = 'none';
% 
% er = errorbar(vec_3,mean_Y_OT(3,:),std_Y_OT(3,:)/2,std_Y_OT(3,:)/2);
% er.Color = [0 0 0];
% er.LineStyle = 'none';
% 
% er = errorbar(vec_4,mean_Y_WT(3,:),std_Y_WT(3,:)/2,std_Y_WT(3,:)/2);
% er.Color = [0 0 0];
% er.LineStyle = 'none';



% figure(7)
% hold on;
% vec_1 = [1:3:15];
% vec_2 = [2:3:15];
% vec_3 = [1.5:3:15];
% 
% bar(vec_1,mean_Y_WT(3,:),'FaceColor',[0.5 0.5 0.5],'BarWidth',0.25)
% bar(vec_1,mean_Y_WOT(3,:),'FaceColor',color_vec(1,:),'BarWidth',0.25)
% 
% er = errorbar(vec_1,mean_Y_WOT(3,:),std_Y_WT(3,:)/2,std_Y_WOT(3,:)/2);
% er.Color = [0 0 0];
% er.LineStyle = 'none';
% 
% er = errorbar(vec_1,mean_Y_WT(3,:),std_Y_WT(3,:)/2,std_Y_WT(3,:)/2);
% er.Color = [0 0 0];
% er.LineStyle = 'none';
% 
% 
% hold on;
% bar(vec_2,mean_O_WT(3,:),'FaceColor',[0.5 0.5 0.5],'BarWidth',0.25)
% bar(vec_2,mean_O_WOT(3,:),'FaceColor',color_vec(2,:),'BarWidth',0.25)
% 
% er = errorbar(vec_2,mean_O_WOT(3,:),std_O_WOT(3,:)/2,std_O_WOT(3,:)/2);
% er.Color = [0 0 0];
% er.LineStyle = 'none';
% 
% er = errorbar(vec_2,mean_O_WT(3,:),std_O_WT(3,:)/2,std_O_WT(3,:)/2);
% er.Color = [0 0 0];
% er.LineStyle = 'none';
% 
% 
% 
% hold off
% set(gca,'xtick',vec_3,'xticklabel',name_machine);
% 
% set(gca,'XTickLabelRotation',-30)
% 
% Set_fig_YS(gca,14,14,14)
% ylim([0 1]);xlim([0 15])
% 
% 
% set(gca,'xtick',vec_3,'xticklabel',name_machine);
% 
% set(gca,'XTickLabelRotation',-30)
% 
% Set_fig_YS(gca,14,14,14)
% ylim([0.5 1]);xlim([0 15])

figure(8)
hold on
er = errorbar(vec_1,mean_Y_WOT(3,:),std_Y_WT(3,:)/2,std_Y_WOT(3,:)/2);
er.Color = color_vec(1,:);
er.LineStyle='-.';
er.LineWidth = 2;

er = errorbar(vec_1,mean_Y_WT(3,:),std_Y_WT(3,:)/2,std_Y_WT(3,:)/2);
er.Color = color_vec(1,:);
er.LineWidth = 2;

er = errorbar(vec_1,mean_Y_OT(3,:),std_Y_OT(3,:)/2,std_Y_OT(3,:)/2);
er.Color = color_vec(1,:);
er.LineWidth = 2;

er = errorbar(vec_1,mean_O_WOT(3,:),std_O_WOT(3,:)/2,std_O_WOT(3,:)/2);
er.Color = color_vec(2,:);
er.LineStyle='-.';
er.LineWidth = 2;

er = errorbar(vec_1,mean_O_WT(3,:),std_O_WT(3,:)/2,std_O_WT(3,:)/2);
er.Color = color_vec(2,:);
er.LineWidth = 2;


set(gca,'xtick',vec_1,'xticklabel',name_machine(1:end-1));

set(gca,'XTickLabelRotation',-30)

Set_fig_YS(gca,14,14,14)
ylim([0.55 1]);xlim([0 15]);



%%

function H_given_prop = MI(param,param_given_alive,param_given_dead,p_alive)

[f,xi] = ksdensity([param_given_alive;param_given_dead]);
f_given_alive = ksdensity(param_given_alive,xi);
f_given_dead = ksdensity(param_given_dead,xi);

ind_zero = find(f_given_dead*p_alive==0);

if ~isempty(ind_zero)
    f_given_dead(ind_zero)=1e-36;
end


H_given_prop = - (   trapz(xi,  f_given_alive*p_alive   .*( log2(f_given_alive*p_alive)    - log2(f) ))+...
    trapz(xi,  f_given_dead*(1-p_alive).*( log2(f_given_dead*(1-p_alive)) - log2(f) ))       );


end


