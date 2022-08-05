function [YPred1_o] = align_YPred(stat1, numStages)
YPred1_o = {};
for i=1:length(stat1)
    if numStages == 7
        switch(stat1(i))
            case 1
                stg = '1cell';
            case 4
                stg = '2cell';
            case 8
                stg = '4cell';
            case 12
                stg = '8cell';
            case 24
                stg = 'Morula';
            case 32
                stg = 'EarlyBlastocyst';
            case 36
                stg = 'LateBlastocyst';
        end
    end
    if numStages ==9    
        switch(stat1(i))
            case 1
                stg = '1cell';
            case 4
                stg = '2cell';
            case 8
                stg = '4cell';
            case 12
                stg = '8cell';
            case 24
                stg = 'Morula';
            case 32
                stg = 'EarlyBlastocyst';
            case 35
                stg = 'FullBlastocyst';
            case 38
                stg = 'ExpandedBlastocyst';
            case 42
                stg = 'HatchedBlastocyst';
        end
    end
YPred1_o{i} = stg;
end
YPred1_o = YPred1_o';
YPred1_o = categorical(YPred1_o);