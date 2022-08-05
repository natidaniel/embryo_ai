function time_mat = extract_time_from_morp(morp_data)
time_mat = NaN(length(morp_data),6);
off_mat = ones(length(morp_data),6);
for i = 1:length(morp_data)
    [~,n_stage] = size(morp_data{i});
    switch n_stage % reducing 1cell
        case 2
            st = 1;
        case 3
            st = 2;
        case 4
            st = 3;
        case 5
            st = 4;
        case 6
            st = 5;
        case 7
            st = 6;
    end
    time_mat(i,1:st) = morp_data{i}(46,1:st);
end
time_mat = off_mat + time_mat;
end

