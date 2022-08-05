function [data_O_A,data_Y_A,ind_blasto_Y,ind_blasto_O] = reduce_data_dim_time(data_O,data_Y)
% Calculate mean embryosstats matrices 
% data_O
for i=1:length(data_O)
    [dr,dc] = size(data_O{1,i});
    u = unique(data_O{1,i}(dr,:));
    % find if embryo reached blastocyte stage
    if (length(u) < 7)
        ind_blasto_O(i) = 0;
    else
        ind_blasto_O(i) = 1;
    end
    data_O_A{1,i} = zeros(dr,length(u)); 
    for j=1:length(u);
        s = (find(data_O{1,i}(dr,:) == u(j)));
        f = s(1);
        e = s(end);
        for r=1:dr
            data_O_A{1,i}(r,j) = mean(data_O{1,i}(r,f:e));
        end
        data_O_A{1,i}(dr,j) = e;
    end
end

%data_Y
for i=1:length(data_Y)
    [dr,dc] = size(data_Y{1,i});
    u = unique(data_Y{1,i}(dr,:));
     % find if embryo reached blastocyte stage
    if (length(u) < 7)
        ind_blasto_Y(i) = 0;
    else
        ind_blasto_Y(i) = 1;
    end   
    data_Y_A{1,i} = zeros(dr,length(u)); 
    for j=1:length(u);
        s = (find(data_Y{1,i}(dr,:) == u(j)));
        f = s(1);
        e = s(end);
        for r=1:dr
            data_Y_A{1,i}(r,j) = mean(data_Y{1,i}(r,f:e));
        end
        data_Y_A{1,i}(dr,j) = e;
    end
end
end