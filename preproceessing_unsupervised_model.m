% unsupervised learning models for Blastocyst potential
% based on Embryo stage

% inputs: data_O, data_Y
% outputs: vector_O_S, vector_Y_S

clear ind_blasto_Y_stage ind_blasto_O_stage vector_Y vector_Y_S
clear ind_blasto_O_stage ind_blasto_O_stage vector_O vector_O_S

UseTimeMorp = 'FALSE'; % DEFAULT = 'TRUE'

ind_stage = 6;

% if you are not starting from ind_satge=1, ... 
% you need to create original data_O and data_Y and rerun each time the reduce_data_dim_time
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
    vector_O_S = vector_O; vector_O_S(:,8) = ind_blasto_O_stage;
    vector_Y_S = vector_Y; vector_Y_S(:,7) = ind_blasto_Y_stage;
else
    vector_O_S = vector_O; vector_O_S(:,7) = ind_blasto_O_stage;
    vector_Y_S = vector_Y; vector_Y_S(:,6) = ind_blasto_Y_stage;
end