%% GLCM EoE for classic classification learners

clear
close all 
clc

%% Data configuration
isOrg_1000 = "FALSE";
isOrg_224 = "FALSE";
is448_224 = "FALSE";
is224_224 = "TRUE";

%% Load data
if strcmp(isOrg_1000,'TRUE')
    EoEstats_1_training = load('C:\Nati\EoE\paper1\paper_data_for_nati\data\GLCM\EoEstats_1_training_org_1000.mat');
    EoEstats_0_training = load('C:\Nati\EoE\paper1\paper_data_for_nati\data\GLCM\EoEstats_0_training_org_1000.mat');
    EoEstats_1_validation = load('C:\Nati\EoE\paper1\paper_data_for_nati\data\GLCM\EoEstats_1_validation_org_1000.mat');
    EoEstats_0_validation = load('C:\Nati\EoE\paper1\paper_data_for_nati\data\GLCM\EoEstats_0_validation_org_1000.mat');
end

if strcmp(isOrg_224,'TRUE')
    EoEstats_1_training = load('C:\Nati\EoE\paper1\paper_data_for_nati\data\GLCM\EoEstats_1_training_org_224.mat');
    EoEstats_0_training = load('C:\Nati\EoE\paper1\paper_data_for_nati\data\GLCM\EoEstats_0_training_org_224.mat');
    EoEstats_1_validation = load('C:\Nati\EoE\paper1\paper_data_for_nati\data\GLCM\EoEstats_1_validation_org_224.mat');
    EoEstats_0_validation = load('C:\Nati\EoE\paper1\paper_data_for_nati\data\GLCM\EoEstats_0_validation_org_224.mat');
end

if strcmp(is448_224,'TRUE')
    EoEstats_1_training = load('C:\Nati\EoE\paper1\paper_data_for_nati\data\GLCM\EoEstats_1_training_448_224.mat');
    EoEstats_0_training = load('C:\Nati\EoE\paper1\paper_data_for_nati\data\GLCM\EoEstats_0_training_448_224.mat');
    EoEstats_1_validation = load('C:\Nati\EoE\paper1\paper_data_for_nati\data\GLCM\EoEstats_1_validation_448_224.mat');
    EoEstats_0_validation = load('C:\Nati\EoE\paper1\paper_data_for_nati\data\GLCM\EoEstats_0_validation_448_224.mat');
end

if strcmp(is224_224,'TRUE')
    EoEstats_1_training = load('C:\Nati\EoE\paper1\paper_data_for_nati\data\GLCM\EoEstats_1_training_224_224.mat');
    EoEstats_0_training = load('C:\Nati\EoE\paper1\paper_data_for_nati\data\GLCM\EoEstats_0_training_224_224.mat');
    EoEstats_1_validation = load('C:\Nati\EoE\paper1\paper_data_for_nati\data\GLCM\EoEstats_1_validation_224_224.mat');
    EoEstats_0_validation = load('C:\Nati\EoE\paper1\paper_data_for_nati\data\GLCM\EoEstats_0_validation_224_224.mat');
end

%% Concat training and validation seperatly

EoEstats_training = [EoEstats_0_training.EoEstats; EoEstats_1_training.EoEstats];
EoEstats_validation = [EoEstats_0_validation.EoEstats; EoEstats_1_validation.EoEstats];

%% Run Offline Training on 4 methods and Save 3 classification Models

%% Run Prediction
if strcmp(isOrg_1000,'TRUE')
    load('C:\Nati\EoE\paper1\paper_data_for_nati\data\GLCM\models\org_1000\train_models.mat');
end

if strcmp(isOrg_224,'TRUE')
    load('C:\Nati\EoE\paper1\paper_data_for_nati\data\GLCM\models\org_224\train_models.mat');
end

if strcmp(is448_224,'TRUE')
    load('C:\Nati\EoE\paper1\paper_data_for_nati\data\GLCM\models\448_224\train_models.mat');
end

if strcmp(is224_224,'TRUE')
    load('C:\Nati\EoE\paper1\paper_data_for_nati\data\GLCM\models\224_224\train_models.mat'); 
end

trained_classifier_LD = LD_trainedModel;
trained_classifier_LR = LR_trainedModel;
trained_classifier_SVM = SVM_trainedModel;

%% LD
pEoEstats_validation = [];
for i=1:length(EoEstats_validation)
    pEoEstats_validation = [pEoEstats_validation, trained_classifier_LD.predictFcn(EoEstats_validation(i,1:20))];
end
pEoEstats_validation = pEoEstats_validation';
P_GT = [pEoEstats_validation, EoEstats_validation(:,21)];
P_GT_diff = P_GT(:,1)-P_GT(:,2);
P_GT = [P_GT , P_GT_diff];
P_GT(:,3) = abs(P_GT(:,3));


% Run a bootstrap loop
N_round = 10^4; % number of trilas
N_smaple = round(length(P_GT(:,2))/2); % numer of samples for each trial
[mean_acc_LD,std_acc_LD, se_acc_LD] = bootstrap_nd(N_round,N_smaple,P_GT(:,2),P_GT(:,1))

%a bootstrap standard of error for the estimated correlation coefficient
[bootstat_LD,bootsam] = bootstrp(50,@corr,P_GT(:,1),P_GT(:,2));se_LD = std(bootstat_LD)

if strcmp(isOrg_1000,'TRUE') || strcmp(isOrg_224,'TRUE')
    tpr_LD = 100-sum(P_GT(length(EoEstats_validation)/2+1:end,3))/(length(EoEstats_validation)/2)*100
    tnr_LD = 100-sum(P_GT(1:length(EoEstats_validation)/2,3))/(length(EoEstats_validation)/2)*100
    test_accuracy_LD = 100-sum(P_GT(:,3))/length(EoEstats_validation)*100
    pp_LD = sum(P_GT(:,1))/length(EoEstats_validation)
end

if strcmp(is448_224,'TRUE')
    tpr_LD = 100-sum(P_GT(498:end,3))/(478)*100
    tnr_LD = 100-sum(P_GT(1:497,3))/(497)*100
    test_accuracy_LD = 100-sum(P_GT(:,3))/length(EoEstats_validation)*100
    pp_LD = sum(P_GT(:,1))/length(EoEstats_validation)
end

if strcmp(is224_224,'TRUE')
    tpr_LD = 100-sum(P_GT(1693:end,3))/(1626)*100
    tnr_LD = 100-sum(P_GT(1:1692,3))/(1692)*100
    test_accuracy_LD = 100-sum(P_GT(:,3))/length(EoEstats_validation)*100
    pp_LD = sum(P_GT(:,1))/length(EoEstats_validation)
end


%% LR
pEoEstats_validation = [];
for i=1:length(EoEstats_validation)
    pEoEstats_validation = [pEoEstats_validation, trained_classifier_LR.predictFcn(EoEstats_validation(i,1:20))];
end
pEoEstats_validation = pEoEstats_validation';
P_GT = [pEoEstats_validation, EoEstats_validation(:,21)];
P_GT_diff = P_GT(:,1)-P_GT(:,2);
P_GT = [P_GT , P_GT_diff];
P_GT(:,3) = abs(P_GT(:,3));

% Run a bootstrap loop
N_round = 10^4; % number of trilas
N_smaple = round(length(P_GT(:,2))/2); % numer of samples for each trial
[mean_acc_LR, std_acc_LR, se_acc_LR] = bootstrap_nd(N_round,N_smaple,P_GT(:,2),P_GT(:,1))

%a bootstrap standard of error for the estimated correlation coefficient
[bootstat_LR,bootsam] = bootstrp(length(P_GT),@corr,P_GT(:,1),P_GT(:,2));se_LR = std(bootstat_LR)

if strcmp(isOrg_1000,'TRUE') || strcmp(isOrg_224,'TRUE')
    tpr_LR = 100-sum(P_GT(length(EoEstats_validation)/2+1:end,3))/(length(EoEstats_validation)/2)*100
    tnr_LR = 100-sum(P_GT(1:length(EoEstats_validation)/2,3))/(length(EoEstats_validation)/2)*100
    test_accuracy_LR = 100-sum(P_GT(:,3))/length(EoEstats_validation)*100
    pp_LR = sum(P_GT(:,1))/length(EoEstats_validation)
end

if strcmp(is448_224,'TRUE')
    tpr_LR = 100-sum(P_GT(498:end,3))/(478)*100
    tnr_LR = 100-sum(P_GT(1:497,3))/(497)*100
    test_accuracy_LR = 100-sum(P_GT(:,3))/length(EoEstats_validation)*100
    pp_LR = sum(P_GT(:,1))/length(EoEstats_validation)
end

if strcmp(is224_224,'TRUE')
    tpr_LR = 100-sum(P_GT(1693:end,3))/(1626)*100
    tnr_LR = 100-sum(P_GT(1:1692,3))/(1692)*100
    test_accuracy_LR = 100-sum(P_GT(:,3))/length(EoEstats_validation)*100
    pp_LR = sum(P_GT(:,1))/length(EoEstats_validation)
end

%% SVM
pEoEstats_validation = [];
for i=1:length(EoEstats_validation)
    pEoEstats_validation = [pEoEstats_validation, trained_classifier_SVM.predictFcn(EoEstats_validation(i,1:20))];
end
pEoEstats_validation = pEoEstats_validation';
P_GT = [pEoEstats_validation, EoEstats_validation(:,21)];
P_GT_diff = P_GT(:,1)-P_GT(:,2);
P_GT = [P_GT , P_GT_diff];
P_GT(:,3) = abs(P_GT(:,3));

% Run a bootstrap loop
N_round = 10^4; % number of trilas
N_smaple = round(length(P_GT(:,2))/2); % numer of samples for each trial
[mean_acc_SVM, std_acc_SVM, se_acc_SVM] = bootstrap_nd(N_round,N_smaple,P_GT(:,2),P_GT(:,1))

%a bootstrap standard of error for the estimated correlation coefficient
[bootstat_SVM,bootsam] = bootstrp(length(P_GT),@corr,P_GT(:,1),P_GT(:,2));se_SVM = std(bootstat_SVM)

if strcmp(isOrg_1000,'TRUE') || strcmp(isOrg_224,'TRUE')
    tpr_SVM = 100-sum(P_GT(length(EoEstats_validation)/2+1:end,3))/(length(EoEstats_validation)/2)*100
    tnr_SVM = 100-sum(P_GT(1:length(EoEstats_validation)/2,3))/(length(EoEstats_validation)/2)*100
    test_accuracy_SVM = 100-sum(P_GT(:,3))/length(EoEstats_validation)*100
    pp_SVM = sum(P_GT(:,1))/length(EoEstats_validation)
end

if strcmp(is448_224,'TRUE')
    tpr_SVM = 100-sum(P_GT(498:end,3))/(478)*100
    tnr_SVM = 100-sum(P_GT(1:497,3))/(497)*100
    test_accuracy_SVM = 100-sum(P_GT(:,3))/length(EoEstats_validation)*100
    pp_SVM = sum(P_GT(:,1))/length(EoEstats_validation)
end

if strcmp(is224_224,'TRUE')
    tpr_SVM = 100-sum(P_GT(1693:end,3))/(1626)*100
    tnr_SVM = 100-sum(P_GT(1:1692,3))/(1692)*100
    test_accuracy_SVM = 100-sum(P_GT(:,3))/length(EoEstats_validation)*100
    pp_SVM = sum(P_GT(:,1))/length(EoEstats_validation)
end

%% Aux functions



function [mean_acc,std_acc, se_acc,acc] = bootstrap_nd(N_round,N_smaple,GT,P)


for cnt_round = 1:N_round

    ind = randperm(length(GT));
    ind = ind(1:N_smaple);

    gt_sample = GT(ind);
    p_sample = P(ind);
    
    tpr = sum(p_sample.*gt_sample)/sum(gt_sample);
    tnr = sum((~p_sample).*(~gt_sample))/sum(~gt_sample);
    acc(cnt_round) = (sum(p_sample.*gt_sample) + sum((~p_sample).*(~gt_sample))) / (sum(gt_sample) + sum(~gt_sample));
    
end

%hist(acc);
mean_acc = mean(acc);
std_acc = std(acc);
se_acc =  std(acc)/sqrt(length(acc));
end
