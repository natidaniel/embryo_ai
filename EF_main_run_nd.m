% night run
Use_9_8_Exp = 'FALSE';
Use_22_8_Exp = 'FALSE';
Use_29_8_Exp = 'FALSE';
Use_6_6_Exp = 'FALSE';
Use_6_6_Extra_Exp = 'TRUE';
Use_22_8_Extra_Exp = 'FALSE';

if strcmp(Use_9_8_Exp,'TRUE') 
    periodHr = 97;
    nsortD = 'FALSE';
    for i=1:9
        switch i
            case 1
                path_cell1= 'C:\Nati\Embryos\cropped 21per\9_8_18\O\1\1\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\9_8_18\O\1\1\Embryosstats';
            case 2
                path_cell1= 'C:\Nati\Embryos\cropped 21per\9_8_18\O\1\2\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\9_8_18\O\1\2\Embryosstats';
            case 3
                path_cell1= 'C:\Nati\Embryos\cropped 21per\9_8_18\O\4\1\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\9_8_18\O\4\1\Embryosstats';
            case 4
                path_cell1= 'C:\Nati\Embryos\cropped 21per\9_8_18\O\4\2\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\9_8_18\O\4\2\Embryosstats';
            case 5
                path_cell1= 'C:\Nati\Embryos\cropped 21per\9_8_18\O\5\1\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\9_8_18\O\5\1\Embryosstats';
            case 6
                path_cell1= 'C:\Nati\Embryos\cropped 21per\9_8_18\O\6\1\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\9_8_18\O\6\1\Embryosstats';
            case 7
                path_cell1= 'C:\Nati\Embryos\cropped 21per\9_8_18\O\9\1\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\9_8_18\O\9\1\Embryosstats';
            case 8
                path_cell1= 'C:\Nati\Embryos\cropped 21per\9_8_18\O\9\2\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\9_8_18\O\9\2\Embryosstats';
            case 9
                path_cell1= 'C:\Nati\Embryos\cropped 21per\9_8_18\O\10\1\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\9_8_18\O\10\1\Embryosstats';
        end        
        Embryosstats = Embryosstats_wEF(path_cell1, periodHr, nsortD);
        save(morp_path,'Embryosstats');
        pause(5)
        clear Embryosstats path_cell1 morp_path
    end
end

if strcmp(Use_22_8_Exp,'TRUE')
    periodHr = 94;
    nsortD = 'FALSE';
    for i=1:50
        switch i
            case 1
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\O\26\1\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\O\26\1\Embryosstats';
            case 2
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\O\26\2\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\O\26\2\Embryosstats';
            case 3
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\O\26\3\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\O\26\3\Embryosstats';
            case 4
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\O\26\4\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\O\26\4\Embryosstats';
            case 5
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\O\26\5\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\O\26\5\Embryosstats';
            case 6
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\O\26\6\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\O\26\6\Embryosstats';
            case 7
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\O\26\8\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\O\26\8\Embryosstats';
            case 8
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\O\26\9\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\O\26\9\Embryosstats';
            case 9
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\O\26\10\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\O\26\10\Embryosstats';
            case 10
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\O\27\2\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\O\27\2\Embryosstats';
            case 11
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\O\27\3\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\O\27\3\Embryosstats';
            case 12
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\O\27\4\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\O\27\4\Embryosstats';
            case 13
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\O\27\6\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\O\27\6\Embryosstats';
            case 14
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\O\27\7\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\O\27\7\Embryosstats';
            case 15
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\O\27\8\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\O\27\8\Embryosstats';
            case 16
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\O\27\10\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\O\27\10\Embryosstats';
            case 17
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\O\28\1\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\O\28\1\Embryosstats';
            case 18
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\O\28\4\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\O\28\4\Embryosstats';
            case 19
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\O\28\5\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\O\28\5\Embryosstats';
            case 20
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\O\28\6\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\O\28\6\Embryosstats';
            case 21
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\O\28\7\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\O\28\7\Embryosstats';
            case 22
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\Y\1\1\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\Y\1\1\Embryosstats';
            case 23
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\Y\1\2\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\Y\1\2\Embryosstats';
            case 24
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\Y\1\3\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\Y\1\3\Embryosstats';
            case 25
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\Y\1\4\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\Y\1\4\Embryosstats';
            case 26
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\Y\2\1\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\Y\2\1\Embryosstats';
            case 27
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\Y\3\1\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\Y\3\1\Embryosstats';
            case 28
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\Y\3\2\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\Y\3\2\Embryosstats';
            case 29
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\Y\4\1\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\Y\4\1\Embryosstats';
            case 30
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\Y\5\3\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\Y\5\3\Embryosstats';
            case 31
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\Y\5\4\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\Y\5\4\Embryosstats';
            case 32
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\Y\5\5\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\Y\5\5\Embryosstats';
            case 33
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\Y\6\1\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\Y\6\1\Embryosstats';
            case 34
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\Y\6\2\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\Y\6\2\Embryosstats';
            case 35
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\Y\6\3\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\Y\6\3\Embryosstats';
            case 36
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\Y\6\4\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\Y\6\4\Embryosstats';
            case 37
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\Y\7\3\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\Y\7\3\Embryosstats';
            case 38
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\Y\7\4\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\Y\7\4\Embryosstats';
            case 39
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\Y\7\5\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\Y\7\5\Embryosstats';
            case 40
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\Y\7\8\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\Y\7\8\Embryosstats';
            case 41
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\Y\7\9\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\Y\7\9\Embryosstats';
            case 42
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\Y\9\1\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\Y\9\1\Embryosstats';
            case 43
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\Y\9\2\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\Y\9\2\Embryosstats';
            case 44
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\Y\9\3\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\Y\9\3\Embryosstats';
            case 45
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\Y\9\4\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\Y\9\4\Embryosstats';
            case 46
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\Y\13\1\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\Y\13\1\Embryosstats';
            case 47
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\Y\13\2\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\Y\13\2\Embryosstats';
            case 48
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\Y\13\4\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\Y\13\4\Embryosstats';
            case 49
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\Y\13\5\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\Y\13\5\Embryosstats';
            case 50
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\Y\13\6\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\Y\13\6\Embryosstats';
        end
        Embryosstats = Embryosstats_wEF(path_cell1, periodHr, nsortD);
        save(morp_path,'Embryosstats');
        pause(5)
        clear Embryosstats path_cell1 morp_path
    end
end

if strcmp(Use_29_8_Exp,'TRUE') 
    periodHr = 97;
    nsortD = 'FALSE';
    for i=1:56
        switch i
            case 1
                path_cell1= 'C:\Nati\Embryos\cropped 21per\29_8_18\O\4\1\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\29_8_18\O\4\1\Embryosstats';
            case 2
                path_cell1= 'C:\Nati\Embryos\cropped 21per\29_8_18\O\4\2\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\29_8_18\O\4\2\Embryosstats';
            case 3
                path_cell1= 'C:\Nati\Embryos\cropped 21per\29_8_18\O\4\3\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\29_8_18\O\4\3\Embryosstats';
            case 4
                path_cell1= 'C:\Nati\Embryos\cropped 21per\29_8_18\O\4\4\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\29_8_18\O\4\4\Embryosstats';
            case 5
                path_cell1= 'C:\Nati\Embryos\cropped 21per\29_8_18\O\8\1\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\29_8_18\O\8\1\Embryosstats';
            case 6
                path_cell1= 'C:\Nati\Embryos\cropped 21per\29_8_18\O\8\2\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\29_8_18\O\8\2\Embryosstats';
            case 7
                path_cell1= 'C:\Nati\Embryos\cropped 21per\29_8_18\O\8\4\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\29_8_18\O\8\4\Embryosstats';
            case 8
                path_cell1= 'C:\Nati\Embryos\cropped 21per\29_8_18\O\8\5\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\29_8_18\O\8\5\Embryosstats';
            case 9
                path_cell1= 'C:\Nati\Embryos\cropped 21per\29_8_18\O\12\1\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\29_8_18\O\12\1\Embryosstats';
            case 10
                path_cell1= 'C:\Nati\Embryos\cropped 21per\29_8_18\O\12\2\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\29_8_18\O\12\2\Embryosstats';
            case 11
                path_cell1= 'C:\Nati\Embryos\cropped 21per\29_8_18\O\12\3\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\29_8_18\O\12\3\Embryosstats';
            case 12
                path_cell1= 'C:\Nati\Embryos\cropped 21per\29_8_18\O\12\4\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\29_8_18\O\12\4\Embryosstats';
            case 13
                path_cell1= 'C:\Nati\Embryos\cropped 21per\29_8_18\O\12\5\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\29_8_18\O\12\5\Embryosstats';
            case 14
                path_cell1= 'C:\Nati\Embryos\cropped 21per\29_8_18\O\13\1\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\29_8_18\O\13\1\Embryosstats';
            case 15
                path_cell1= 'C:\Nati\Embryos\cropped 21per\29_8_18\O\13\2\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\29_8_18\O\13\2\Embryosstats';
            case 16
                path_cell1= 'C:\Nati\Embryos\cropped 21per\29_8_18\O\13\3\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\29_8_18\O\13\3\Embryosstats';
            case 17
                path_cell1= 'C:\Nati\Embryos\cropped 21per\29_8_18\O\17\1\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\29_8_18\O\17\1\Embryosstats';
            case 18
                path_cell1= 'C:\Nati\Embryos\cropped 21per\29_8_18\O\17\2\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\29_8_18\O\17\2\Embryosstats';
            case 19
                path_cell1= 'C:\Nati\Embryos\cropped 21per\29_8_18\O\17\3\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\29_8_18\O\17\3\Embryosstats';
            case 20
                path_cell1= 'C:\Nati\Embryos\cropped 21per\29_8_18\O\17\4\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\29_8_18\O\17\4\Embryosstats';
            case 21
                path_cell1= 'C:\Nati\Embryos\cropped 21per\29_8_18\O\17\5\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\29_8_18\O\17\5\Embryosstats';
            case 22
                path_cell1= 'C:\Nati\Embryos\cropped 21per\29_8_18\O\17\6\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\29_8_18\O\17\6\Embryosstats';
            case 23
                path_cell1= 'C:\Nati\Embryos\cropped 21per\29_8_18\O\17\7\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\29_8_18\O\17\7\Embryosstats';
            case 24
                path_cell1= 'C:\Nati\Embryos\cropped 21per\29_8_18\O\20\1\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\29_8_18\O\20\1\Embryosstats';
            case 25
                path_cell1= 'C:\Nati\Embryos\cropped 21per\29_8_18\O\20\3\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\29_8_18\O\20\3\Embryosstats';
            case 26
                path_cell1= 'C:\Nati\Embryos\cropped 21per\29_8_18\O\20\4\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\29_8_18\O\20\4\Embryosstats';
            case 27
                path_cell1= 'C:\Nati\Embryos\cropped 21per\29_8_18\O\20\5\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\29_8_18\O\20\5\Embryosstats';
            case 28
                path_cell1= 'C:\Nati\Embryos\cropped 21per\29_8_18\O\20\6\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\29_8_18\O\20\6\Embryosstats';
            case 29
                path_cell1= 'C:\Nati\Embryos\cropped 21per\29_8_18\O\20\7\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\29_8_18\O\20\7\Embryosstats';
            case 30
                path_cell1= 'C:\Nati\Embryos\cropped 21per\29_8_18\O\20\8\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\29_8_18\O\20\8\Embryosstats';
            case 31
                path_cell1= 'C:\Nati\Embryos\cropped 21per\29_8_18\Y\3\1\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\29_8_18\Y\3\1\Embryosstats';
            case 32
                path_cell1= 'C:\Nati\Embryos\cropped 21per\29_8_18\Y\3\2\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\29_8_18\Y\3\2\Embryosstats';
            case 33
                path_cell1= 'C:\Nati\Embryos\cropped 21per\29_8_18\Y\7\1\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\29_8_18\Y\7\1\Embryosstats';
            case 34
                path_cell1= 'C:\Nati\Embryos\cropped 21per\29_8_18\Y\7\2\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\29_8_18\Y\7\2\Embryosstats';
            case 35
                path_cell1= 'C:\Nati\Embryos\cropped 21per\29_8_18\Y\7\3\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\29_8_18\Y\7\3\Embryosstats';
            case 36
                path_cell1= 'C:\Nati\Embryos\cropped 21per\29_8_18\Y\7\4\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\29_8_18\Y\7\4\Embryosstats';
            case 37
                path_cell1= 'C:\Nati\Embryos\cropped 21per\29_8_18\Y\7\5\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\29_8_18\Y\7\5\Embryosstats';
            case 38
                path_cell1= 'C:\Nati\Embryos\cropped 21per\29_8_18\Y\7\6\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\29_8_18\Y\7\6\Embryosstats';
            case 39
                path_cell1= 'C:\Nati\Embryos\cropped 21per\29_8_18\Y\10\1\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\29_8_18\Y\10\1\Embryosstats';
            case 40
                path_cell1= 'C:\Nati\Embryos\cropped 21per\29_8_18\Y\10\2\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\29_8_18\Y\10\2\Embryosstats';
            case 41
                path_cell1= 'C:\Nati\Embryos\cropped 21per\29_8_18\Y\10\3\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\29_8_18\Y\10\3\Embryosstats';
            case 42
                path_cell1= 'C:\Nati\Embryos\cropped 21per\29_8_18\Y\10\4\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\29_8_18\Y\10\4\Embryosstats';
            case 43
                path_cell1= 'C:\Nati\Embryos\cropped 21per\29_8_18\Y\10\5\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\29_8_18\Y\10\5\Embryosstats';
            case 44
                path_cell1= 'C:\Nati\Embryos\cropped 21per\29_8_18\Y\10\6\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\29_8_18\Y\10\6\Embryosstats';
            case 45
                path_cell1= 'C:\Nati\Embryos\cropped 21per\29_8_18\Y\16\1\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\29_8_18\Y\16\1\Embryosstats';
            case 46
                path_cell1= 'C:\Nati\Embryos\cropped 21per\29_8_18\Y\16\2\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\29_8_18\Y\16\2\Embryosstats';
            case 47
                path_cell1= 'C:\Nati\Embryos\cropped 21per\29_8_18\Y\16\3\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\29_8_18\Y\16\3\Embryosstats';
            case 48
                path_cell1= 'C:\Nati\Embryos\cropped 21per\29_8_18\Y\16\4\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\29_8_18\Y\16\4\Embryosstats';
            case 49
                path_cell1= 'C:\Nati\Embryos\cropped 21per\29_8_18\Y\16\5\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\29_8_18\Y\16\5\Embryosstats';
            case 50
                path_cell1= 'C:\Nati\Embryos\cropped 21per\29_8_18\Y\16\6\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\29_8_18\Y\16\6\Embryosstats';
			case 51
                path_cell1= 'C:\Nati\Embryos\cropped 21per\29_8_18\Y\19\1\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\29_8_18\Y\19\1\Embryosstats';
			case 52
                path_cell1= 'C:\Nati\Embryos\cropped 21per\29_8_18\Y\19\2\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\29_8_18\Y\19\2\Embryosstats';
			case 53
                path_cell1= 'C:\Nati\Embryos\cropped 21per\29_8_18\Y\19\3\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\29_8_18\Y\19\3\Embryosstats';
			case 54
                path_cell1= 'C:\Nati\Embryos\cropped 21per\29_8_18\Y\19\4\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\29_8_18\Y\19\4\Embryosstats';
			case 55
                path_cell1= 'C:\Nati\Embryos\cropped 21per\29_8_18\Y\19\5\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\29_8_18\Y\19\5\Embryosstats';
			case 56
                path_cell1= 'C:\Nati\Embryos\cropped 21per\29_8_18\Y\19\6\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\29_8_18\Y\19\6\Embryosstats';
        end
        Embryosstats = Embryosstats_wEF(path_cell1, periodHr, nsortD);
        save(morp_path,'Embryosstats');
        pause(5)
        clear Embryosstats path_cell1 morp_path
    end
end

if strcmp(Use_22_8_Extra_Exp,'TRUE')
    periodHr = 94;
    nsortD = 'FALSE';
    for i=1:6
        switch i
            case 1
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\Y\17\1\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\Y\17\1\Embryosstats';
            case 2
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\Y\17\2\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\Y\17\2\Embryosstats';
            case 3
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\Y\21\1\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\Y\21\1\Embryosstats';
            case 4
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\Y\21\2\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\Y\21\2\Embryosstats';
            case 5
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\Y\21\3\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\Y\21\3\Embryosstats';
            case 6
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\Y\21\4\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\Y\21\4\Embryosstats';
            
        end
        Embryosstats = Embryosstats_wEF(path_cell1, periodHr, nsortD);
        save(morp_path,'Embryosstats');
        pause(5)
        clear Embryosstats path_cell1 morp_path
    end
end

if strcmp(Use_6_6_Exp,'TRUE')
    periodHr = 96;
    nsortD = 'TRUE';
    for i=1:35
        switch i
            case 1
                path_cell1= 'C:\Nati\Embryos\cropped 21per\6_6_18\Y\1\1\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\6_6_18\Y\1\1\Embryosstats';
            case 2
                path_cell1= 'C:\Nati\Embryos\cropped 21per\6_6_18\Y\1\2\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\6_6_18\Y\1\2\Embryosstats';
            case 3
                path_cell1= 'C:\Nati\Embryos\cropped 21per\6_6_18\Y\1\3\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\6_6_18\Y\1\3\Embryosstats';
            case 4
                path_cell1= 'C:\Nati\Embryos\cropped 21per\6_6_18\Y\1\4\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\6_6_18\Y\1\4\Embryosstats';
            case 5
                path_cell1= 'C:\Nati\Embryos\cropped 21per\6_6_18\Y\1\5\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\6_6_18\Y\1\5\Embryosstats';
            case 6
                path_cell1= 'C:\Nati\Embryos\cropped 21per\6_6_18\Y\1\6\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\6_6_18\Y\1\6\Embryosstats';
            case 7
                path_cell1= 'C:\Nati\Embryos\cropped 21per\6_6_18\Y\3\1\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\6_6_18\Y\3\1\Embryosstats';
            case 8
                path_cell1= 'C:\Nati\Embryos\cropped 21per\6_6_18\Y\3\2\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\6_6_18\Y\3\2\Embryosstats';
            case 9
                path_cell1= 'C:\Nati\Embryos\cropped 21per\6_6_18\Y\3\3\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\6_6_18\Y\3\3\Embryosstats';
            case 10
                path_cell1= 'C:\Nati\Embryos\cropped 21per\6_6_18\Y\3\4\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\6_6_18\Y\3\4\Embryosstats';
            case 11
                path_cell1= 'C:\Nati\Embryos\cropped 21per\6_6_18\Y\3\5\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\6_6_18\Y\3\5\Embryosstats';
            case 12
                path_cell1= 'C:\Nati\Embryos\cropped 21per\6_6_18\Y\3\6\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\6_6_18\Y\3\6\Embryosstats';
            case 13
                path_cell1= 'C:\Nati\Embryos\cropped 21per\6_6_18\Y\3\7\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\6_6_18\Y\3\7\Embryosstats';
            case 14
                path_cell1= 'C:\Nati\Embryos\cropped 21per\6_6_18\Y\3\8\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\6_6_18\Y\3\8\Embryosstats';
            case 15
                path_cell1= 'C:\Nati\Embryos\cropped 21per\6_6_18\YO\5\1\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\6_6_18\YO\5\1\Embryosstats';
            case 16
                path_cell1= 'C:\Nati\Embryos\cropped 21per\6_6_18\YO\5\2\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\6_6_18\YO\5\2\Embryosstats';
            case 17
                path_cell1= 'C:\Nati\Embryos\cropped 21per\6_6_18\YO\5\3\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\6_6_18\YO\5\3\Embryosstats';
            case 18
                path_cell1= 'C:\Nati\Embryos\cropped 21per\6_6_18\YO\5\4\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\6_6_18\YO\5\4\Embryosstats';
            case 19
                path_cell1= 'C:\Nati\Embryos\cropped 21per\6_6_18\YO\5\5\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\6_6_18\YO\5\5\Embryosstats';
            case 20
                path_cell1= 'C:\Nati\Embryos\cropped 21per\6_6_18\YO\5\6\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\6_6_18\YO\5\6\Embryosstats';
            case 21
                path_cell1= 'C:\Nati\Embryos\cropped 21per\6_6_18\YO\5\7\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\6_6_18\YO\5\7\Embryosstats';
            case 22
                path_cell1= 'C:\Nati\Embryos\cropped 21per\6_6_18\YO\7\1\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\6_6_18\YO\7\1\Embryosstats';
            case 23
                path_cell1= 'C:\Nati\Embryos\cropped 21per\6_6_18\YO\7\2\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\6_6_18\YO\7\2\Embryosstats';
            case 24
                path_cell1= 'C:\Nati\Embryos\cropped 21per\6_6_18\YO\7\3\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\6_6_18\YO\7\3\Embryosstats';
            case 25
                path_cell1= 'C:\Nati\Embryos\cropped 21per\6_6_18\YO\7\4\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\6_6_18\YO\7\4\Embryosstats';
            case 26
                path_cell1= 'C:\Nati\Embryos\cropped 21per\6_6_18\YO\7\5\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\6_6_18\YO\7\5\Embryosstats';
            case 27
                path_cell1= 'C:\Nati\Embryos\cropped 21per\6_6_18\YO\7\6\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\6_6_18\YO\7\6\Embryosstats';
            case 28
                path_cell1= 'C:\Nati\Embryos\cropped 21per\6_6_18\YO\9\1\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\6_6_18\YO\9\1\Embryosstats';
            case 29
                path_cell1= 'C:\Nati\Embryos\cropped 21per\6_6_18\YO\9\2\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\6_6_18\YO\9\2\Embryosstats';
            case 30
                path_cell1= 'C:\Nati\Embryos\cropped 21per\6_6_18\YO\9\3\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\6_6_18\YO\9\3\Embryosstats';
            case 31
                path_cell1= 'C:\Nati\Embryos\cropped 21per\6_6_18\YO\17\1\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\6_6_18\YO\17\1\Embryosstats';
            case 32
                path_cell1= 'C:\Nati\Embryos\cropped 21per\6_6_18\YO\17\2\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\6_6_18\YO\17\2\Embryosstats';
            case 33
                path_cell1= 'C:\Nati\Embryos\cropped 21per\6_6_18\YO\17\3\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\6_6_18\YO\17\3\Embryosstats';
            case 34
                path_cell1= 'C:\Nati\Embryos\cropped 21per\6_6_18\YO\17\4\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\6_6_18\YO\17\4\Embryosstats';
            case 35
                path_cell1= 'C:\Nati\Embryos\cropped 21per\6_6_18\YO\17\5\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\6_6_18\YO\17\5\Embryosstats';
        end
        Embryosstats = Embryosstats_wEF(path_cell1, periodHr, nsortD);
        save(morp_path,'Embryosstats');
        pause(5)
        clear Embryosstats path_cell1 morp_path
    end
end

if strcmp(Use_6_6_Extra_Exp,'TRUE')
    periodHr = 96;
    nsortD = 'TRUE';
    for i=1:1
        switch i
            case 1
                path_cell1= 'C:\Nati\Embryos\cropped 21per\6_6_18\YO\17\4\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\6_6_18\YO\17\4\Embryosstats';
        end
        Embryosstats = Embryosstats_wEF(path_cell1, periodHr, nsortD);
        save(morp_path,'Embryosstats');
        pause(5)
        clear Embryosstats path_cell1 morp_path
    end
end