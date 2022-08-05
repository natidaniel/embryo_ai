% data w/o developmental time indication
% for globabal classifier - for all the stages
[data_O_A,data_Y_A,ind_blasto_Y,ind_blasto_O] = reduce_data_dim_time(data_O,data_Y);

for i  = 1:length(ind_blasto_Y)
    data_Y_A{i}=data_Y_A{i}(1:5,:);
end

for i  = 1:length(ind_blasto_O)
    data_O_A{i}=data_O_A{i}(1:6,:);
end

% Using it for global classifier for 26 morps
for ind_stage = 1:6
    k=1;
    for i  = 1:length(ind_blasto_Y)
        [n_prop,n_stage] = size(data_Y_A{i});
        if n_stage>=ind_stage;
            vector_Y(k,:) = data_Y_A{i}(:,ind_stage);
            ind_blasto_Y_stage(k) = ind_blasto_Y(i);
            k=k+1;
        end
    end
    
    k=1;
    for i  = 1:length(ind_blasto_O)
        [n_prop,n_stage] = size(data_O_A{i});
        if n_stage>=ind_stage;
            vector_O(k,:) = data_O_A{i}(:,ind_stage);
            ind_blasto_O_stage(k) = ind_blasto_O(i);
            k=k+1;
        end
    end
    % normalize along embryo
    [n,m] = size(vector_Y);
    E = repmat(mean(vector_Y),[n 1]);
    s = repmat(std(vector_Y),[n 1]);
    vector_Y = (vector_Y - E)./s;
    
    [n,m] = size(vector_O);
    E = repmat(mean(vector_O),[n 1]);
    s = repmat(std(vector_O),[n 1]);
    vector_O = (vector_O - E)./s;
    
end

    
vector_O_S = vector_O; vector_O_S(:,7) = ind_blasto_O_stage;
vector_Y_S = vector_Y; vector_Y_S(:,6) = ind_blasto_Y_stage;