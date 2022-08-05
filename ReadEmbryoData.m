%% Embryo Data
%close all;clear;clc;
% Exp
Before6_6 = 'FALSE';
After6_6 = 'TRUE';
% 26 features
%main_path = 'C:\Nati\Embryos\4Yoni\Embryo Deep learning\morp';
% 46 features
if strcmp(After6_6,'TRUE')
    main_path = 'C:\Nati\Embryos\4Yoni\Embryo Deep learning\new_f\morp\SyncToTime';
else
    main_path = 'C:\Nati\Embryos\4Yoni\Embryo Deep learning\new_f\morp\before6_6';
end

% Get list of all subfolders.
allSubFolders = genpath(main_path);
% Parse into a cell array.
remain = allSubFolders;
listOfFolderNames = {};
while true
    [singleSubFolder, remain] = strtok(remain, ';');
    if isempty(singleSubFolder)
        break;
    end
    listOfFolderNames = [listOfFolderNames singleSubFolder];
end
numberOfFolders = length(listOfFolderNames)

%%
k = 0;
for i = 1:numberOfFolders
    
    files = dir(listOfFolderNames{i});
    
    if ~isempty(find([files.isdir]==0))
        
        k = k+1;
        
        ind = find([files.isdir]==0);
        
        load([listOfFolderNames{i},'\',files(ind).name])
        
        data{k} = Embryosstats;
        
        if ~isempty(regexp(listOfFolderNames{i},'\O\'))
            
            age(k) =1;%'old'
        else
            age(k) = 0;%'young';
        end
        
        clear Embryosstats
    end    
end

data_Y = data(find(age==0));
data_O = data(find(age==1));