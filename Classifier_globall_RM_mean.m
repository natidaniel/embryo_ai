% global classifier for reduced morp
for i  = 1:length(ind_blasto_Y)
    [n_prop,n_stage] = size(data_Y{i});
    switch n_stage
        case 1
            for j=1:n_prop
                vector_Y(i,j) = data_Y{i}(j,n_stage);
            end
        case 2
            for j=1:n_prop
                vector_Y(i,j) = data_Y{i}(j,n_stage);
            end     
        case 3
            for j=1:n_prop
                vector_Y(i,j) = mean(data_Y{i}(j,1:n_stage));
            end
        case 4
            for j=1:n_prop
                vector_Y(i,j) = mean(data_Y{i}(j,1:n_stage));
            end
        case 5
            for j=1:n_prop
                vector_Y(i,j) = mean(data_Y{i}(j,1:n_stage));
            end
        case 6    
            for j=1:n_prop
                vector_Y(i,j) = mean(data_Y{i}(j,1:n_stage));
            end
        case 7
            for j=1:n_prop
                vector_Y(i,j) = mean(data_Y{i}(j,1:6));
            end  
    end   
end

vector_Y(:,8) = ind_blasto_Y;