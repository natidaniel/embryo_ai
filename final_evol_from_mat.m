% load final classifiers results 
clc;clear;close
%load('final_evol_acc_ensemble_lda_svm.mat')
%load('R_ACC_NN_latest.mat')  %5-6 features
%load('R_NOV_ACC_NN_latest.mat')  %8-9 features without FAR,MR,Pre,Pv
%load('RTIME_ACC_NN_latest.mat')  %only time without FAR,MR,Pre,Pv
load('R_onlyT_100run_NOV_ACC_NN_latest.mat')
load('R_100run_NOV_ACC_NN_latest.mat')
load('baseline_acc.mat')

%% Best model per stage
% ACC - 4 configs
mean_Y_T = zeros(1,5);mean_O_T = zeros(1,5);
std_Y_T = zeros(1,5);std_O_T = zeros(1,5);
mean_Y_OnT = zeros(1,5);mean_O_OnT = zeros(1,5);
std_Y_OnT = zeros(1,5);std_O_OnT = zeros(1,5);
mean_Y_M = zeros(1,5);mean_O_M = zeros(1,5);
std_Y_M = zeros(1,5);std_O_M = zeros(1,5);

% FAR
mean_Y_FT = zeros(1,5);mean_O_FT = zeros(1,5);
std_Y_FT = zeros(1,5);std_O_FT = zeros(1,5);
mean_Y_FOnT = zeros(1,5);mean_O_FOnT = zeros(1,5);
std_Y_FOnT = zeros(1,5);std_O_FOnT = zeros(1,5);
mean_Y_FM = zeros(1,5);mean_O_FM = zeros(1,5);
std_Y_FM = zeros(1,5);std_O_FM = zeros(1,5);
mean_Y_FB = B_F_Y;mean_O_FB = B_F_O;

% MR
mean_Y_MRT = zeros(1,5);mean_O_MRT = zeros(1,5);
std_Y_MRT = zeros(1,5);std_O_MRT = zeros(1,5);
mean_Y_MROnT = zeros(1,5);mean_O_MROnT = zeros(1,5);
std_Y_MROnT = zeros(1,5);std_O_MROnT = zeros(1,5);
mean_Y_MRM = zeros(1,5);mean_O_MRM = zeros(1,5);
std_Y_MRM = zeros(1,5);std_O_MRM = zeros(1,5);
mean_Y_MRB = zeros(1,5);mean_O_MRB = zeros(1,5);
B_MR = zeros(1,5);

% P
mean_Y_PT = zeros(1,5);mean_O_PT = zeros(1,5);
std_Y_PT = zeros(1,5);std_O_PT = zeros(1,5);
mean_Y_POnT = zeros(1,5);mean_O_POnT = zeros(1,5);
std_Y_POnT = zeros(1,5);std_O_POnT = zeros(1,5);
mean_Y_PM = zeros(1,5);mean_O_PM = zeros(1,5);
std_Y_PM = zeros(1,5);std_O_PM = zeros(1,5);
mean_Y_PB = Y_final_baseline_rcell_eb;mean_O_PB = O_final_baseline_rcell_eb;

for i=1:5
    % acc
    % young
    mean_Y_T(1,i) = max(mean_Y_WT(:,i));
    mean_Y_M(1,i) = max(mean_Y_WOT(:,i));
    mean_Y_OnT(1,i) = max(mean_Y_OT(:,i));
    std_Y_T(1,i) = max(std_Y_WT(:,i));
    std_Y_M(1,i) = max(std_Y_WOT(:,i));
    std_Y_OnT(1,i) = max(std_Y_OT(:,i));
    % old
    mean_O_T(1,i) = max(mean_O_WT(:,i));
    mean_O_OnT(1,i) = max(mean_O_OT(:,i));
    mean_O_M(1,i) = max(mean_O_WOT(:,i));
    std_O_T(1,i) = max(std_O_WT(:,i));
    std_O_OnT(1,i) = max(std_O_OT(:,i));
    std_O_M(1,i) = max(std_O_WOT(:,i));
    
    % fall alram rate
    % young
    mean_Y_FT(1,i) = max(mean_Y_FWT(:,i));
    mean_Y_FM(1,i) = max(mean_Y_FWOT(:,i));
    mean_Y_FOnT(1,i) = max(mean_Y_FOT(:,i));
    std_Y_FT(1,i) = max(std_Y_FWT(:,i));
    std_Y_FM(1,i) = max(std_Y_FWOT(:,i));
    std_Y_FOnT(1,i) = max(std_Y_FOT(:,i));
    % old
    mean_O_FT(1,i) = max(mean_O_FWT(:,i));
    mean_O_FOnT(1,i) = max(mean_O_FOT(:,i));
    mean_O_FM(1,i) = max(mean_O_FWOT(:,i));
    std_O_FT(1,i) = max(std_O_FWT(:,i));
    std_O_FOnT(1,i) = max(std_O_FOT(:,i));
    std_O_FM(1,i) = max(std_O_FWOT(:,i));
    
    % miss rate
    % young
    mean_Y_MRT(1,i) = max(mean_Y_MRWT(:,i));
    mean_Y_MRM(1,i) = max(mean_Y_MRWOT(:,i));
    mean_Y_MROnT(1,i) = max(mean_Y_MROT(:,i));
    std_Y_MRT(1,i) = max(std_Y_MRWT(:,i));
    std_Y_MRM(1,i) = max(std_Y_MRWOT(:,i));
    std_Y_MROnT(1,i) = max(std_Y_MROT(:,i));
    % old
    mean_O_MRT(1,i) = max(mean_O_MRWT(:,i));
    mean_O_MROnT(1,i) = max(mean_O_MROT(:,i));
    mean_O_MRM(1,i) = max(mean_O_MRWOT(:,i));
    std_O_MRT(1,i) = max(std_O_MRWT(:,i));
    std_O_MROnT(1,i) = max(std_O_MROT(:,i));
    std_O_MRM(1,i) = max(std_O_MRWOT(:,i));
    
    % prevelance
    % young
    mean_Y_PT(1,i) = max(mean_Y_PWT(:,i));
    mean_Y_PM(1,i) = max(mean_Y_PWOT(:,i));
    mean_Y_POnT(1,i) = max(mean_Y_POT(:,i));
    std_Y_PT(1,i) = max(std_Y_PWT(:,i));
    std_Y_PM(1,i) = max(std_Y_PWOT(:,i));
    std_Y_POnT(1,i) = max(std_Y_POT(:,i));
    % old
    mean_O_PT(1,i) = max(mean_O_PWT(:,i));
    mean_O_POnT(1,i) = max(mean_O_POT(:,i));
    mean_O_PM(1,i) = max(mean_O_PWOT(:,i));
    std_O_PT(1,i) = max(std_O_PWT(:,i));
    std_O_POnT(1,i) = max(std_O_POT(:,i));
    std_O_PM(1,i) = max(std_O_PWOT(:,i));
end

%% Plot the data usrvival curves
color_vec = [0 0.5 0.5;
    0.5 0 0.5;
    0.5 0.25 0;
    0 0.5 0;
    0.5 0 0;
    0 0 0.5];

%% ys format - figure 2
name_2_cell = {'2-cell', '4-cell', '8-cell','Morula','Early Blastocyst'};

hold on;
vec_1 = [1:3:15];
vec_2 = [2:3:15];
vec_3 = [1.5:3:15];

bar(vec_1,mean_Y_T,'FaceColor',[0.5 0.5 0.5],'BarWidth',0.25)
bar(vec_1,mean_Y_OnT,'FaceColor',[0.2 0.6 0.9],'BarWidth',0.25)
bar(vec_1,mean_Y_M,'FaceColor',[0.9 0.5 0.1],'BarWidth',0.25)
bar(vec_1,Y_final_baseline_rcell_eb,'FaceColor',color_vec(1,:),'BarWidth',0.25)
er = errorbar(vec_1,mean_Y_T,std_Y_T/2,std_Y_T/2);    
er.Color = [0 0 0];                            
er.LineStyle = 'none';  
hold off

hold on;
bar(vec_2,mean_O_T,'FaceColor',[0.5 0.5 0.5],'BarWidth',0.25)
bar(vec_2,mean_O_OnT,'FaceColor',[0.2 0.6 0.9],'BarWidth',0.25)
bar(vec_2,mean_O_M,'FaceColor',[0.9 0.5 0.1],'BarWidth',0.25)
bar(vec_2,O_final_baseline_rcell_eb,'FaceColor',color_vec(2,:),'BarWidth',0.25)
er = errorbar(vec_2,mean_O_T,std_O_T/2,std_O_T/2);    
er.Color = [0 0 0];                            
er.LineStyle = 'none';  
hold off

set(gca,'xtick',vec_3,'xticklabel',name_2_cell);
set(gca,'XTickLabelRotation',-30)
Set_fig_YS(gca,14,14,14)
ylim([0 1]);xlim([0 15])

%% nd format - only accuracy

close all

name_2_cell = {'2-cell', '4-cell', '8-cell','Morula','Early Blastocyst'};

vec_1 = [1:5:25];
vec_2 = [2:5:25];
vec_3 = [3:5:25];
vec_4 = [4:5:25];
vec_5 = [2.5:5:25];
subplot(2,1,1);
bar(vec_4,mean_Y_T,'FaceColor',[0.9290 0.6940 0.1250],'BarWidth',0.15)
hold on
bar(vec_3,mean_Y_OnT,'FaceColor',[0.6350 0.0780 0.1840],'BarWidth',0.15)
hold on
bar(vec_2,mean_Y_M,'FaceColor',color_vec(2,:),'BarWidth',0.15)
hold on
bar(vec_1,Y_final_baseline_rcell_eb,'FaceColor',color_vec(1,:),'BarWidth',0.15) 
hold on
er2 = errorbar(vec_2,mean_Y_M,std_Y_M/2,std_Y_M/2);    
er2.Color = [0 0 0];                            
er2.LineStyle = 'none'; 
hold on
std_Y_OnT(1,5) = 0.001; % fix epsilon
er3 = errorbar(vec_3,mean_Y_OnT,std_Y_OnT/2,std_Y_OnT/2);    
er3.Color = [0 0 0];                            
er3.LineStyle = 'none';  
hold on
er4 = errorbar(vec_4,mean_Y_T,std_Y_T/2,std_Y_T/2);    
er4.Color = [0 0 0];                            
er4.LineStyle = 'none';  
hold off
%set(gca,'xtick',vec_5,'xticklabel',name_2_cell);
%set(gca,'XTickLabelRotation',-30)
set(gca,'xtick',[])
Set_fig_YS(gca,14,14,14)
ylim([0.7 1]);xlim([0 25])
yticks(0.7:(1/20):1);
set(gca,'box','off');

subplot(2,1,2);
bar(vec_4,mean_O_T,'FaceColor',[0.9290 0.6940 0.1250],'BarWidth',0.15)
hold on
bar(vec_3,mean_O_OnT,'FaceColor',[0.6350 0.0780 0.1840],'BarWidth',0.15)
hold on
bar(vec_2,mean_O_M,'FaceColor',color_vec(2,:),'BarWidth',0.15)
hold on
bar(vec_1,O_final_baseline_rcell_eb,'FaceColor',color_vec(1,:),'BarWidth',0.15)
hold on
er2 = errorbar(vec_2,mean_O_M,std_O_M/2,std_O_M/2);    
er2.Color = [0 0 0];                            
er2.LineStyle = 'none';  
hold on
er3 = errorbar(vec_3,mean_O_OnT,std_O_OnT/2,std_O_OnT/2);    
er3.Color = [0 0 0];                            
er3.LineStyle = 'none';  
hold on
er4 = errorbar(vec_4,mean_O_T,std_O_T/2,std_O_T/2);    
er4.Color = [0 0 0];                            
er4.LineStyle = 'none';   
hold off
set(gca,'xtick',vec_5,'xticklabel',name_2_cell);
set(gca,'XTickLabelRotation',-30)
Set_fig_YS(gca,14,14,14)
ylim([0.55 1]);xlim([0 25])
yticks(0.55:(1/20):1);
set(gca,'box','off');

%% nd format - far
close all

name_2_cell = {'2-cell', '4-cell', '8-cell','Morula','Early Blastocyst'};

vec_1 = [1:5:25];
vec_2 = [2:5:25];
vec_3 = [3:5:25];
vec_4 = [4:5:25];
vec_5 = [2.5:5:25];
subplot(2,1,1);
bar(vec_4,mean_Y_FT,'FaceColor',[0.9290 0.6940 0.1250],'BarWidth',0.15)
hold on
bar(vec_3,mean_Y_FOnT,'FaceColor',[0.6350 0.0780 0.1840],'BarWidth',0.15)
hold on
bar(vec_2,mean_Y_FM,'FaceColor',color_vec(2,:),'BarWidth',0.15)
hold on
bar(vec_1,B_F_Y,'FaceColor',color_vec(1,:),'BarWidth',0.15) 
hold on
er2 = errorbar(vec_2,mean_Y_FM,std_Y_FM/2,std_Y_FM/2);    
er2.Color = [0 0 0];                            
er2.LineStyle = 'none'; 
hold on
er3 = errorbar(vec_3,mean_Y_FOnT,std_Y_FOnT/2,std_Y_FOnT/2);    
er3.Color = [0 0 0];                            
er3.LineStyle = 'none';  
hold on
er4 = errorbar(vec_4,mean_Y_FT,std_Y_FT/2,std_Y_FT/2);    
er4.Color = [0 0 0];                            
er4.LineStyle = 'none';  
hold off
%set(gca,'xtick',vec_5,'xticklabel',name_2_cell);
%set(gca,'XTickLabelRotation',-30)
set(gca,'xtick',[])
Set_fig_YS(gca,14,14,14)
ylim([0 1]);xlim([0 25])
%yticks(0.7:(1/20):1);
set(gca,'box','off');

subplot(2,1,2);
bar(vec_4,mean_O_FT,'FaceColor',[0.9290 0.6940 0.1250],'BarWidth',0.15)
hold on
mean_O_FOnT(1,5) = 0.001; % fix epsilon
bar(vec_3,mean_O_FOnT,'FaceColor',[0.6350 0.0780 0.1840],'BarWidth',0.15)
hold on
bar(vec_2,mean_O_FM,'FaceColor',color_vec(2,:),'BarWidth',0.15)
hold on
bar(vec_1,B_F_O,'FaceColor',color_vec(1,:),'BarWidth',0.15)
hold on
er2 = errorbar(vec_2,mean_O_FM,std_O_FM/2,std_O_FM/2);    
er2.Color = [0 0 0];                            
er2.LineStyle = 'none';  
hold on
er3 = errorbar(vec_3,mean_O_FOnT,std_O_FOnT/2,std_O_FOnT/2);    
er3.Color = [0 0 0];                            
er3.LineStyle = 'none';  
hold on
er4 = errorbar(vec_4,mean_O_FT,std_O_FT/2,std_O_FT/2);    
er4.Color = [0 0 0];                            
er4.LineStyle = 'none';   
hold off
set(gca,'xtick',vec_5,'xticklabel',name_2_cell);
set(gca,'XTickLabelRotation',-30)
Set_fig_YS(gca,14,14,14)
ylim([0 1]);xlim([0 25])
%yticks(0.55:(1/20):1);
set(gca,'box','off');

%% nd format - MR
close all

name_2_cell = {'2-cell', '4-cell', '8-cell','Morula','Early Blastocyst'};

vec_1 = [1:5:25];
vec_2 = [2:5:25];
vec_3 = [3:5:25];
vec_4 = [4:5:25];
vec_5 = [2.5:5:25];
subplot(2,1,1);
bar(vec_4,mean_Y_MRT,'FaceColor',[0.9290 0.6940 0.1250],'BarWidth',0.15)
hold on
bar(vec_3,mean_Y_MROnT,'FaceColor',[0.6350 0.0780 0.1840],'BarWidth',0.15)
hold on
bar(vec_2,mean_Y_MRM,'FaceColor',color_vec(2,:),'BarWidth',0.15)
hold on
bar(vec_1,B_MR,'FaceColor',color_vec(1,:),'BarWidth',0.15) 
hold on
er2 = errorbar(vec_2,mean_Y_MRM,std_Y_MRM/2,std_Y_MRM/2);    
er2.Color = [0 0 0];                            
er2.LineStyle = 'none'; 
hold on
er3 = errorbar(vec_3,mean_Y_MROnT,std_Y_MROnT/2,std_Y_MROnT/2);    
er3.Color = [0 0 0];                            
er3.LineStyle = 'none';  
hold on
er4 = errorbar(vec_4,mean_Y_MRT,std_Y_MRT/2,std_Y_MRT/2);    
er4.Color = [0 0 0];                            
er4.LineStyle = 'none';  
hold off
%set(gca,'xtick',vec_5,'xticklabel',name_2_cell);
%set(gca,'XTickLabelRotation',-30)
set(gca,'xtick',[])
Set_fig_YS(gca,14,14,14)
ylim([0 1]);xlim([0 25])
%yticks(0.7:(1/20):1);
set(gca,'box','off');

subplot(2,1,2);
bar(vec_4,mean_O_MRT,'FaceColor',[0.9290 0.6940 0.1250],'BarWidth',0.15)
hold on
bar(vec_3,mean_O_MROnT,'FaceColor',[0.6350 0.0780 0.1840],'BarWidth',0.15)
hold on
bar(vec_2,mean_O_MRM,'FaceColor',color_vec(2,:),'BarWidth',0.15)
hold on
bar(vec_1,B_MR,'FaceColor',color_vec(1,:),'BarWidth',0.15)
hold on
er2 = errorbar(vec_2,mean_O_MRM,std_O_MRM/2,std_O_MRM/2);    
er2.Color = [0 0 0];                            
er2.LineStyle = 'none';  
hold on
er3 = errorbar(vec_3,mean_O_MROnT,std_O_MROnT/2,std_O_MROnT/2);    
er3.Color = [0 0 0];                            
er3.LineStyle = 'none';  
hold on
er4 = errorbar(vec_4,mean_O_MRT,std_O_MRT/2,std_O_MRT/2);    
er4.Color = [0 0 0];                            
er4.LineStyle = 'none';   
hold off
set(gca,'xtick',vec_5,'xticklabel',name_2_cell);
set(gca,'XTickLabelRotation',-30)
Set_fig_YS(gca,14,14,14)
ylim([0 1]);xlim([0 25])
%yticks(0.55:(1/20):1);
set(gca,'box','off');

%% nd format - prev
close all

name_2_cell = {'2-cell', '4-cell', '8-cell','Morula','Early Blastocyst'};

vec_1 = [1:5:25];
vec_2 = [2:5:25];
vec_3 = [3:5:25];
vec_4 = [4:5:25];
vec_5 = [2.5:5:25];
subplot(2,1,1);
bar(vec_4,mean_Y_PT,'FaceColor',[0.9290 0.6940 0.1250],'BarWidth',0.15)
hold on
bar(vec_3,mean_Y_POnT,'FaceColor',[0.6350 0.0780 0.1840],'BarWidth',0.15)
hold on
bar(vec_2,mean_Y_PM,'FaceColor',color_vec(2,:),'BarWidth',0.15)
hold on
bar(vec_1,B_P_Y,'FaceColor',color_vec(1,:),'BarWidth',0.15) 
hold on
er2 = errorbar(vec_2,mean_Y_PM,std_Y_PM/2,std_Y_PM/2);    
er2.Color = [0 0 0];                            
er2.LineStyle = 'none'; 
hold on
er3 = errorbar(vec_3,mean_Y_POnT,std_Y_POnT/2,std_Y_POnT/2);    
er3.Color = [0 0 0];                            
er3.LineStyle = 'none';  
hold on
er4 = errorbar(vec_4,mean_Y_PT,std_Y_PT/2,std_Y_PT/2);    
er4.Color = [0 0 0];                            
er4.LineStyle = 'none';  
hold off
%set(gca,'xtick',vec_5,'xticklabel',name_2_cell);
%set(gca,'XTickLabelRotation',-30)
set(gca,'xtick',[])
Set_fig_YS(gca,14,14,14)
ylim([0 1]);xlim([0 25])
%yticks(0.7:(1/20):1);
set(gca,'box','off');

subplot(2,1,2);
bar(vec_4,mean_O_PT,'FaceColor',[0.9290 0.6940 0.1250],'BarWidth',0.15)
hold on
bar(vec_3,mean_O_POnT,'FaceColor',[0.6350 0.0780 0.1840],'BarWidth',0.15)
hold on
bar(vec_2,mean_O_PM,'FaceColor',color_vec(2,:),'BarWidth',0.15)
hold on
bar(vec_1,B_P_O,'FaceColor',color_vec(1,:),'BarWidth',0.15)
hold on
er2 = errorbar(vec_2,mean_O_PM,std_O_PM/2,std_O_PM/2);    
er2.Color = [0 0 0];                            
er2.LineStyle = 'none';  
hold on
er3 = errorbar(vec_3,mean_O_POnT,std_O_POnT/2,std_O_POnT/2);    
er3.Color = [0 0 0];                            
er3.LineStyle = 'none';  
hold on
er4 = errorbar(vec_4,mean_O_PT,std_O_PT/2,std_O_PT/2);    
er4.Color = [0 0 0];                            
er4.LineStyle = 'none';   
hold off
set(gca,'xtick',vec_5,'xticklabel',name_2_cell);
set(gca,'XTickLabelRotation',-30)
Set_fig_YS(gca,14,14,14)
ylim([0 1]);xlim([0 25])
%yticks(0.55:(1/20):1);
set(gca,'box','off');

%% save figures automaticaly
saveFigs('ModelsValidation_res');

