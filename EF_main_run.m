% night run
Use_9_8_Exp = 'TRUE';
Use_22_8_Exp = 'FALSE';
Use_29_8_Exp = 'FALSE';

if strcmp(Use_9_8_Exp,'TRUE') 
    for i=1:1
        switch i
            case 1
                path_cell1= 'C:\Nati\Embryos\cropped 21per\9_8_18\O\1\1\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\9_8_18\O\1\1\';
            case 2
                path_cell1= 'C:\Nati\Embryos\cropped 21per\9_8_18\O\1\2\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\9_8_18\O\1\2\';
            case 3
                path_cell1= 'C:\Nati\Embryos\cropped 21per\9_8_18\O\4\1\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\9_8_18\O\4\1\';
            case 4
                path_cell1= 'C:\Nati\Embryos\cropped 21per\9_8_18\O\4\2\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\9_8_18\O\4\2\';
            case 5
                path_cell1= 'C:\Nati\Embryos\cropped 21per\9_8_18\O\5\1\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\9_8_18\O\5\1\';
            case 6
                path_cell1= 'C:\Nati\Embryos\cropped 21per\9_8_18\O\6\1\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\9_8_18\O\6\1\';
            case 7
                path_cell1= 'C:\Nati\Embryos\cropped 21per\9_8_18\O\9\1\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\9_8_18\O\9\1\';
            case 8
                path_cell1= 'C:\Nati\Embryos\cropped 21per\9_8_18\O\9\2\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\9_8_18\O\9\2\';
            case 9
                path_cell1= 'C:\Nati\Embryos\cropped 21per\9_8_18\O\10\1\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\9_8_18\O\10\1\';
        end        
        Embryosstats = Embryosstats_wEF(path_cell1, morp_path);
        save(fullfile(morp_path,'Embryosstats'));
        pause(5)
        clear Embryosstats path_cell1 morp_path
    end
end

if strcmp(Use_22_8_Exp,'TRUE') 
    for i=1:50
        switch i
            case 1
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\O\26\1\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\O\26\1\';
            case 2
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\O\26\2\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\O\26\2\';
            case 3
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\O\26\3\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\O\26\3\';
            case 4
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\O\26\4\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\O\26\4\';
            case 5
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\O\26\5\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\O\26\5\';
            case 6
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\O\26\6\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\O\26\6\';
            case 7
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\O\26\8\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\O\26\8\';
            case 8
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\O\26\9\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\O\26\9\';
            case 9
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\O\26\10\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\O\26\10\';
				            case 10
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\O\27\2\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\O\27\2\';
				            case 11
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\O\27\3\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\O\27\3\';
				            case 12
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\O\27\4\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\O\27\4\';
				            case 13
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\O\27\6\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\O\27\6\';
				            case 14
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\O\27\7\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\O\27\7\';
				            case 15
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\O\27\8\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\O\27\8\';
				            case 16
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\O\27\10\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\O\27\10\';
				            case 17
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\O\28\1\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\O\28\1\';
				            case 18
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\O\28\4\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\O\28\4\';
				            case 19
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\O\28\5\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\O\28\5\';
				            case 20
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\O\28\6\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\O\28\6\';
				            case 21
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\O\28\7\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\O\28\7\';
				            case 22
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\Y\1\1\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\Y\1\1\';
				            case 23
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\Y\1\2\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\Y\1\2\';
				            case 24
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\Y\1\3\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\Y\1\3\';
								            case 25
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\Y\1\4\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\Y\1\4\';
								            case 26
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\Y\2\1\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\Y\2\1\';
								            case 27
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\Y\3\1\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\Y\3\1\';
								            case 28
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\Y\3\2\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\Y\3\2\';
								            case 29
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\Y\4\1\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\Y\4\1\';
								            case 30
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\Y\5\3\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\Y\5\3\';
												            case 31
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\Y\5\4\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\Y\5\4\';
												            case 32
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\Y\5\5\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\Y\5\5\';
												            case 33
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\Y\6\1\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\Y\6\1\';
												            case 34
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\Y\6\2\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\Y\6\2\';
												            case 35
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\Y\6\3\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\Y\6\3\';
												            case 36
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\Y\6\4\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\Y\6\4\';
												            case 37
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\Y\7\3\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\Y\7\3\';
												            case 38
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\Y\7\4\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\Y\7\4\';
												            case 39
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\Y\7\5\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\Y\7\5\';
																            case 40
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\Y\7\8\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\Y\7\8\';
																				            case 41
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\Y\7\9\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\Y\7\9\';
																				            case 42
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\Y\9\1\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\Y\9\1\';
																				            case 43
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\Y\9\2\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\Y\9\2\';
																				            case 44
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\Y\9\3\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\Y\9\3\';
																				            case 45
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\Y\9\4\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\Y\9\4\';
																				            case 46
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\Y\13\1\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\Y\13\1\';
																				            case 47
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\Y\13\2\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\Y\13\2\';
																				            case 48
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\Y\13\4\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\Y\13\4\';
																				            case 49
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\Y\13\5\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\Y\13\5\';
				        case 50
                path_cell1= 'C:\Nati\Embryos\cropped 21per\22_8_18\Y\13\6\';
                morp_path = 'C:\Nati\Embryos\cropped 21per\morp\new_f\22_8_18\Y\13\6\';
        end        
        Embryosstats = Embryosstats_wEF(path_cell1, morp_path);
        save(fullfile(morp_path,'Embryosstats'));
        pause(5)
        clear Embryosstats path_cell1 morp_path
    end
end

if strcmp(Use_29_8_Exp,'TRUE') 
    for i=1:56
        % TO-DO
    end
end

