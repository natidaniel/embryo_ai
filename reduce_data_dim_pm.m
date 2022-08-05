function [data_O_A,data_Y_A] = reduce_data_dim_pm(data_O,data_Y)
% Calculate mean embryosstats matrices 
% data_O
for i=1:length(data_O)
    [dr,dc] = size(data_O{1,i});
    u = unique(data_O{1,i}(dr,:));
    data_O_A{1,i} = zeros(dr,length(u)); 
    for j=1:length(u)
        s = (find(data_O{1,i}(dr,:) == u(j)));
        f = s(1);
        e = s(end);
        for r=1:dr
            if j == length(u)
                if f+1 > dc
                    fk = dc;
                else
                    fk = f + 1;
                end
                data_O_A{1,i}(r,j) = mean(data_O{1,i}(r,(f-1):fk));
            else
                if e+2 > dc
                    ek = dc;
                else
                    ek = e + 2;
                end
                data_O_A{1,i}(r,j) = mean(data_O{1,i}(r,e:ek)); 
            end
        end
    end
end

%data_Y
for i=1:length(data_Y)
    [dr,dc] = size(data_Y{1,i});
    u = unique(data_Y{1,i}(dr,:));
    data_Y_A{1,i} = zeros(dr,length(u)); 
    for j=1:length(u)
        s = (find(data_Y{1,i}(dr,:) == u(j)));
        f = s(1);
        e = s(end);
        for r=1:dr
            if j == length(u) && (length(u) ~= 1)
                if f+1 > dc
                    fk = dc;
                else
                    fk = f + 1;
                end
                data_Y_A{1,i}(r,j) = mean(data_Y{1,i}(r,(f-1):fk));
            else
                if e+2 > dc
                    ek = dc;
                else
                    ek = e + 2;
                end
                data_Y_A{1,i}(r,j) = mean(data_Y{1,i}(r,e:ek)); 
            end
        end
    end
end
end