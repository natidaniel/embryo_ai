function [data_O_A,data_Y_A] = reduce_data_dim(data_O,data_Y)
% Calculate mean embryosstats matrices 
% data_O
for i=1:length(data_O)
    [dr,dc] = size(data_O{1,i});
    u = unique(data_O{1,i}(dr,:));
    data_O_A{1,i} = zeros(dr,length(u)); 
    for j=1:length(u);
        s = (find(data_O{1,i}(dr,:) == u(j)));
        f = s(1);
        e = s(end);
        for r=1:dr
            data_O_A{1,i}(r,j) = mean(data_O{1,i}(r,f:e));
        end
    end
end

%data_Y
for i=1:length(data_Y)
    [dr,dc] = size(data_Y{1,i});
    u = unique(data_Y{1,i}(dr,:));
    data_Y_A{1,i} = zeros(dr,length(u)); 
    for j=1:length(u);
        s = (find(data_Y{1,i}(dr,:) == u(j)));
        f = s(1);
        e = s(end);
        for r=1:dr
            data_Y_A{1,i}(r,j) = mean(data_Y{1,i}(r,f:e));
        end
    end
end
end