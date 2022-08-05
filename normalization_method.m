function [data_O,data_Y] = normalization_method(data_O,data_Y,method)
if (method == 's')
    % standardisation
    % data_O
    for i=1:length(data_O)
        [dr,dc] = size(data_O{1,i});
        for r=1:dr
            m = mean(data_O{1,i}(r,:));
            s = std(data_O{1,i}(r,:));
            for j=1:dc
                data_O{1,i}(r,j) = (data_O{1,i}(r,j) - m) / s;
            end
        end
    end
    % data_Y
    for i=1:length(data_Y)
        [dr,dc] = size(data_Y{1,i});
        for r=1:dr
            m = mean(data_Y{1,i}(r,:));
            s = std(data_Y{1,i}(r,:));
            for j=1:dc
                data_Y{1,i}(r,j) = (data_Y{1,i}(r,j) - m) / s;
            end
        end
    end
end
if (method == 'uv')
    % unit vector
    % data_O
    for i=1:length(data_O)
        [dr,dc] = size(data_O{1,i});
        for r=1:dr
            n = norm(data_O{1,i}(r,:),2); %norm2
            for j=1:dc
                data_O{1,i}(r,j) = data_O{1,i}(r,j) / n;
            end
        end
    end
    % data_Y
    for i=1:length(data_Y)
        [dr,dc] = size(data_Y{1,i});
        for r=1:dr
            n = norm(data_Y{1,i}(r,:),2);
            for j=1:dc
                data_Y{1,i}(r,j) = data_Y{1,i}(r,j) / n;
            end
        end
    end
end
if (method == 'mn')
    % mean normalization
    % data_O
    for i=1:length(data_O)
        [dr,dc] = size(data_O{1,i});
        for r=1:dr
            m = mean(data_O{1,i}(r,:));
            max_r = max(data_O{1,i}(r,:));
            min_r = min(data_O{1,i}(r,:));
            for j=1:dc
                data_O{1,i}(r,j) = (data_O{1,i}(r,j) - m) / (max_r-min_r);
            end
        end
    end
    % data_Y
    for i=1:length(data_Y)
        [dr,dc] = size(data_Y{1,i});
        for r=1:dr
            m = mean(data_Y{1,i}(r,:));
            max_r = max(data_Y{1,i}(r,:));
            min_r = min(data_Y{1,i}(r,:));
            for j=1:dc
                data_Y{1,i}(r,j) = (data_Y{1,i}(r,j) - m) / (max_r-min_r);
            end
        end
    end
end
end