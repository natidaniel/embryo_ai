% mean and std of 10 runs of validation accuracy 
% Ensemble, LD, and SVM
% Young and Old

clear;close all;clc

From2Cell = 'TRUE';
Ntimes = 100;
%variableN = string('R_100run_NOV_ACC_NN');
variableN = string('R_onlyT_100run_NOV_ACC_NN'); % only time

NYPS = [62,62,62,61,57]; %2-cell to EB
CYPS = [62,124,186,247,304];
NOPS = [41,41,39,39,33]; %2-cell to EB
COPS = [41,82,121,160,193];

% B-model
B_ACC_Y = [0.7419,0.7419,0.7419,0.7541,0.8070]; %2-cell to EB
B_ACC_O = [0.6585,0.6585,0.6923,0.6923,0.8182]; %2-cell to EB

%% loop reduced
for i=1:Ntimes
    load(variableN+num2str(i)+string(".mat"))
    
    % p-value analysis
    SVM_Y_WT_R_Validation_Pvalue = zeros(1,5); SVM_O_WT_R_Validation_Pvalue = zeros(1,5);
    SVM_Y_WOT_R_Validation_Pvalue = zeros(1,5); SVM_O_WOT_R_Validation_Pvalue = zeros(1,5);
    Ensemble_Y_WT_R_Validation_Pvalue = zeros(1,5); Ensemble_O_WT_R_Validation_Pvalue = zeros(1,5);
    Ensemble_Y_WOT_R_Validation_Pvalue = zeros(1,5); Ensemble_O_WOT_R_Validation_Pvalue = zeros(1,5);
    LD_Y_WT_R_Validation_Pvalue = zeros(1,5); LD_O_WT_R_Validation_Pvalue = zeros(1,5);
    LD_Y_WOT_R_Validation_Pvalue = zeros(1,5); LD_O_WOT_R_Validation_Pvalue = zeros(1,5);
    
    % Ensemble
    N_round = 10^4; % number of trilas
    NY_smaple = 57;
    NO_smaple = 33;
    for ii=1:5  %go over all stages
        % create start P_GT indeces
        if ii==1
            sy = 1;
            so = 1;
        else
            sy = (CYPS(ii)-CYPS(ii-1)+1);
            so = (COPS(ii)-COPS(ii-1)+1);
        end
        
        % Run a bootstrap loop and p-value
        [~,~, ~, acc_bo] = bootstrap_nd(N_round,NY_smaple,SVM_Y_WT_R_Validation_GT(sy:CYPS(ii)),SVM_Y_WT_R_Validation_Pr(sy:CYPS(ii)));
        [p_value_bo] = find_p_value(SVM_Y_WT_R_Validation_ACC(ii), acc_bo);
        SVM_Y_WT_R_Validation_Pvalue(ii) = p_value_bo;
        
        [~,~, ~, acc_bo] = bootstrap_nd(N_round,NY_smaple,SVM_Y_WOT_R_Validation_GT(sy:CYPS(ii)),SVM_Y_WOT_R_Validation_Pr(sy:CYPS(ii)));
        [p_value_bo] = find_p_value(SVM_Y_WOT_R_Validation_ACC(ii), acc_bo);
        SVM_Y_WOT_R_Validation_Pvalue(ii) = p_value_bo;
        
        [~,~, ~, acc_bo] = bootstrap_nd(N_round,NO_smaple,SVM_O_WT_R_Validation_GT(so:COPS(ii)),SVM_O_WT_R_Validation_Pr(so:COPS(ii)));
        [p_value_bo] = find_p_value(SVM_O_WT_R_Validation_ACC(ii), acc_bo);
        SVM_O_WT_R_Validation_Pvalue(ii)= p_value_bo;
        
        [~,~, ~, acc_bo] = bootstrap_nd(N_round,NO_smaple,SVM_O_WOT_R_Validation_GT(so:COPS(ii)),SVM_O_WOT_R_Validation_Pr(so:COPS(ii)));
        [p_value_bo] = find_p_value(SVM_O_WOT_R_Validation_ACC(ii), acc_bo);
        SVM_O_WOT_R_Validation_Pvalue(ii) = p_value_bo;
        
        [~,~, ~, acc_bo] = bootstrap_nd(N_round,NY_smaple,Ensemble_Y_WT_R_Validation_GT(sy:CYPS(ii)),Ensemble_Y_WT_R_Validation_Pr(sy:CYPS(ii)));
        [p_value_bo] = find_p_value(Ensemble_Y_WT_R_Validation_ACC(ii), acc_bo);
        Ensemble_Y_WT_R_Validation_Pvalue(ii) = p_value_bo;
        
        [~,~, ~, acc_bo] = bootstrap_nd(N_round,NY_smaple,Ensemble_Y_WOT_R_Validation_GT(sy:CYPS(ii)),Ensemble_Y_WOT_R_Validation_Pr(sy:CYPS(ii)));
        [p_value_bo] = find_p_value(Ensemble_Y_WOT_R_Validation_ACC(ii), acc_bo);
        Ensemble_Y_WOT_R_Validation_Pvalue(ii) = p_value_bo;
        
        [~,~, ~, acc_bo] = bootstrap_nd(N_round,NO_smaple,Ensemble_O_WT_R_Validation_GT(so:COPS(ii)),Ensemble_O_WT_R_Validation_Pr(so:COPS(ii)));
        [p_value_bo] = find_p_value(Ensemble_O_WT_R_Validation_ACC(ii), acc_bo);
        Ensemble_O_WT_R_Validation_Pvalue(ii) = p_value_bo;  
        
        [~,~, ~, acc_bo] = bootstrap_nd(N_round,NO_smaple,Ensemble_O_WOT_R_Validation_GT(so:COPS(ii)),Ensemble_O_WOT_R_Validation_Pr(so:COPS(ii)));
        [p_value_bo] = find_p_value(Ensemble_O_WOT_R_Validation_ACC(ii), acc_bo);
        Ensemble_O_WOT_R_Validation_Pvalue(ii) = p_value_bo;
        
        [~,~, ~, acc_bo] = bootstrap_nd(N_round,NY_smaple,LD_Y_WT_R_Validation_GT(sy:CYPS(ii)),LD_Y_WT_R_Validation_Pr(sy:CYPS(ii)));
        [p_value_bo] = find_p_value(LD_Y_WT_R_Validation_ACC(ii), acc_bo);
        LD_Y_WT_R_Validation_Pvalue(ii) = p_value_bo;
        
        [~,~, ~, acc_bo] = bootstrap_nd(N_round,NY_smaple,LD_Y_WOT_R_Validation_GT(sy:CYPS(ii)),LD_Y_WOT_R_Validation_Pr(sy:CYPS(ii)));
        [p_value_bo] = find_p_value(LD_Y_WOT_R_Validation_ACC(ii), acc_bo);
        LD_Y_WOT_R_Validation_Pvalue(ii) = p_value_bo;
        
        [~,~, ~, acc_bo] = bootstrap_nd(N_round,NO_smaple,LD_O_WT_R_Validation_GT(so:COPS(ii)),LD_O_WT_R_Validation_Pr(so:COPS(ii)));
        [p_value_bo] = find_p_value(LD_O_WT_R_Validation_ACC(ii), acc_bo);
        LD_O_WT_R_Validation_Pvalue(ii) = p_value_bo;
        
        [~,~, ~, acc_bo] = bootstrap_nd(N_round,NO_smaple,LD_O_WOT_R_Validation_GT(so:COPS(ii)),LD_O_WOT_R_Validation_Pr(so:COPS(ii)));
        [p_value_bo] = find_p_value(LD_O_WOT_R_Validation_ACC(ii), acc_bo);
        LD_O_WOT_R_Validation_Pvalue(ii) = p_value_bo;
    end
    
    % Old
    OWOT = [Ensemble_O_WOT_R_Validation_ACC;
        LD_O_WOT_R_Validation_ACC;
        SVM_O_WOT_R_Validation_ACC];
    T_O_WOT(:,:,i) = OWOT;
    
    OWT = [Ensemble_O_WT_R_Validation_ACC;
        LD_O_WT_R_Validation_ACC;
        SVM_O_WT_R_Validation_ACC];
    T_O_WT(:,:,i) = OWT;
    
    FOWOT = [Ensemble_O_WOT_R_Validation_FAR;
        LD_O_WOT_R_Validation_FAR;
        SVM_O_WOT_R_Validation_FAR];
    F_O_WOT(:,:,i) = FOWOT;
    
    FOWT = [Ensemble_O_WT_R_Validation_FAR;
        LD_O_WT_R_Validation_FAR;
        SVM_O_WT_R_Validation_FAR];
    F_O_WT(:,:,i) = FOWT;
    
    MROWOT = [Ensemble_O_WOT_R_Validation_MR;
        LD_O_WOT_R_Validation_MR;
        SVM_O_WOT_R_Validation_MR];
    MR_O_WOT(:,:,i) = MROWOT;
    
    MROWT = [Ensemble_O_WT_R_Validation_MR;
        LD_O_WT_R_Validation_MR;
        SVM_O_WT_R_Validation_MR];
    MR_O_WT(:,:,i) = MROWT;
    
    POWOT = [Ensemble_O_WOT_R_Validation_P;
        LD_O_WOT_R_Validation_P;
        SVM_O_WOT_R_Validation_P];
    P_O_WOT(:,:,i) = POWOT;
    
    POWT = [Ensemble_O_WT_R_Validation_P;
        LD_O_WT_R_Validation_P;
        SVM_O_WT_R_Validation_P];
    P_O_WT(:,:,i) = POWT;
    
    PvOWOT = [Ensemble_O_WOT_R_Validation_Pvalue;
        LD_O_WOT_R_Validation_Pvalue;
        SVM_O_WOT_R_Validation_Pvalue];
    Pv_O_WOT(:,:,i) = PvOWOT;
    
    PvOWT = [Ensemble_O_WT_R_Validation_Pvalue;
        LD_O_WT_R_Validation_Pvalue;
        SVM_O_WT_R_Validation_Pvalue];
    Pv_O_WT(:,:,i) = PvOWT;
    
    % Young
    YWOT = [Ensemble_Y_WOT_R_Validation_ACC;
        LD_Y_WOT_R_Validation_ACC;
        SVM_Y_WOT_R_Validation_ACC];
    T_Y_WOT(:,:,i) = YWOT;
        
    YWT = [Ensemble_Y_WT_R_Validation_ACC;
        LD_Y_WT_R_Validation_ACC;
        SVM_Y_WT_R_Validation_ACC];
    T_Y_WT(:,:,i) = YWT;
    
    FYWOT = [Ensemble_Y_WOT_R_Validation_FAR;
        LD_Y_WOT_R_Validation_FAR;
        SVM_Y_WOT_R_Validation_FAR];
    F_Y_WOT(:,:,i) = FYWOT;
        
    FYWT = [Ensemble_Y_WT_R_Validation_FAR;
        LD_Y_WT_R_Validation_FAR;
        SVM_Y_WT_R_Validation_FAR];
    F_Y_WT(:,:,i) = FYWT;
    
    MRYWOT = [Ensemble_Y_WOT_R_Validation_MR;
        LD_Y_WOT_R_Validation_MR;
        SVM_Y_WOT_R_Validation_MR];
    MR_Y_WOT(:,:,i) = MRYWOT;
        
    MRYWT = [Ensemble_Y_WT_R_Validation_MR;
        LD_Y_WT_R_Validation_MR;
        SVM_Y_WT_R_Validation_MR];
    MR_Y_WT(:,:,i) = MRYWT;
    
    PYWOT = [Ensemble_Y_WOT_R_Validation_P;
        LD_Y_WOT_R_Validation_P;
        SVM_Y_WOT_R_Validation_P];
    P_Y_WOT(:,:,i) = PYWOT;
        
    PYWT = [Ensemble_Y_WT_R_Validation_P;
        LD_Y_WT_R_Validation_P;
        SVM_Y_WT_R_Validation_P];
    P_Y_WT(:,:,i) = PYWT;
    
    PvYWOT = [Ensemble_Y_WOT_R_Validation_Pvalue;
        LD_Y_WOT_R_Validation_Pvalue;
        SVM_Y_WOT_R_Validation_Pvalue];
    Pv_Y_WOT(:,:,i) = PvYWOT;
        
    PvYWT = [Ensemble_Y_WT_R_Validation_Pvalue;
        LD_Y_WT_R_Validation_Pvalue;
        SVM_Y_WT_R_Validation_Pvalue];
    Pv_Y_WT(:,:,i) = PvYWT;
end

%% mean and std in 3 dim
% young
% ACC
mean_Y_WOT = mean(T_Y_WOT, 3);
std_Y_WOT = std(T_Y_WOT,[],3);
mean_Y_WT = mean(T_Y_WT, 3);
std_Y_WT = std(T_Y_WT,[],3);
% FAR
mean_Y_FWOT = mean(F_Y_WOT, 3);
std_Y_FWOT = std(F_Y_WOT,[],3);
mean_Y_FWT = mean(F_Y_WT, 3);
std_Y_FWT = std(F_Y_WT,[],3);
% MR
mean_Y_MRWOT = mean(MR_Y_WOT, 3);
std_Y_MRWOT = std(MR_Y_WOT,[],3);
mean_Y_MRWT = mean(MR_Y_WT, 3);
std_Y_MRWT = std(MR_Y_WT,[],3);
% Prev
mean_Y_PWOT = mean(P_Y_WOT, 3);
std_Y_PWOT = std(P_Y_WOT,[],3);
mean_Y_PWT = mean(P_Y_WT, 3);
std_Y_PWT = std(P_Y_WT,[],3);
% Pvalue
m_Y_PvWOT = max(Pv_Y_WOT, [], 3);
m_Y_PvWOT = 1 - m_Y_PvWOT; model_Y_PvWOT = min(m_Y_PvWOT(:));
m_Y_PvWT = max(Pv_Y_WT, [], 3);
m_Y_PvWT = 1 - m_Y_PvWT; model_Y_PvWT = min(m_Y_PvWT(:));

% old
% ACC
mean_O_WOT = mean(T_O_WOT, 3);
std_O_WOT = std(T_O_WOT,[],3);
mean_O_WT = mean(T_O_WT, 3);
std_O_WT = std(T_O_WT,[],3);
% FAR
mean_O_FWOT = mean(F_O_WOT, 3);
std_O_FWOT = std(F_O_WOT,[],3);
mean_O_FWT = mean(F_O_WT, 3);
std_O_FWT = std(F_O_WT,[],3);
% MR
mean_O_MRWOT = mean(MR_O_WOT, 3);
std_O_MRWOT = std(MR_O_WOT,[],3);
mean_O_MRWT = mean(MR_O_WT, 3);
std_O_MRWT = std(MR_O_WT,[],3);
% Prev
mean_O_PWOT = mean(P_O_WOT, 3);
std_O_PWOT = std(P_O_WOT,[],3);
mean_O_PWT = mean(P_O_WT, 3);
std_O_PWT = std(P_O_WT,[],3);
% Pvalue
m_O_PvWOT = max(Pv_O_WOT, [], 3);
m_O_PvWOT = 1 - m_O_PvWOT; model_O_PvWOT = min(m_O_PvWOT(:));
m_O_PvWT = max(Pv_O_WT, [], 3);
m_O_PvWT = 1 - m_O_PvWT; model_O_PvWT = min(m_O_PvWT(:));

%% save all
save(variableN+string('_latest')+'.mat','mean_Y_WOT',...
    'std_Y_WOT','mean_Y_WT','std_Y_WT','mean_O_WOT',...
    'std_O_WOT','mean_O_WT','std_O_WT','mean_Y_FWOT',...
    'std_Y_FWOT','mean_Y_FWT','std_Y_FWT','mean_O_FWOT',...
    'std_O_FWOT','mean_O_FWT','std_O_FWT','mean_Y_MRWOT',...
    'std_Y_MRWOT','mean_Y_MRWT','std_Y_MRWT','mean_O_MRWOT',...
    'std_O_MRWOT','mean_O_MRWT','std_O_MRWT','mean_Y_PWOT',...
    'std_Y_PWOT','mean_Y_PWT','std_Y_PWT','mean_O_PWOT',...
    'std_O_PWOT','mean_O_PWT','std_O_PWT','model_Y_PvWOT',...
    'model_Y_PvWT','model_O_PvWOT','model_O_PvWT');

%% plots
if strcmp(From2Cell,'FALSE')
    name_2_cell = {'1-cell', '2-cell', '4-cell', '8-cell','Morula','Early Blastocyst'};
    xt = [0:5];
else
    name_2_cell = {'2-cell', '4-cell', '8-cell','Morula','Early Blastocyst'};
    xt = [0:4];
end

figure(1);
ax1 = errorbar(xt,mean_O_WOT(1,:),std_O_WOT(1,:))
ax1.Color = 'b';
hold on
ax2 = errorbar(xt,mean_O_WT(1,:),std_O_WT(1,:))
ax2.Color = 'r';
ylim([0 1])
ylabel('Normalized accuracy (Ensemble model) ')
xlabel('Old embryo stage')
legend({'w/o time information','w/ time information'},'location','best');
title('Late blastocyst prediction')
Set_fig_YS(gca,8,10,8)
set(gca,'xtick',xt,'xticklabel',name_2_cell)
set(gca,'XTickLabelRotation',-30)

figure(2);
ax1 = errorbar(xt,mean_O_WOT(2,:),std_O_WOT(2,:))
ax1.Color = 'b';
hold on
ax2 = errorbar(xt,mean_O_WT(2,:),std_O_WT(2,:))
ax2.Color = 'r';
ylim([0 1])
ylabel('Normalized accuracy (LD model) ')
xlabel('Old embryo stage')
legend({'w/o time information','w/ time information'},'location','best');
title('Late blastocyst prediction')
Set_fig_YS(gca,8,10,8)
set(gca,'xtick',xt,'xticklabel',name_2_cell)
set(gca,'XTickLabelRotation',-30)

figure(3);
ax1 = errorbar(xt,mean_O_WOT(3,:),std_O_WOT(3,:))
ax1.Color = 'b';
hold on
ax2 = errorbar(xt,mean_O_WT(3,:),std_O_WT(3,:))
ax2.Color = 'r';
ylim([0 1])
ylabel('Normalized accuracy (SVM model) ')
xlabel('Old embryo stage')
legend({'w/o time information','w/ time information'},'location','best');
title('Late blastocyst prediction')
Set_fig_YS(gca,8,10,8)
set(gca,'xtick',xt,'xticklabel',name_2_cell)
set(gca,'XTickLabelRotation',-30)

figure(4);
ax1 = errorbar(xt,mean_Y_WOT(1,:),std_Y_WOT(1,:))
ax1.Color = 'b';
hold on
ax2 = errorbar(xt,mean_Y_WT(1,:),std_Y_WT(1,:))
ax2.Color = 'r';
ylim([0 1])
ylabel('Normalized accuracy (Ensemble model) ')
xlabel('Young embryo stage')
legend({'w/o time information','w/ time information'},'location','best');
title('Late blastocyst prediction')
Set_fig_YS(gca,8,10,8)
set(gca,'xtick',xt,'xticklabel',name_2_cell)
set(gca,'XTickLabelRotation',-30)

figure(5);
ax1 = errorbar(xt,mean_Y_WOT(2,:),std_Y_WOT(2,:))
ax1.Color = 'b';
hold on
ax2 = errorbar(xt,mean_Y_WT(2,:),std_Y_WT(2,:))
ax2.Color = 'r';
ylim([0 1])
ylabel('Normalized accuracy (LD model) ')
xlabel('Young embryo stage')
legend({'w/o time information','w/ time information'},'location','best');
title('Late blastocyst prediction')
Set_fig_YS(gca,8,10,8)
set(gca,'xtick',xt,'xticklabel',name_2_cell)
set(gca,'XTickLabelRotation',-30)

figure(6);
ax1 = errorbar(xt,mean_Y_WOT(3,:),std_Y_WOT(3,:))
ax1.Color = 'b';
hold on
ax2 = errorbar(xt,mean_Y_WT(3,:),std_Y_WT(3,:))
ax2.Color = 'r';
ylim([0 1])
ylabel('Normalized accuracy (SVM model) ')
xlabel('Young embryo stage')
legend({'w/o time information','w/ time information'},'location','best');
title('Late blastocyst prediction')
Set_fig_YS(gca,8,10,8)
set(gca,'xtick',xt,'xticklabel',name_2_cell)
set(gca,'XTickLabelRotation',-30)

saveFigs('ModelsValidation_res');


%% 
clear;close all;clc

%% loop - all 46
for i=1:10
    load(string('ALL_ACC')+num2str(i)+string(".mat"))
    % Old
    OWOT = [Ensemble_O_WOT_Validation_ACC;
        SVM_O_WOT_Validation_ACC];
    T_O_WOT(:,:,i) = OWOT;
    
    OWT = [Ensemble_O_WT_Validation_ACC;
        SVM_O_WT_Validation_ACC];
    T_O_WT(:,:,i) = OWT;
    
    % Young
    YWOT = [Ensemble_Y_WOT_Validation_ACC;
        SVM_Y_WOT_Validation_ACC];
    T_Y_WOT(:,:,i) = YWOT;
        
    YWT = [Ensemble_Y_WT_Validation_ACC;
        SVM_Y_WT_Validation_ACC];
    T_Y_WT(:,:,i) = YWT;
end

%% mean and std in 2 dim
% young
mean_Y_WOT = mean(T_Y_WOT, 3);
std_Y_WOT = std(T_Y_WOT,[],3);
mean_Y_WT = mean(T_Y_WT, 3);
std_Y_WT = std(T_Y_WT,[],3);
% old
mean_O_WOT = mean(T_O_WOT, 3);
std_O_WOT = std(T_O_WOT,[],3);
mean_O_WT = mean(T_O_WT, 3);
std_O_WT = std(T_O_WT,[],3);

%% plots
name_2_cell = {'1-cell', '2-cell', '4-cell', '8-cell','Morula','Early Blastocyst'};
xt = [0:5];
figure(1);
ax1 = errorbar(xt,mean_O_WOT(1,:),std_O_WOT(1,:))
ax1.Color = 'b';
hold on
ax2 = errorbar(xt,mean_O_WT(1,:),std_O_WT(1,:))
ax2.Color = 'r';
ylim([0 1])
ylabel('Normalized accuracy (Ensemble model) ')
xlabel('Old embryo stage')
legend({'w/o time information','w/ time information'},'location','best');
title('Late blastocyst prediction')
Set_fig_YS(gca,8,10,8)
set(gca,'xtick',xt,'xticklabel',name_2_cell)
set(gca,'XTickLabelRotation',-30)

figure(2);
ax1 = errorbar(xt,mean_O_WOT(2,:),std_O_WOT(2,:))
ax1.Color = 'b';
hold on
ax2 = errorbar(xt,mean_O_WT(2,:),std_O_WT(2,:))
ax2.Color = 'r';
ylim([0 1])
ylabel('Normalized accuracy (SVM model) ')
xlabel('Old embryo stage')
legend({'w/o time information','w/ time information'},'location','best');
title('Late blastocyst prediction')
Set_fig_YS(gca,8,10,8)
set(gca,'xtick',xt,'xticklabel',name_2_cell)
set(gca,'XTickLabelRotation',-30)

figure(3);
ax1 = errorbar(xt,mean_Y_WOT(1,:),std_Y_WOT(1,:))
ax1.Color = 'b';
hold on
ax2 = errorbar(xt,mean_Y_WT(1,:),std_Y_WT(1,:))
ax2.Color = 'r';
ylim([0 1])
ylabel('Normalized accuracy (Ensemble model) ')
xlabel('Young embryo stage')
legend({'w/o time information','w/ time information'},'location','best');
title('Late blastocyst prediction')
Set_fig_YS(gca,8,10,8)
set(gca,'xtick',xt,'xticklabel',name_2_cell)
set(gca,'XTickLabelRotation',-30)

figure(4);
ax1 = errorbar(xt,mean_Y_WOT(2,:),std_Y_WOT(2,:))
ax1.Color = 'b';
hold on
ax2 = errorbar(xt,mean_Y_WT(2,:),std_Y_WT(2,:))
ax2.Color = 'r';
ylim([0 1])
ylabel('Normalized accuracy (SVM model) ')
xlabel('Young embryo stage')
legend({'w/o time information','w/ time information'},'location','best');
title('Late blastocyst prediction')
Set_fig_YS(gca,8,10,8)
set(gca,'xtick',xt,'xticklabel',name_2_cell)
set(gca,'XTickLabelRotation',-30)

saveFigs('ModelsValidation_res');