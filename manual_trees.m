% manual fixed trees
treefiguresdir = 'C:\Nati\Embryos\4Yoni\Embryo Deep learning\plot_nati\trees\manual_d\';
clear vector_O vector_Y
tfig = 555; % only for tree figures
morp_list_y = {'area','ecce','corr','energ','smoot','time'};
morp_list_o = {'area','ecce','contr','cshad','smoot','round','time'};        
        
        
for ind_stage = 1:6
    color_vec = [0 0.5 0.5;
    0.5 0 0.5;
    0.5 0.25 0;
    0 0.5 0;
    0.5 0 0;
    0 0 0.5];

    k=1;
    for i  = 1:length(ind_blasto_Y)
        [n_prop_y,n_stage] = size(data_Y{i});
        if n_stage>=ind_stage
            vector_Y(k,:) = data_Y{i}(:,ind_stage);
            ind_blasto_Y_stage(k) = ind_blasto_Y(i);
            k=k+1;
        end    
    end

    k=1;
    for i  = 1:length(ind_blasto_O)
        [n_prop_o,n_stage] = size(data_O{i});
        if n_stage>=ind_stage
            vector_O(k,:) = data_O{i}(:,ind_stage);
            ind_blasto_O_stage(k) = ind_blasto_O(i);
            k=k+1;
        end
    end

    % normalize along embryo
    [n,m] = size(vector_Y);
    E = repmat(mean(vector_Y),[n 1]);
    s = repmat(std(vector_Y),[n 1]);
    vector_Y = (vector_Y - E)./s;

    [n,m] = size(vector_O);
    E = repmat(mean(vector_O),[n 1]);
    s = repmat(std(vector_O),[n 1]);
    vector_O = (vector_O - E)./s;


    % linear regression
    VT_Y = cell(1, n_prop_y);VT_Y(:) = {'double'};
    VT_O = cell(1, n_prop_o);VT_O(:) = {'double'};
    T_Y = table('Size',[length(ind_blasto_Y) n_prop_y],'VariableTypes',VT_Y);
    T_O = table('Size',[length(ind_blasto_O) n_prop_o],'VariableTypes',VT_O);
    T_Y.Properties.VariableNames = morp_list_y;
    T_O.Properties.VariableNames = morp_list_o;
    
    for i=1:n_prop_y
        T_Y{:,i} = vector_Y(:,i);
    end
    
    for i=1:n_prop_o
        T_O{:,i} = vector_O(:,i);
    end

    % Young
    t_Y{ind_stage} = fitctree(T_Y,ind_blasto_Y_stage);
    before = findall(groot,'Type','figure'); % Find all figures
    view(t_Y{ind_stage},'Mode','graph');
    after = findall(groot,'Type','figure');
    h = setdiff(after,before); % Get the figure handle of the tree viewer
    saveas(h,'t_tmp','tif')
    im = imread('t_tmp.tif');
    figure(tfig);
    h1 = imshow(im);
    [HeightIm,~,~] = size(im);
    hT1 = title(sprintf('Morphological Grpah view of Young Embryo in ind stage = %d', ind_stage));
    T1Pos = round(get(hT1,'Position')); 
    hT1_2 = text(T1Pos(1),T1Pos(2) + HeightIm+50,'Classes:  0 - Embryo did not survive, 1 - Embryo survived','HorizontalAlignment','center'); %// Place the text
    saveas(h1,strcat(treefiguresdir, sprintf('Young morp Tree in ind stage = %d', ind_stage)), 'tif');
    tfig = tfig + 1;

    % Old
    t_O{ind_stage} = fitctree(T_O,ind_blasto_O_stage);
    before = findall(groot,'Type','figure'); % Find all figures
    view(t_O{ind_stage},'Mode','graph');
    after = findall(groot,'Type','figure');
    h = setdiff(after,before); % Get the figure handle of the tree viewer
    saveas(h,'t_tmp','tif')
    im = imread('t_tmp.tif');
    figure(tfig);
    h1 = imshow(im);
    [HeightIm,~,~] = size(im);
    hT1 = title(sprintf('Morphological Grpah view of Old Embryo in ind stage = %d', ind_stage));
    T1Pos = round(get(hT1,'Position')); 
    hT1_2 = text(T1Pos(1),T1Pos(2) + HeightIm+50,'Classes:  0 - Embryo did not survive, 1 - Embryo survived','HorizontalAlignment','center'); %// Place the text
    saveas(h1,strcat(treefiguresdir, sprintf('Old morp Tree in ind stage = %d', ind_stage)), 'tif');
    tfig = tfig + 1;
end


