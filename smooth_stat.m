function [stat1_o, st_arr] = smooth_stat(stat1, periodHr)
st_arr = [];st_stage = [];
st_arr = [st_arr, 1];st_stage = [st_stage, 1];
for i=2:(length(stat1)-1)
    count_if = 0 ;
    if stat1(i)~=stat1(i-1)
        if i <= (length(stat1)-27) % frames 2-66
            if stat1(i)==stat1(i+1)
                count_if =count_if+1;
            end
            if stat1(i)==stat1(i+2)
                count_if =count_if+1;
            end
            if stat1(i)==stat1(i+3)
                count_if =count_if+1;
            end
            if stat1(i)==stat1(i+4)
                count_if =count_if+1;
            end
            if ((count_if >= 3) && isempty(find(st_stage(:)==stat1(i)))) % > 60%
                st_stage = [st_stage, stat1(i)];
                st_arr = [st_arr, i];
            end 
        elseif ((i > (length(stat1)-27)) && (i < (length(stat1)-6))) % > 50%, frames 67-87
            if stat1(i)==stat1(i+1)
                count_if =count_if+1;
            end
            if stat1(i)==stat1(i+2)
                count_if =count_if+1;
            end
            if stat1(i)==stat1(i+3)
                count_if =count_if+1;
            end
            if stat1(i)==stat1(i+4)
                count_if =count_if+1;
            end
            if ((count_if >= 2) && isempty(find(st_stage(:)==stat1(i))))  
                st_stage = [st_stage, stat1(i)];
                st_arr = [st_arr, i];
            end 
        elseif ((i >= (length(stat1)-6)) && (i <= (length(stat1)-2))) % > 50%, frames 88-(periodHr-2)
            if stat1(i)==stat1(i+1)
                count_if =count_if+1;
            end
            if stat1(i)==stat1(i+2)
                count_if =count_if+1;
            end
            if ((count_if >=1) && isempty(find(st_stage(:)==stat1(i))))
                st_stage = [st_stage, stat1(i)];
                st_arr = [st_arr, i];
            end 
        else
            if (isempty(find(st_stage(:)==stat1(i)))) % last 2 frames
                st_stage = [st_stage, stat1(i)];
                st_arr = [st_arr, i];
            end 
        end
    end
end

stat1_o=[];
for s=1:(length(st_stage)-1)
    if (s == 1)
        stat1_o = [stat1_o, repmat(st_stage(s),(st_arr(s+1)-st_arr(s)),1)];
    else
        stat1_o= padconcatenation(stat1_o,repmat(st_stage(s),(st_arr(s+1)-st_arr(s)),1),1);
    end
end
stat1_o = padconcatenation(stat1_o, repmat(st_stage(end),(periodHr-st_arr(end)+1),1),1);
stat1_o = stat1_o';