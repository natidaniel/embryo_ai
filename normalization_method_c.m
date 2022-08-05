function [data_O,data_Y] = normalization_method_c(data_O,data_Y,method)
if (method == 's')
    % standardisation
    % data_O
    for i=1:length(data_O)
        [dr,dc] = size(data_O{1,i});
        for c=1:dc
            m = mean(data_O{1,i}(:,c));
            s = std(data_O{1,i}(:,c));
            for j=1:dr
                data_O{1,i}(j,c) = (data_O{1,i}(j,c) - m) / s;
            end
        end
    end
    % data_Y
    for i=1:length(data_Y)
        [dr,dc] = size(data_Y{1,i});
        for c=1:dc
            m = mean(data_Y{1,i}(:,c));
            s = std(data_Y{1,i}(:,c));
            for j=1:dr
                data_Y{1,i}(j,c) = (data_Y{1,i}(j,c) - m) / s;
            end
        end
    end
end
if (method == 'uv')
    % unit vector
    % data_O
    for i=1:length(data_O)
        [dr,dc] = size(data_O{1,i});
        for c=1:dc
            n = norm(data_O{1,i}(:,c),2); %norm2
            for j=1:dr
                data_O{1,i}(j,c) = data_O{1,i}(j,c) / n;
            end
        end
    end
    % data_Y
    for i=1:length(data_Y)
        [dr,dc] = size(data_Y{1,i});
        for c=1:dc
            n = norm(data_Y{1,i}(:,c),2);
            for j=1:dr
                data_Y{1,i}(j,c) = data_Y{1,i}(j,c) / n;
            end
        end
    end
end
if (method == 'mn')
    % mean normalization
    % data_O
    for i=1:length(data_O)
        [dr,dc] = size(data_O{1,i});
        for c=1:dc
            m = mean(data_O{1,i}(:,c));
            max_r = max(data_O{1,i}(:,c));
            min_r = min(data_O{1,i}(:,c));
            for j=1:dr
                data_O{1,i}(j,c) = (data_O{1,i}(j,c) - m) / (max_r-min_r);
            end
        end
    end
    % data_Y
    for i=1:length(data_Y)
        [dr,dc] = size(data_Y{1,i});
        for c=1:dc
            m = mean(data_Y{1,i}(:,c));
            max_r = max(data_Y{1,i}(:,c));
            min_r = min(data_Y{1,i}(:,c));
            for j=1:dr
                data_Y{1,i}(j,c) = (data_Y{1,i}(j,c) - m) / (max_r-min_r);
            end
        end
    end
end
end