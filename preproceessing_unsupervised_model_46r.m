% unsupervised learning models for Blastocyst potential
% based on Embryo stage

% inputs: data_O, data_Y
% outputs: vector_O_S, vector_Y_S

clear ind_blasto_Y_stage ind_blasto_O_stage vector_Y vector_Y_S
clear ind_blasto_O_stage ind_blasto_O_stage vector_O vector_O_S

ind_stage = 1;
UseTimeMorp = 'TRUE'; % 'FALSE'
UseM_D_46_O_Y_ReducedMorpData = 'FALSE';
UseM_D_46_4_O_Y_ReducedMorpData = 'TRUE';

if ind_stage == 1
    if strcmp(UseM_D_46_O_Y_ReducedMorpData,'TRUE')
        load('data_OY_46.mat'); %19/9
    end
    if strcmp(UseM_D_46_4_O_Y_ReducedMorpData,'TRUE')
        load('data_OY_46_4.mat');
    end
end

% if you are not starting from ind_satge=1, you need to run only once the...
% reduce_data_dim_time and then don't repeat running the reduce_data_dim_time.
% better to start with ind_stage == 1.
% this condition is protet you dont change the data
if ind_stage == 1 
    [data_O,data_Y,ind_blasto_Y,ind_blasto_O] = reduce_data_dim_time(data_O,data_Y);% create ind_blasto
end
 
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

if strcmp(UseTimeMorp,'TRUE')
    if strcmp(UseM_D_46_O_Y_ReducedMorpData,'TRUE')
        vector_O_S = vector_O; vector_O_S(:,10) = ind_blasto_O_stage;
        vector_Y_S = vector_Y; vector_Y_S(:,20) = ind_blasto_Y_stage;
    end
    if strcmp(UseM_D_46_4_O_Y_ReducedMorpData,'TRUE')
        vector_O_S = vector_O; vector_O_S(:,9) = ind_blasto_O_stage;
        vector_Y_S = vector_Y; vector_Y_S(:,10) = ind_blasto_Y_stage;
    end    
else
    if strcmp(UseM_D_46_O_Y_ReducedMorpData,'TRUE')
        vector_O_S = vector_O; vector_O_S(:,9) = ind_blasto_O_stage;
        vector_Y_S = vector_Y; vector_Y_S(:,19) = ind_blasto_Y_stage;
    end
    if strcmp(UseM_D_46_4_O_Y_ReducedMorpData,'TRUE')
        vector_O_S = vector_O; vector_O_S(:,8) = ind_blasto_O_stage;
        vector_Y_S = vector_Y; vector_Y_S(:,9) = ind_blasto_Y_stage;
    end  
end