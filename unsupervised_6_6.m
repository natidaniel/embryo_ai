% unsupervised learning models for Blastocyst potential
% based on Embryo stage

% inputs: data_O, data_Y
% outputs: vector_O_S, vector_Y_S

clear ind_blasto_Y_stage vector_Y vector_Y_S
clear ind_blasto_O_stage vector_O vector_O_S

ind_stage = 1; % till 6
UseTimeMorp = 'TRUE'; % 'FALSE'


if ind_stage == 1
   load('C:/Nati/Embryos/4Yoni/data/machine_morp_data_10Y_8O.mat');
   %morp_list_y = {'Area','AutoCorr','Correlation','Varinace','Smoothness','SumAverage','Roundness','LPspectrumFilter','TextureSkewness','Time'};
   %morp_list_o = {'Area','AutoCorr','Varinace','SumAverage','DWS','HPspectrumFilter','TextureSkewness','Time'};
end

% if you are not starting from ind_satge=1, you need to run only once the...
% reduce_data_dim_time and then don't repeat running the reduce_data_dim_time.
% better to start with ind_stage == 1.
% this condition is to protet you will change the data
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
    vector_O_S = vector_O; vector_O_S(:,9) = ind_blasto_O_stage;
    vector_Y_S = vector_Y; vector_Y_S(:,11) = ind_blasto_Y_stage;
else
    vector_O_S = vector_O; vector_O_S(:,8) = ind_blasto_O_stage;
    vector_Y_S = vector_Y; vector_Y_S(:,10) = ind_blasto_Y_stage; 
end