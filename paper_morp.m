%% Unsupervised learning models for Blastocyst potential

% total of 103 embryos with morps and times
% input 1: data_O, data_Y reduced 1cell-full-blasto
% input 2: blastocyst indication
% intermidate output: vector Y, vector O w and w/o manual time, ..
% for each stage (1-B)
% input for classifier
clear;clc;close all
warning('off')

%% pre-process data
load('C:\Users\SavirLab\Desktop\Nati\morpemb\emb_alive_new_with_morp_plus9.mat')

% ind_blasto: 1 indicates survived, 0 not-survived
ind_blasto = double(ind');

% old_young_ind: 1 indicates old, 0 indicates young
old_young_ind = zeros(1,103);old_young_ind(1)=1;old_young_ind(26:57)=1;old_young_ind(90:97)=1;

% 103 morps with area
for i=1:103
    [m,n] = size(new_morp_103{1,i});
    Agg = zeros(m+1,n);Agg(1,:)=area_f(i,1:n);
    Agg(2:end,:)=new_morp_103{1,i};
    new_morp_103_a{1,i}=Agg;
end

% manual time with 1cell (time imdicates end-stage)
time_man_w_one_cell = NaN(103,7);
for i=1:103
    [~,n_last] = size(new_morp_103_a{1,i});
    time_man_w_one_cell(i,1:6) = time_man(i,:)-1;
    if ind_blasto(i)==1
        time_man_w_one_cell(i,7)=n_last;
    else
        time_man_w_one_cell(i,find(isnan(time_man(i,:)),1))=n_last;
    end
end

PlusMinus1 = 'TRUE';
OnlyReducedRun = 'TRUE';
RunTimes = 100;

if strcmp(PlusMinus1,'FALSE')
    % Calculate mean embryosstats matrices
    for i=1:length(new_morp_103_a)
        [dr,dc] = size(new_morp_103_a{1,i});
        uc = 7 - sum(isnan(time_man_w_one_cell(i,:)));
        new_morp_103_a_R{1,i} = zeros(dr+1,uc);
        for j=1:uc
            if j ==1
                f = 1;
                e = time_man_w_one_cell(i,j);
            else
                f = time_man_w_one_cell(i,j-1)+1;
                e = time_man_w_one_cell(i,j);
            end
            for r=1:dr
                new_morp_103_a_R{1,i}(r,j) = median(new_morp_103_a{1,i}(r,f:e));
            end
            new_morp_103_a_R{1,i}(46,j) = time_man_w_one_cell(i,j);
        end
    end
else
    % +/-1 median
    % Calculate mean embryosstats matrices
    for i=1:length(new_morp_103_a)
        [dr,dc] = size(new_morp_103_a{1,i});
        uc = 7 - sum(isnan(time_man_w_one_cell(i,:)));
        new_morp_103_a_R{1,i} = zeros(dr+1,uc-1);
        for j=1:(uc)
            if j ==1
                f = 1;
                e = time_man_w_one_cell(i,j);
            else
                f = time_man_w_one_cell(i,j-1)+1;
                e = time_man_w_one_cell(i,j);
            end
            for r=1:dr
                if j == (uc)
                    continue
                else
                    if e+2 > dc
                        ek = dc;
                    else
                        ek = e + 2;
                    end
                    new_morp_103_a_R{1,i}(r,j) = mean(new_morp_103_a{1,i}(r,e:ek));
                end
            end
            if j ~= (uc)
                new_morp_103_a_R{1,i}(46,j) = time_man_w_one_cell(i,j)+1;
            end
        end
    end
end

% seperate between Y and O
% and override the new 9 morp features
override_9 = [8,9,21,37,67,99,100,101,103];
ind_BY = []; ind_BO = [];
yc = 1; oc = 1;

for i=1:103
    if old_young_ind(i)==1
        ind_BO = [ind_BO,ind_blasto(i)];
        data_O{1,oc} = new_morp_103_a_R{1,i};
        if any(override_9(:) == i)
            if strcmp(PlusMinus1,'FALSE')
                data_O{1,oc}(1:45,:) = new_morp_9{1,i};
            else
                data_O{1,oc}(1:45,:) = new_morp_9{1,i}(:,2:end);
            end
        end
        oc = oc+1;
    else
        ind_BY = [ind_BY,ind_blasto(i)];
        data_Y{1,yc} = new_morp_103_a_R{1,i};
        if any(override_9(:) == i)
            if strcmp(PlusMinus1,'FALSE')
                data_Y{1,yc}(1:45,:) = new_morp_9{1,i};
            else
                data_Y{1,yc}(1:45,:) = new_morp_9{1,i}(:,2:end);
            end
        end
        yc = yc+1;
    end
end

%% Start ML for blastocyst predict
% loop X runs
for rn=1:RunTimes
    % loop ML for each stage
    % init
    SVM_Y_WT_Validation_ACC = []; SVM_O_WT_Validation_ACC = [];
    SVM_Y_WOT_Validation_ACC = []; SVM_O_WOT_Validation_ACC = [];
    Ensemble_Y_WT_Validation_ACC = []; Ensemble_O_WT_Validation_ACC = [];
    Ensemble_Y_WOT_Validation_ACC = []; Ensemble_O_WOT_Validation_ACC = [];
    
    SVM_Y_WT_R_Validation_ACC = []; SVM_O_WT_R_Validation_ACC = [];
    SVM_Y_WOT_R_Validation_ACC = []; SVM_O_WOT_R_Validation_ACC = [];
    Ensemble_Y_WT_R_Validation_ACC = []; Ensemble_O_WT_R_Validation_ACC = [];
    Ensemble_Y_WOT_R_Validation_ACC = []; Ensemble_O_WOT_R_Validation_ACC = [];
    LD_Y_WT_R_Validation_ACC = []; LD_O_WT_R_Validation_ACC = [];
    LD_Y_WOT_R_Validation_ACC = []; LD_O_WOT_R_Validation_ACC = [];
    
    % false alarm rate only for reduced features
    SVM_Y_WT_R_Validation_FAR = []; SVM_O_WT_R_Validation_FAR = [];
    SVM_Y_WOT_R_Validation_FAR = []; SVM_O_WOT_R_Validation_FAR = [];
    Ensemble_Y_WT_R_Validation_FAR = []; Ensemble_O_WT_R_Validation_FAR = [];
    Ensemble_Y_WOT_R_Validation_FAR = []; Ensemble_O_WOT_R_Validation_FAR = [];
    LD_Y_WT_R_Validation_FAR = []; LD_O_WT_R_Validation_FAR = [];
    LD_Y_WOT_R_Validation_FAR = []; LD_O_WOT_R_Validation_FAR = [];
    % miss rate only for reduced features
    SVM_Y_WT_R_Validation_MR = []; SVM_O_WT_R_Validation_MR = [];
    SVM_Y_WOT_R_Validation_MR = []; SVM_O_WOT_R_Validation_MR = [];
    Ensemble_Y_WT_R_Validation_MR = []; Ensemble_O_WT_R_Validation_MR = [];
    Ensemble_Y_WOT_R_Validation_MR = []; Ensemble_O_WOT_R_Validation_MR = [];
    LD_Y_WT_R_Validation_MR = []; LD_O_WT_R_Validation_MR = [];
    LD_Y_WOT_R_Validation_MR = []; LD_O_WOT_R_Validation_MR = [];
    % Prevalence only for reduced features
    SVM_Y_WT_R_Validation_P = []; SVM_O_WT_R_Validation_P = [];
    SVM_Y_WOT_R_Validation_P = []; SVM_O_WOT_R_Validation_P = [];
    Ensemble_Y_WT_R_Validation_P = []; Ensemble_O_WT_R_Validation_P = [];
    Ensemble_Y_WOT_R_Validation_P = []; Ensemble_O_WOT_R_Validation_P = [];
    LD_Y_WT_R_Validation_P = []; LD_O_WT_R_Validation_P = [];
    LD_Y_WOT_R_Validation_P = []; LD_O_WOT_R_Validation_P = [];
    % GT_P only for reduced features
    SVM_Y_WT_R_Validation_GT = []; SVM_O_WT_R_Validation_GT = [];
    SVM_Y_WOT_R_Validation_GT = []; SVM_O_WOT_R_Validation_GT = [];
    Ensemble_Y_WT_R_Validation_GT = []; Ensemble_O_WT_R_Validation_GT = [];
    Ensemble_Y_WOT_R_Validation_GT = []; Ensemble_O_WOT_R_Validation_GT = [];
    LD_Y_WT_R_Validation_GT = []; LD_O_WT_R_Validation_GT = [];
    LD_Y_WOT_R_Validation_GT = []; LD_O_WOT_R_Validation_GT = [];
    SVM_Y_WT_R_Validation_Pr = []; SVM_O_WT_R_Validation_Pr = [];
    SVM_Y_WOT_R_Validation_Pr = []; SVM_O_WOT_R_Validation_Pr = [];
    Ensemble_Y_WT_R_Validation_Pr = []; Ensemble_O_WT_R_Validation_Pr = [];
    Ensemble_Y_WOT_R_Validation_Pr = []; Ensemble_O_WOT_R_Validation_Pr = [];
    LD_Y_WT_R_Validation_Pr = []; LD_O_WT_R_Validation_Pr = [];
    LD_Y_WOT_R_Validation_Pr = []; LD_O_WOT_R_Validation_Pr = [];

    % data seperation level
    P50 = 'FALSE';
    o_ds = 41; % if P50 is FALSE, o_ds=41
    y_ds = 62; % if P50 is FALSE, y_ds=62

    % loop stages
    for ii=1:5
        ind_stage = ii; % till Early Blastocyst (5)

        % init inner loop
        SVM_Y_OF_Validation_ACC = []; SVM_O_OF_Validation_ACC = [];
        LD_Y_OF_Validation_ACC = []; LD_O_OF_Validation_ACC = [];
        Ensemble_Y_OF_Validation_ACC = []; Ensemble_O_OF_Validation_ACC = [];

        % vector ML for young (num embryos x num features)
        k=1;
        for i=1:length(ind_BY)
            [n_prop,n_stage] = size(data_Y{i});
            if n_stage>=ind_stage
                vector_Y(k,:) = data_Y{i}(:,ind_stage);
                ind_blasto_Y_stage(k) = ind_BY(i);
                k=k+1;
            end
        end

        % vector ML for old (num embryos x num features)
        k=1;
        for i=1:length(ind_BO)
            [n_prop,n_stage] = size(data_O{i});
            if n_stage>=ind_stage
                vector_O(k,:) = data_O{i}(:,ind_stage);
                ind_blasto_O_stage(k) = ind_BO(i);
                k=k+1;
            end
        end

        % add GT (blastocyst indication) and exlode or not the time
        % both for old and young
        % use all features
        vector_O_WT = vector_O; vector_O_WT(:,47) = ind_blasto_O_stage;
        vector_O_WOT = vector_O; vector_O_WOT(:,46) = ind_blasto_O_stage;
        vector_Y_WT = vector_Y; vector_Y_WT(:,47) = ind_blasto_Y_stage;
        vector_Y_WOT = vector_Y; vector_Y_WOT(:,46) = ind_blasto_Y_stage;

        % reduce features - nd
        %y_wt_r = length([1,5,7,15:17,25,30,38,46:47]);
        %o_wt_r = length([1,5,15,17,27,31,38,46:47]);
        %y_wot_r = length([1,5,7,15:17,25,30,38,46]);
        %o_wot_r = length([1,5,15,17,27,31,38,46]);
        %vector_Y_WT_R = vector_Y_WT(:,[1,5,7,15:17,25,30,38,46:47]);
        %vector_O_WT_R = vector_O_WT(:,[1,5,15,17,27,31,38,46:47]);
        %vector_Y_WOT_R = vector_Y_WOT(:,[1,5,7,15:17,25,30,38,46]);
        %vector_O_WOT_R = vector_O_WOT(:,[1,5,15,17,27,31,38,46]);
        
        % reduce features - ys
        y_wt_r = 9; o_wt_r = 9; y_wot_r = 8; o_wot_r = 8;
        vector_Y_WT_R = vector_Y_WT(:,[8,9,16,30,36,42,45:47]);
        vector_O_WT_R = vector_O_WT(:,[8,9,16,30,36,42,45:47]);
        vector_Y_WOT_R = vector_Y_WOT(:,[8,9,16,30,36,42,45:46]);
        vector_O_WOT_R = vector_O_WOT(:,[8,9,16,30,36,42,45:46]);
        %only time
        %y_wt_r = 2; o_wt_r = 2; y_wot_r = 5; o_wot_r = 5;
        %vector_Y_WT_R = vector_Y_WT(:,[46:47]);
        %vector_O_WT_R = vector_O_WT(:,[46:47]);
        %vector_Y_WOT_R = vector_Y_WOT(:,[8,30,42,45:46]);
        %vector_O_WOT_R = vector_O_WOT(:,[8,30,42,45:46]);

        % update number the max embryos per stage
        if strcmp(P50,'FALSE')
            [os, ~] = size(vector_O);o_ds = os;
            [ys, ~] = size(vector_Y);y_ds = ys;
        end

        % run ML models
        if strcmp(OnlyReducedRun,'FALSE')
            % All features w/ time for Young and Old, SVM
            [O_AWT_SVM_Trainer, O_AWT_SVMvalidationAccuracy] = trainMLClassifier(vector_O_WT(1:o_ds,:),"SVM",47);
            if strcmp(P50,'TRUE')
                O_AWT_SVMvalidationAccuracy = Mpredict(O_AWT_SVM_Trainer, vector_O_WT((o_ds+1):end,:));
            end
            [Y_AWT_SVM_Trainer, Y_AWT_SVMvalidationAccuracy] = trainMLClassifier(vector_Y_WT(1:y_ds,:),"SVM",47);
            if strcmp(P50,'TRUE')
                Y_AWT_SVMvalidationAccuracy = Mpredict(Y_AWT_SVM_Trainer, vector_Y_WT((y_ds+1):end,:));
            end

            % All features w/ time for Young and Old, Ensemble
            [O_AWT_Ensemble_Trainer, O_AWT_EnsemblevalidationAccuracy] = trainMLClassifier(vector_O_WT(1:o_ds,:),"Ensemble",47);
            if strcmp(P50,'TRUE')
                O_AWT_EnsemblevalidationAccuracy = Mpredict(O_AWT_Ensemble_Trainer, vector_O_WT((o_ds+1):end,:));
            end
            [Y_AWT_Ensemble_Trainer, Y_AWT_EnsemblevalidationAccuracy] = trainMLClassifier(vector_Y_WT(1:y_ds,:),"Ensemble",47);
            if strcmp(P50,'TRUE')
                Y_AWT_EnsemblevalidationAccuracy = Mpredict(Y_AWT_Ensemble_Trainer, vector_Y_WT((y_ds+1):end,:));
            end

            % All features w/o time for Young and Old, SVM
            [O_AWOT_SVM_Trainer, O_AWOT_SVMvalidationAccuracy] = trainMLClassifier(vector_O_WOT(1:o_ds,:),"SVM",46);
            if strcmp(P50,'TRUE')
                O_AWOT_SVMvalidationAccuracy = Mpredict(O_AWOT_SVM_Trainer, vector_O_WOT((o_ds+1):end,:));
            end
            [Y_AWOT_SVM_Trainer, Y_AWOT_SVMvalidationAccuracy] = trainMLClassifier(vector_Y_WOT(1:y_ds,:),"SVM",46);
            if strcmp(P50,'TRUE')
                Y_AWOT_SVMvalidationAccuracy = Mpredict(Y_AWOT_SVM_Trainer, vector_Y_WOT((y_ds+1):end,:));
            end

            % All features w/o time for Young and Old, Ensemble
            [O_AWOT_Ensemble_Trainer, O_AWOT_EnsemblevalidationAccuracy] = trainMLClassifier(vector_O_WOT(1:o_ds,:),"Ensemble",46);
            if strcmp(P50,'TRUE')
                O_AWOT_EnsemblevalidationAccuracy = Mpredict(O_AWOT_Ensemble_Trainer, vector_O_WOT((o_ds+1):end,:));
            end
            [Y_AWOT_Ensemble_Trainer, Y_AWOT_EnsemblevalidationAccuracy] = trainMLClassifier(vector_Y_WOT(1:y_ds,:),"Ensemble",46);
            if strcmp(P50,'TRUE')
                Y_AWOT_EnsemblevalidationAccuracy = Mpredict(Y_AWOT_Ensemble_Trainer, vector_Y_WOT((y_ds+1):end,:));
            end

            % update results
            SVM_Y_WT_Validation_ACC = [SVM_Y_WT_Validation_ACC, Y_AWT_SVMvalidationAccuracy];
            SVM_O_WT_Validation_ACC = [SVM_O_WT_Validation_ACC, O_AWT_SVMvalidationAccuracy];
            SVM_Y_WOT_Validation_ACC = [SVM_Y_WOT_Validation_ACC, Y_AWOT_SVMvalidationAccuracy];
            SVM_O_WOT_Validation_ACC = [SVM_O_WOT_Validation_ACC, O_AWOT_SVMvalidationAccuracy];
            Ensemble_Y_WT_Validation_ACC = [Ensemble_Y_WT_Validation_ACC, Y_AWT_EnsemblevalidationAccuracy];
            Ensemble_O_WT_Validation_ACC = [Ensemble_O_WT_Validation_ACC, O_AWT_EnsemblevalidationAccuracy];
            Ensemble_Y_WOT_Validation_ACC = [Ensemble_Y_WOT_Validation_ACC, Y_AWOT_EnsemblevalidationAccuracy];
            Ensemble_O_WOT_Validation_ACC = [Ensemble_O_WOT_Validation_ACC, O_AWOT_EnsemblevalidationAccuracy];
        end

        % repeat for reduced features
        % Reduced features w/ time for Young and Old, SVM
        [O_RWT_SVM_Trainer, O_RWT_SVMvalidationAccuracy, O_RWT_SVMvalidationPredictions] = trainMLClassifier(vector_O_WT_R(1:o_ds,:),"SVM",o_wt_r);
        cp = classperf(vector_O_WT_R(:,end),O_RWT_SVMvalidationPredictions);
        gt_o_rwt_svm = vector_O_WT_R(:,end);
        pr_o_rwt_svm = O_RWT_SVMvalidationPredictions;
        facc_o_rwt_svm = cp.CorrectRate;
        prevalence_o_rwt_svm = cp.Prevalence;
        missrate_o_rwt_svm = 1- cp.Sensitivity;
        falsealarm_o_rwt_svm = 1 - cp.Specificity;
        if strcmp(P50,'TRUE')
            O_RWT_SVMvalidationAccuracy = Mpredict(O_RWT_SVM_Trainer, vector_O_WT_R((o_ds+1):end,:));
        end
        [Y_RWT_SVM_Trainer, Y_RWT_SVMvalidationAccuracy, Y_RWT_SVMvalidationPredictions] = trainMLClassifier(vector_Y_WT_R(1:y_ds,:),"SVM",y_wt_r);
        cp = classperf(vector_Y_WT_R(:,end),Y_RWT_SVMvalidationPredictions);
        gt_y_rwt_svm = vector_Y_WT_R(:,end);
        pr_y_rwt_svm = Y_RWT_SVMvalidationPredictions;
        facc_y_rwt_svm = cp.CorrectRate;
        prevalence_y_rwt_svm = cp.Prevalence;
        missrate_y_rwt_svm = 1- cp.Sensitivity;
        falsealarm_y_rwt_svm = 1 - cp.Specificity;
        if strcmp(P50,'TRUE')
            Y_RWT_SVMvalidationAccuracy = Mpredict(Y_RWT_SVM_Trainer, vector_Y_WT_R((y_ds+1):end,:));
        end

        % Reduced features w/ time for Young and Old, Ensemble
        [O_RWT_Ensemble_Trainer, O_RWT_EnsemblevalidationAccuracy, O_RWT_EnsemblevalidationPredictions] = trainMLClassifier(vector_O_WT_R(1:o_ds,:),"Ensemble",o_wt_r);
        cp = classperf(vector_O_WT_R(:,end),O_RWT_EnsemblevalidationPredictions);
        gt_o_rwt_e = vector_O_WT_R(:,end);
        pr_o_rwt_e = O_RWT_EnsemblevalidationPredictions;
        facc_o_rwt_e = cp.CorrectRate;
        prevalence_o_rwt_e = cp.Prevalence;
        missrate_o_rwt_e = 1- cp.Sensitivity;
        falsealarm_o_rwt_e = 1 - cp.Specificity;
        if strcmp(P50,'TRUE')
            O_RWT_EnsemblevalidationAccuracy = Mpredict(O_RWT_Ensemble_Trainer, vector_O_WT_R((o_ds+1):end,:));
        end
        [Y_RWT_Ensemble_Trainer, Y_RWT_EnsemblevalidationAccuracy, Y_RWT_EnsemblevalidationPredictions] = trainMLClassifier(vector_Y_WT_R(1:y_ds,:),"Ensemble",y_wt_r);
        cp = classperf(vector_Y_WT_R(:,end),Y_RWT_EnsemblevalidationPredictions);
        gt_y_rwt_e = vector_Y_WT_R(:,end);
        pr_y_rwt_e = Y_RWT_EnsemblevalidationPredictions;
        facc_y_rwt_e = cp.CorrectRate;
        prevalence_y_rwt_e = cp.Prevalence;
        missrate_y_rwt_e = 1- cp.Sensitivity;
        falsealarm_y_rwt_e = 1 - cp.Specificity;
        if strcmp(P50,'TRUE')
            Y_RWT_EnsemblevalidationAccuracy = Mpredict(Y_RWT_Ensemble_Trainer, vector_Y_WT_R((y_ds+1):end,:));
        end

        % Reduced features w/ time for Young and Old, LD
        [O_RWT_LD_Trainer, O_RWT_LDvalidationAccuracy, O_RWT_LDvalidationPredictions] = trainMLClassifier(vector_O_WT_R(1:o_ds,:),"LD",o_wt_r);
        cp = classperf(vector_O_WT_R(:,end),O_RWT_LDvalidationPredictions);
        gt_o_rwt_l = vector_O_WT_R(:,end);
        pr_o_rwt_l = O_RWT_LDvalidationPredictions;
        facc_o_rwt_l = cp.CorrectRate;
        prevalence_o_rwt_l = cp.Prevalence;
        missrate_o_rwt_l = 1- cp.Sensitivity;
        falsealarm_o_rwt_l = 1 - cp.Specificity;
        if strcmp(P50,'TRUE')
            O_RWT_LDvalidationAccuracy = Mpredict(O_RWT_LD_Trainer, vector_O_WT_R((o_ds+1):end,:));
        end
        [Y_RWT_LD_Trainer, Y_RWT_LDvalidationAccuracy, Y_RWT_LDvalidationPredictions] = trainMLClassifier(vector_Y_WT_R(1:y_ds,:),"LD",y_wt_r);
        cp = classperf(vector_Y_WT_R(:,end),Y_RWT_LDvalidationPredictions);
        gt_y_rwt_l = vector_Y_WT_R(:,end);
        pr_y_rwt_l = Y_RWT_LDvalidationPredictions;
        facc_y_rwt_l = cp.CorrectRate;
        prevalence_y_rwt_l = cp.Prevalence;
        missrate_y_rwt_l = 1- cp.Sensitivity;
        falsealarm_y_rwt_l = 1 - cp.Specificity;
        if strcmp(P50,'TRUE')
            Y_RWT_LDvalidationAccuracy = Mpredict(Y_RWT_LD_Trainer, vector_Y_WT_R((y_ds+1):end,:));
        end

        % Reduced features w/o time for Young and Old, SVM
        [O_RWOT_SVM_Trainer, O_RWOT_SVMvalidationAccuracy, O_RWOT_SVMvalidationPredictions] = trainMLClassifier(vector_O_WOT_R(1:o_ds,:),"SVM",o_wot_r);
        cp = classperf(vector_O_WOT_R(:,end),O_RWOT_SVMvalidationPredictions);
        gt_o_rwot_svm = vector_O_WOT_R(:,end);
        pr_o_rwot_svm = O_RWOT_SVMvalidationPredictions;
        facc_o_rwot_svm = cp.CorrectRate;
        prevalence_o_rwot_svm = cp.Prevalence;
        missrate_o_rwot_svm = 1- cp.Sensitivity;
        falsealarm_o_rwot_svm = 1 - cp.Specificity;
        if strcmp(P50,'TRUE')
            O_RWOT_SVMvalidationAccuracy = Mpredict(O_RWOT_SVM_Trainer, vector_O_WOT_R((o_ds+1):end,:)); 
        end
        [Y_RWOT_SVM_Trainer, Y_RWOT_SVMvalidationAccuracy, Y_RWOT_SVMvalidationPredictions] = trainMLClassifier(vector_Y_WOT_R(1:y_ds,:),"SVM",y_wot_r);
        cp = classperf(vector_Y_WOT_R(:,end),Y_RWOT_SVMvalidationPredictions);
        gt_y_rwot_svm = vector_Y_WOT_R(:,end);
        pr_y_rwot_svm = Y_RWOT_SVMvalidationPredictions;
        facc_y_rwot_svm = cp.CorrectRate;
        prevalence_y_rwot_svm = cp.Prevalence;
        missrate_y_rwot_svm = 1- cp.Sensitivity;
        falsealarm_y_rwot_svm = 1 - cp.Specificity;
        if strcmp(P50,'TRUE')
            Y_RWOT_SVMvalidationAccuracy = Mpredict(Y_RWOT_SVM_Trainer, vector_Y_WOT_R((y_ds+1):end,:));
        end

        % Reduced features w/o time for Young and Old, Ensemble
        [O_RWOT_Ensemble_Trainer, O_RWOT_EnsemblevalidationAccuracy, O_RWOT_EnsemblevalidationPredictions] = trainMLClassifier(vector_O_WOT_R(1:o_ds,:),"Ensemble",o_wot_r);
        cp = classperf(vector_O_WOT_R(:,end),O_RWOT_EnsemblevalidationPredictions);
        gt_o_rwot_e = vector_O_WOT_R(:,end);
        pr_o_rwot_e = O_RWOT_EnsemblevalidationPredictions;
        facc_o_rwot_e = cp.CorrectRate;
        prevalence_o_rwot_e = cp.Prevalence;
        missrate_o_rwot_e = 1- cp.Sensitivity;
        falsealarm_o_rwot_e = 1 - cp.Specificity;
        if strcmp(P50,'TRUE')
            O_RWOT_EnsemblevalidationAccuracy = Mpredict(O_RWOT_Ensemble_Trainer, vector_O_WOT_R((o_ds+1):end,:));
        end
        [Y_RWOT_Ensemble_Trainer, Y_RWOT_EnsemblevalidationAccuracy, Y_RWOT_EnsemblevalidationPredictions] = trainMLClassifier(vector_Y_WOT_R(1:y_ds,:),"Ensemble",y_wot_r);
        cp = classperf(vector_Y_WOT_R(:,end),Y_RWOT_EnsemblevalidationPredictions);
        gt_y_rwot_e = vector_Y_WOT_R(:,end);
        pr_y_rwot_e = Y_RWOT_EnsemblevalidationPredictions;
        facc_y_rwot_e = cp.CorrectRate;
        prevalence_y_rwot_e = cp.Prevalence;
        missrate_y_rwot_e = 1- cp.Sensitivity;
        falsealarm_y_rwot_e = 1 - cp.Specificity;
        if strcmp(P50,'TRUE')
            Y_RWOT_EnsemblevalidationAccuracy = Mpredict(Y_RWOT_Ensemble_Trainer, vector_Y_WOT_R((y_ds+1):end,:));
        end

        % Reduced features w/o time for Young and Old, LD
        [O_RWOT_LD_Trainer, O_RWOT_LDvalidationAccuracy, O_RWOT_LDvalidationPredictions] = trainMLClassifier(vector_O_WOT_R(1:o_ds,:),"LD",o_wot_r);
        cp = classperf(vector_O_WOT_R(:,end),O_RWOT_LDvalidationPredictions);
        gt_o_rwot_l = vector_O_WOT_R(:,end);
        pr_o_rwot_l = O_RWOT_LDvalidationPredictions;
        facc_o_rwot_l = cp.CorrectRate;
        prevalence_o_rwot_l = cp.Prevalence;
        missrate_o_rwot_l = 1- cp.Sensitivity;
        falsealarm_o_rwot_l = 1 - cp.Specificity;
        if strcmp(P50,'TRUE')
            O_RWOT_LDvalidationAccuracy = Mpredict(O_RWOT_LD_Trainer, vector_O_WOT_R((o_ds+1):end,:));
        end
        [Y_RWOT_LD_Trainer, Y_RWOT_LDvalidationAccuracy, Y_RWOT_LDvalidationPredictions] = trainMLClassifier(vector_Y_WOT_R(1:y_ds,:),"LD",y_wot_r);
        cp = classperf(vector_Y_WOT_R(:,end),Y_RWOT_LDvalidationPredictions);
        gt_y_rwot_l = vector_Y_WOT_R(:,end);
        pr_y_rwot_l = Y_RWOT_LDvalidationPredictions;
        facc_y_rwot_l = cp.CorrectRate;
        prevalence_y_rwot_l = cp.Prevalence;
        missrate_y_rwot_l = 1- cp.Sensitivity;
        falsealarm_y_rwot_l = 1 - cp.Specificity;
        if strcmp(P50,'TRUE')
            Y_RWOT_LDvalidationAccuracy = Mpredict(Y_RWOT_LD_Trainer, vector_Y_WOT_R((y_ds+1):end,:));
        end

        % update reduced features results
        % acc
        SVM_Y_WT_R_Validation_ACC = [SVM_Y_WT_R_Validation_ACC, Y_RWT_SVMvalidationAccuracy];
        SVM_O_WT_R_Validation_ACC = [SVM_O_WT_R_Validation_ACC, O_RWT_SVMvalidationAccuracy];
        SVM_Y_WOT_R_Validation_ACC = [SVM_Y_WOT_R_Validation_ACC, Y_RWOT_SVMvalidationAccuracy];
        SVM_O_WOT_R_Validation_ACC = [SVM_O_WOT_R_Validation_ACC, O_RWOT_SVMvalidationAccuracy];
        LD_Y_WT_R_Validation_ACC = [LD_Y_WT_R_Validation_ACC, Y_RWT_LDvalidationAccuracy];
        LD_O_WT_R_Validation_ACC = [LD_O_WT_R_Validation_ACC, O_RWT_LDvalidationAccuracy];
        LD_Y_WOT_R_Validation_ACC = [LD_Y_WOT_R_Validation_ACC, Y_RWOT_LDvalidationAccuracy];
        LD_O_WOT_R_Validation_ACC = [LD_O_WOT_R_Validation_ACC, O_RWOT_LDvalidationAccuracy];
        Ensemble_Y_WT_R_Validation_ACC = [Ensemble_Y_WT_R_Validation_ACC, Y_RWT_EnsemblevalidationAccuracy];
        Ensemble_O_WT_R_Validation_ACC = [Ensemble_O_WT_R_Validation_ACC, O_RWT_EnsemblevalidationAccuracy];
        Ensemble_Y_WOT_R_Validation_ACC = [Ensemble_Y_WOT_R_Validation_ACC, Y_RWOT_EnsemblevalidationAccuracy];
        Ensemble_O_WOT_R_Validation_ACC = [Ensemble_O_WOT_R_Validation_ACC, O_RWOT_EnsemblevalidationAccuracy];
        % miss rate, fallout, prev, predict, gt
        Ensemble_Y_WOT_R_Validation_FAR = [Ensemble_Y_WOT_R_Validation_FAR,falsealarm_y_rwot_e];
        Ensemble_O_WOT_R_Validation_FAR = [Ensemble_O_WOT_R_Validation_FAR,falsealarm_o_rwot_e];
        Ensemble_Y_WT_R_Validation_FAR = [Ensemble_Y_WT_R_Validation_FAR,falsealarm_y_rwt_e];
        Ensemble_O_WT_R_Validation_FAR = [Ensemble_O_WT_R_Validation_FAR,falsealarm_o_rwt_e];
        Ensemble_Y_WOT_R_Validation_MR = [Ensemble_Y_WOT_R_Validation_MR,missrate_y_rwot_e];
        Ensemble_O_WOT_R_Validation_MR = [Ensemble_O_WOT_R_Validation_MR,missrate_o_rwot_e];
        Ensemble_Y_WT_R_Validation_MR = [Ensemble_Y_WT_R_Validation_MR,missrate_y_rwt_e];
        Ensemble_O_WT_R_Validation_MR = [Ensemble_O_WT_R_Validation_MR,missrate_o_rwt_e];
        Ensemble_Y_WOT_R_Validation_P = [Ensemble_Y_WOT_R_Validation_P,prevalence_y_rwot_e];
        Ensemble_O_WOT_R_Validation_P = [Ensemble_O_WOT_R_Validation_P,prevalence_o_rwot_e];
        Ensemble_Y_WT_R_Validation_P = [Ensemble_Y_WT_R_Validation_P,prevalence_y_rwt_e];
        Ensemble_O_WT_R_Validation_P = [Ensemble_O_WT_R_Validation_P,prevalence_o_rwt_e];
        Ensemble_Y_WOT_R_Validation_Pr = [Ensemble_Y_WOT_R_Validation_Pr pr_y_rwot_e'];
        Ensemble_O_WOT_R_Validation_Pr = [Ensemble_O_WOT_R_Validation_Pr pr_o_rwot_e'];
        Ensemble_Y_WT_R_Validation_Pr = [Ensemble_Y_WT_R_Validation_Pr pr_y_rwt_e'];
        Ensemble_O_WT_R_Validation_Pr = [Ensemble_O_WT_R_Validation_Pr pr_o_rwt_e'];
        Ensemble_Y_WOT_R_Validation_GT = [Ensemble_Y_WOT_R_Validation_GT gt_y_rwot_e'];
        Ensemble_O_WOT_R_Validation_GT = [Ensemble_O_WOT_R_Validation_GT gt_o_rwot_e'];
        Ensemble_Y_WT_R_Validation_GT = [Ensemble_Y_WT_R_Validation_GT gt_y_rwt_e'];
        Ensemble_O_WT_R_Validation_GT = [Ensemble_O_WT_R_Validation_GT gt_o_rwt_e'];
        SVM_Y_WOT_R_Validation_FAR = [SVM_Y_WOT_R_Validation_FAR,falsealarm_y_rwot_svm];
        SVM_O_WOT_R_Validation_FAR = [SVM_O_WOT_R_Validation_FAR,falsealarm_o_rwot_svm];
        SVM_Y_WT_R_Validation_FAR = [SVM_Y_WT_R_Validation_FAR,falsealarm_y_rwt_svm];
        SVM_O_WT_R_Validation_FAR = [SVM_O_WT_R_Validation_FAR,falsealarm_o_rwt_svm];
        SVM_Y_WOT_R_Validation_MR = [SVM_Y_WOT_R_Validation_MR,missrate_y_rwot_svm];
        SVM_O_WOT_R_Validation_MR = [SVM_O_WOT_R_Validation_MR,missrate_o_rwot_svm];
        SVM_Y_WT_R_Validation_MR = [SVM_Y_WT_R_Validation_MR,missrate_y_rwt_svm];
        SVM_O_WT_R_Validation_MR = [SVM_O_WT_R_Validation_MR,missrate_o_rwt_svm];
        SVM_Y_WOT_R_Validation_P = [SVM_Y_WOT_R_Validation_P,prevalence_y_rwot_svm];
        SVM_O_WOT_R_Validation_P = [SVM_O_WOT_R_Validation_P,prevalence_o_rwot_svm];
        SVM_Y_WT_R_Validation_P = [SVM_Y_WT_R_Validation_P,prevalence_y_rwt_svm];
        SVM_O_WT_R_Validation_P = [SVM_O_WT_R_Validation_P,prevalence_o_rwt_svm];  
        SVM_Y_WOT_R_Validation_Pr = [SVM_Y_WOT_R_Validation_Pr pr_y_rwot_svm'];
        SVM_O_WOT_R_Validation_Pr = [SVM_O_WOT_R_Validation_Pr pr_o_rwot_svm'];
        SVM_Y_WT_R_Validation_Pr = [SVM_Y_WT_R_Validation_Pr pr_y_rwt_svm'];
        SVM_O_WT_R_Validation_Pr = [SVM_O_WT_R_Validation_Pr pr_o_rwt_svm'];    
        SVM_Y_WOT_R_Validation_GT = [SVM_Y_WOT_R_Validation_GT gt_y_rwot_svm'];
        SVM_O_WOT_R_Validation_GT = [SVM_O_WOT_R_Validation_GT gt_o_rwot_svm'];
        SVM_Y_WT_R_Validation_GT = [SVM_Y_WT_R_Validation_GT gt_y_rwt_svm'];
        SVM_O_WT_R_Validation_GT = [SVM_O_WT_R_Validation_GT gt_o_rwt_svm'];    
        LD_Y_WOT_R_Validation_FAR = [LD_Y_WOT_R_Validation_FAR,falsealarm_y_rwot_l];
        LD_O_WOT_R_Validation_FAR = [LD_O_WOT_R_Validation_FAR,falsealarm_o_rwot_l];
        LD_Y_WT_R_Validation_FAR = [LD_Y_WT_R_Validation_FAR,falsealarm_y_rwt_l];
        LD_O_WT_R_Validation_FAR = [LD_O_WT_R_Validation_FAR,falsealarm_o_rwt_l];
        LD_Y_WOT_R_Validation_MR = [LD_Y_WOT_R_Validation_MR,missrate_y_rwot_l];
        LD_O_WOT_R_Validation_MR = [LD_O_WOT_R_Validation_MR,missrate_o_rwot_l];
        LD_Y_WT_R_Validation_MR = [LD_Y_WT_R_Validation_MR,missrate_y_rwt_l];
        LD_O_WT_R_Validation_MR = [LD_O_WT_R_Validation_MR,missrate_o_rwt_l];
        LD_Y_WOT_R_Validation_P = [LD_Y_WOT_R_Validation_P,prevalence_y_rwot_l];
        LD_O_WOT_R_Validation_P = [LD_O_WOT_R_Validation_P,prevalence_o_rwot_l];
        LD_Y_WT_R_Validation_P = [LD_Y_WT_R_Validation_P,prevalence_y_rwt_l];
        LD_O_WT_R_Validation_P = [LD_O_WT_R_Validation_P,prevalence_o_rwt_l];
        LD_Y_WOT_R_Validation_Pr = [LD_Y_WOT_R_Validation_Pr pr_y_rwot_l'];
        LD_O_WOT_R_Validation_Pr = [LD_O_WOT_R_Validation_Pr pr_o_rwot_l'];
        LD_Y_WT_R_Validation_Pr = [LD_Y_WT_R_Validation_Pr pr_y_rwt_l'];
        LD_O_WT_R_Validation_Pr = [LD_O_WT_R_Validation_Pr pr_o_rwt_l'];
        LD_Y_WOT_R_Validation_GT = [LD_Y_WOT_R_Validation_GT gt_y_rwot_l'];
        LD_O_WOT_R_Validation_GT = [LD_O_WOT_R_Validation_GT gt_o_rwot_l'];
        LD_Y_WT_R_Validation_GT = [LD_Y_WT_R_Validation_GT gt_y_rwt_l'];
        LD_O_WT_R_Validation_GT = [LD_O_WT_R_Validation_GT gt_o_rwt_l'];
        
        % repeat for each feature
        if strcmp(OnlyReducedRun,'FALSE')
            for jj=1:46
                % extact one feature and label
                [om, ~] = size(vector_O_WT);
                [ym, ~] = size(vector_Y_WT);
                vector_O_onefeat = zeros(om,2);
                vector_Y_onefeat = zeros(ym,2);
                vector_O_onefeat(:,1) = vector_O_WT(:,jj);vector_O_onefeat(:,2) = vector_O_WT(:,47);
                vector_Y_onefeat(:,1) = vector_Y_WT(:,jj);vector_Y_onefeat(:,2) = vector_Y_WT(:,47);

                % run models
                [O_F_SVM_Trainer, O_F_SVMvalidationAccuracy] = trainMLClassifier(vector_O_onefeat(1:o_ds,:),"SVM",1);
                if strcmp(P50,'TRUE')
                    O_F_SVMvalidationAccuracy = Mpredict(O_F_SVM_Trainer, vector_O_onefeat((o_ds+1):end,:));
                end
                [Y_F_SVM_Trainer, Y_F_SVMvalidationAccuracy] = trainMLClassifier(vector_Y_onefeat(1:y_ds,:),"SVM",1);
                if strcmp(P50,'TRUE')
                    Y_F_SVMvalidationAccuracy = Mpredict(Y_F_SVM_Trainer, vector_Y_onefeat((y_ds+1):end,:));
                end
                [O_F_LD_Trainer, O_F_LDvalidationAccuracy] = trainMLClassifier(vector_O_onefeat(1:o_ds,:),"LD",1);
                if strcmp(P50,'TRUE')
                    O_F_LDvalidationAccuracy = Mpredict(O_F_LD_Trainer, vector_O_onefeat((o_ds+1):end,:));
                end
                [Y_F_LD_Trainer, Y_F_LDvalidationAccuracy] = trainMLClassifier(vector_Y_onefeat(1:y_ds,:),"LD",1);
                if strcmp(P50,'TRUE')
                    Y_F_LDvalidationAccuracy = Mpredict(Y_F_LD_Trainer, vector_Y_onefeat((y_ds+1):end,:));
                end
                [O_F_Ensemble_Trainer, O_F_EnsemblevalidationAccuracy] = trainMLClassifier(vector_O_onefeat(1:o_ds,:),"Ensemble",1);
                if strcmp(P50,'TRUE')
                    O_F_EnsemblevalidationAccuracy = Mpredict(O_F_Ensemble_Trainer, vector_O_onefeat((o_ds+1):end,:));
                end
                [Y_F_Ensemble_Trainer, Y_F_EnsemblevalidationAccuracy] = trainMLClassifier(vector_Y_onefeat(1:y_ds,:),"Ensemble",1);
                if strcmp(P50,'TRUE')
                    Y_F_EnsemblevalidationAccuracy = Mpredict(Y_F_Ensemble_Trainer, vector_Y_onefeat((y_ds+1):end,:));            
                end

                % update results
                SVM_Y_OF_Validation_ACC = [SVM_Y_OF_Validation_ACC, Y_F_SVMvalidationAccuracy];
                SVM_O_OF_Validation_ACC = [SVM_O_OF_Validation_ACC, O_F_SVMvalidationAccuracy];
                LD_Y_OF_Validation_ACC = [LD_Y_OF_Validation_ACC, Y_F_LDvalidationAccuracy];
                LD_O_OF_Validation_ACC = [LD_O_OF_Validation_ACC, O_F_LDvalidationAccuracy];
                Ensemble_Y_OF_Validation_ACC = [Ensemble_Y_OF_Validation_ACC, Y_F_EnsemblevalidationAccuracy];
                Ensemble_O_OF_Validation_ACC = [Ensemble_O_OF_Validation_ACC, O_F_EnsemblevalidationAccuracy];
            end

            % update results per stage
            SVM_O_per_feature_validation_accuracy{1,ii} = SVM_O_OF_Validation_ACC;
            SVM_Y_per_feature_validation_accuracy{1,ii} = SVM_Y_OF_Validation_ACC;
            LD_O_per_feature_validation_accuracy{1,ii} = LD_O_OF_Validation_ACC;
            LD_Y_per_feature_validation_accuracy{1,ii} = LD_Y_OF_Validation_ACC;
            Ensemble_O_per_feature_validation_accuracy{1,ii} = Ensemble_O_OF_Validation_ACC;
            Ensemble_Y_per_feature_validation_accuracy{1,ii} = Ensemble_Y_OF_Validation_ACC;
        end

        % finally clear the following and increase the ind_stage
        % ind_stage = ind_stage + 1
        clear ind_blasto_Y_stage vector_Y vector_Y_WT vector_Y_WOT vector_Y_WT_R vector_Y_WOT_R
        clear ind_blasto_O_stage vector_O vector_O_WT vector_O_WOT vector_O_WT_R vector_O_WOT_R
    end
    
    if strcmp(OnlyReducedRun,'FALSE')
        % save the acc variables
        vsave = 'ALL_Nov_ACC_NN' + string(rn) + '.mat';
        save(vsave,...
            'SVM_O_per_feature_validation_accuracy',...
            'SVM_Y_per_feature_validation_accuracy',...
            'LD_O_per_feature_validation_accuracy',...
            'LD_Y_per_feature_validation_accuracy',...
            'Ensemble_O_per_feature_validation_accuracy',...
            'Ensemble_Y_per_feature_validation_accuracy',...
            'SVM_Y_WT_Validation_ACC',...
            'SVM_Y_WOT_Validation_ACC',...
            'SVM_O_WT_Validation_ACC',...
            'SVM_O_WOT_Validation_ACC',...
            'Ensemble_Y_WT_Validation_ACC',...
            'Ensemble_O_WT_Validation_ACC',...
            'Ensemble_Y_WOT_Validation_ACC',...
            'Ensemble_O_WOT_Validation_ACC',...
            'SVM_Y_WT_R_Validation_ACC',...
            'SVM_Y_WOT_R_Validation_ACC',...
            'SVM_O_WT_R_Validation_ACC',...
            'SVM_O_WOT_R_Validation_ACC',...
            'LD_Y_WT_R_Validation_ACC',...
            'LD_Y_WOT_R_Validation_ACC',...
            'LD_O_WT_R_Validation_ACC',...
            'LD_O_WOT_R_Validation_ACC',...
            'Ensemble_Y_WT_R_Validation_ACC',...
            'Ensemble_O_WT_R_Validation_ACC',...
            'Ensemble_Y_WOT_R_Validation_ACC',...
            'Ensemble_O_WOT_R_Validation_ACC')
    else
        % save the acc variables: only time or reduced
        vsave = 'R_onlyT_100run_NOV_ACC_NN' + string(rn) + '.mat';
        save(vsave,...
            'SVM_Y_WT_R_Validation_ACC',...
            'SVM_Y_WOT_R_Validation_ACC',...
            'SVM_O_WT_R_Validation_ACC',...
            'SVM_O_WOT_R_Validation_ACC',...
            'LD_Y_WT_R_Validation_ACC',...
            'LD_Y_WOT_R_Validation_ACC',...
            'LD_O_WT_R_Validation_ACC',...
            'LD_O_WOT_R_Validation_ACC',...
            'Ensemble_Y_WT_R_Validation_ACC',...
            'Ensemble_O_WT_R_Validation_ACC',...
            'Ensemble_Y_WOT_R_Validation_ACC',...
            'Ensemble_O_WOT_R_Validation_ACC',...
            'SVM_Y_WT_R_Validation_FAR',...
            'SVM_Y_WOT_R_Validation_FAR',...
            'SVM_O_WT_R_Validation_FAR',...
            'SVM_O_WOT_R_Validation_FAR',...
            'LD_Y_WT_R_Validation_FAR',...
            'LD_Y_WOT_R_Validation_FAR',...
            'LD_O_WT_R_Validation_FAR',...
            'LD_O_WOT_R_Validation_FAR',...
            'Ensemble_Y_WT_R_Validation_FAR',...
            'Ensemble_O_WT_R_Validation_FAR',...
            'Ensemble_Y_WOT_R_Validation_FAR',...
            'Ensemble_O_WOT_R_Validation_FAR',...
            'SVM_Y_WT_R_Validation_MR',...
            'SVM_Y_WOT_R_Validation_MR',...
            'SVM_O_WT_R_Validation_MR',...
            'SVM_O_WOT_R_Validation_MR',...
            'LD_Y_WT_R_Validation_MR',...
            'LD_Y_WOT_R_Validation_MR',...
            'LD_O_WT_R_Validation_MR',...
            'LD_O_WOT_R_Validation_MR',...
            'Ensemble_Y_WT_R_Validation_MR',...
            'Ensemble_O_WT_R_Validation_MR',...
            'Ensemble_Y_WOT_R_Validation_MR',...
            'Ensemble_O_WOT_R_Validation_MR',...
            'SVM_Y_WT_R_Validation_P',...
            'SVM_Y_WOT_R_Validation_P',...
            'SVM_O_WT_R_Validation_P',...
            'SVM_O_WOT_R_Validation_P',...
            'LD_Y_WT_R_Validation_P',...
            'LD_Y_WOT_R_Validation_P',...
            'LD_O_WT_R_Validation_P',...
            'LD_O_WOT_R_Validation_P',...
            'Ensemble_Y_WT_R_Validation_P',...
            'Ensemble_O_WT_R_Validation_P',...
            'Ensemble_Y_WOT_R_Validation_P',...
            'Ensemble_O_WOT_R_Validation_P',...
            'SVM_Y_WT_R_Validation_Pr',...
            'SVM_Y_WOT_R_Validation_Pr',...
            'SVM_O_WT_R_Validation_Pr',...
            'SVM_O_WOT_R_Validation_Pr',...
            'LD_Y_WT_R_Validation_Pr',...
            'LD_Y_WOT_R_Validation_Pr',...
            'LD_O_WT_R_Validation_Pr',...
            'LD_O_WOT_R_Validation_Pr',...
            'Ensemble_Y_WT_R_Validation_Pr',...
            'Ensemble_O_WT_R_Validation_Pr',...
            'Ensemble_Y_WOT_R_Validation_Pr',...
            'Ensemble_O_WOT_R_Validation_Pr',...
            'SVM_Y_WT_R_Validation_GT',...
            'SVM_Y_WOT_R_Validation_GT',...
            'SVM_O_WT_R_Validation_GT',...
            'SVM_O_WOT_R_Validation_GT',...
            'LD_Y_WT_R_Validation_GT',...
            'LD_Y_WOT_R_Validation_GT',...
            'LD_O_WT_R_Validation_GT',...
            'LD_O_WOT_R_Validation_GT',...
            'Ensemble_Y_WT_R_Validation_GT',...
            'Ensemble_O_WT_R_Validation_GT',...
            'Ensemble_Y_WOT_R_Validation_GT',...
            'Ensemble_O_WOT_R_Validation_GT')
    end
end
% indication models run done
disp('models run is end')

%% Baseline: 103 total (Young 62, Old 41)
BT = 0.5;
YE = [62,62,62,62,61,57,46]; %1-cell to FB
OE = [41,41,41,39,39,33,27]; %1-cell to FB
YRa = [0.7419,0.7419,0.7419,0.7419,0.7541,0.8070];
ORa = [0.6585,0.6585,0.6585,0.6923,0.6923,0.8182];
%Y_final_baseline = YRa*BT;
%O_final_baseline = ORa*BT;
Y_final_baseline = YRa;
O_final_baseline = ORa;
Y_final_baseline_rcell_eb = Y_final_baseline(2:end)
O_final_baseline_rcell_eb = O_final_baseline(2:end);

B_F_Y = 1./Y_final_baseline_rcell_eb - 1;
B_F_O = 1./O_final_baseline_rcell_eb - 1;
% MR
B_MR = 0;
% Pre
B_P_Y = Y_final_baseline_rcell_eb;
B_P_O = O_final_baseline_rcell_eb;

save('baseline_acc.mat', 'Y_final_baseline_rcell_eb', 'O_final_baseline_rcell_eb', 'B_F_Y', 'B_F_O', 'B_P_Y', 'B_P_O', 'B_MR');

%% Plots
% plot SVM results - all features
name_2_cell = {'2-cell', '4-cell', '8-cell','Morula','Early Blastocyst'};
xt = [0:4];
if strcmp(OnlyReducedRun,'FALSE')
    figure(1);
    plot(xt,SVM_Y_WT_Validation_ACC,'b-o',xt,SVM_Y_WOT_Validation_ACC,'b--',xt,SVM_O_WT_Validation_ACC,'r-*',xt,SVM_O_WOT_Validation_ACC,'r--')
    ylabel('Classification model validation accuracy [%]')
    xlabel('Embryo stage')
    legend({'Y w/ Time','Y w/o Time','O w/ Time','O w/o Time'},'location','best');
    title('ML-SVM Model - All 46 features')
    Set_fig_YS(gca,14,14,14)
    set(gca,'xtick',xt,'xticklabel',name_2_cell)
    set(gca,'XTickLabelRotation',-30)
end
% recuded
figure(2);
plot(xt,SVM_Y_WT_R_Validation_ACC,'b-o',xt,SVM_Y_WOT_R_Validation_ACC,'b--',xt,SVM_O_WT_R_Validation_ACC,'r-*',xt,SVM_O_WOT_R_Validation_ACC,'r--')
ylabel('Classification model validation accuracy [%]')
xlabel('Embryo stage')
legend({'Y w/ Time','Y w/o Time','O w/ Time','O w/o Time'},'location','best');
title('ML-SVM Model - Reduced features')
Set_fig_YS(gca,14,14,14)
set(gca,'xtick',xt,'xticklabel',name_2_cell)
set(gca,'XTickLabelRotation',-30)

% plot Ensemble results - all features
if strcmp(OnlyReducedRun,'FALSE')
    figure(3);
    plot(xt,Ensemble_Y_WT_Validation_ACC,'b-o',xt,Ensemble_Y_WOT_Validation_ACC,'b--',xt,Ensemble_O_WT_Validation_ACC,'r-*',xt,Ensemble_O_WOT_Validation_ACC,'r--')
    ylabel('Classification model validation accuracy [%]')
    xlabel('Embryo stage')
    legend({'Y w/ Time','Y w/o Time','O w/ Time','O w/o Time'},'location','best');
    title('ML-Ensemble Model - All 46 features')
    Set_fig_YS(gca,14,14,14)
    set(gca,'xtick',xt,'xticklabel',name_2_cell)
    set(gca,'XTickLabelRotation',-30)
end
% reduced
figure(4);
plot(xt,Ensemble_Y_WT_R_Validation_ACC,'b-o',xt,Ensemble_Y_WOT_R_Validation_ACC,'b--',xt,Ensemble_O_WT_R_Validation_ACC,'r-*',xt,Ensemble_O_WOT_R_Validation_ACC,'r--')
ylabel('Classification model validation accuracy [%]')
xlabel('Embryo stage')
legend({'Y w/ Time','Y w/o Time','O w/ Time','O w/o Time'},'location','best');
title('ML-Ensemble Model - Reduced features')
Set_fig_YS(gca,14,14,14)
set(gca,'xtick',xt,'xticklabel',name_2_cell)
set(gca,'XTickLabelRotation',-30)

figure(5);
subplot(121);
plot(xt,SVM_Y_WT_R_Validation_ACC,'r--',xt,LD_Y_WT_R_Validation_ACC,'r-o',xt,Ensemble_Y_WT_R_Validation_ACC,'r-*',xt,SVM_Y_WOT_R_Validation_ACC,'b--',xt,LD_Y_WOT_R_Validation_ACC,'b-o',xt,Ensemble_Y_WOT_R_Validation_ACC,'b-*')
ylabel('Classification model validation accuracy [%]')
xlabel('Embryo stage')
legend({'SVM w/ Time','LD w/ Time','Ensemble w/ Time','SVM w/o Time','LD w/o Time','Ensemble w/o Time'},'location','best');
title('Young embryos - Reduced features')
Set_fig_YS(gca,14,14,14)
set(gca,'xtick',xt,'xticklabel',name_2_cell)
set(gca,'XTickLabelRotation',-30)
subplot(122);
plot(xt,SVM_O_WT_R_Validation_ACC,'r--',xt,LD_O_WT_R_Validation_ACC,'r-o',xt,Ensemble_O_WT_R_Validation_ACC,'r-*',xt,SVM_O_WOT_R_Validation_ACC,'b--',xt,LD_O_WOT_R_Validation_ACC,'b-o',xt,Ensemble_O_WOT_R_Validation_ACC,'b-*')
ylabel('Classification model validation accuracy [%]')
xlabel('Embryo stage')
legend({'SVM w/ Time','LD w/ Time','Ensemble w/ Time','SVM w/o Time','LD w/o Time','Ensemble w/o Time'},'location','best');
title('Old embryos - Reduced features')
Set_fig_YS(gca,14,14,14)
set(gca,'xtick',xt,'xticklabel',name_2_cell)
set(gca,'XTickLabelRotation',-30)

% Option to select best features (instead of KL or GLR)
if strcmp(OnlyReducedRun,'FALSE')
    figure(6);
    plot(1:46,Ensemble_Y_per_feature_validation_accuracy{1,4})
    ylabel('Classification model validation accuracy [%]')
    title('ML-Ensemble Model - Young - 8 cell')
    hold on
    thd_line = repelem(mean(Ensemble_Y_per_feature_validation_accuracy{1,4})*1.02,46);
    plot(1:46,thd_line,'r--')
    xlabel('46 morp features')
    xlim([1 46])
end

%% plot extra figures
if strcmp(OnlyReducedRun,'FALSE')
    for cnt_stage = 1:5   
        M(:,cnt_stage) = Ensemble_O_per_feature_validation_accuracy{cnt_stage}';
        figure(10)
        subplot(1,6,cnt_stage)
        barh(M(:,cnt_stage))
        %ylim([0.5 1])
    end
    figure(11)
    heatmap(M);colormap('jet')

    figure(12)
    b = bar3(M')
    for k = 1:length(b)
        zdata = b(k).ZData;
        b(k).CData = zdata;
        b(k).FaceColor = 'interp';
    end
end
% save figures
saveFigs('paper_morp_res');