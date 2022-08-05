clear ind_blasto_Y_stage_RS vector_Y_RS

for ind_stage = 2
    k=1;
    for i  = 1:length(ind_blasto_Y)
        [n_prop,n_stage] = size(data_Y_RS{i});
        if n_stage>=ind_stage
            vector_Y_RS(k,:) = data_Y_RS{i}(:,ind_stage);
            ind_blasto_Y_stage_RS(k) = ind_blasto_Y(i);
            k=k+1;
        end    
    end
end

vector_Y_RS(:,7) = ind_blasto_Y_stage_RS;
save C_5_Y vector_Y_RS