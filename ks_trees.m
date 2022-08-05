% ks trees
% automatic selection trees
data_O = data_O_RS;
data_Y = data_Y_RS;

treefiguresdir = 'C:\Nati\Embryos\4Yoni\Embryo Deep learning\plot_nati\trees\';
clear vector_O vector_Y

if strcmp(UseLinearRegressionModeling,'TRUE')
    tfig = 555; % only for tree figures
   
    for ind_stage = 1:6
        color_vec = [0 0.5 0.5;
        0.5 0 0.5;
        0.5 0.25 0;
        0 0.5 0;
        0.5 0 0;
        0 0 0.5];
        
        k=1;
        for i  = 1:length(ind_blasto_Y)
            [n_prop,n_stage] = size(data_Y{i});
            if n_stage>=ind_stage;
                vector_Y(k,:) = data_Y{i}(:,ind_stage);
                k=k+1;
            end    
        end

        k=1;
        for i  = 1:length(ind_blasto_O)
            [n_prop,n_stage] = size(data_O{i});
            if n_stage>=ind_stage;
                vector_O(k,:) = data_O{i}(:,ind_stage);
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

      
        % linerar regression
        VT = cell(1, n_prop);VT(:) = {'double'};
        T_Y = table('Size',[length(ind_blasto_Y) n_prop],'VariableTypes',VT);
        T_O = table('Size',[length(ind_blasto_O) n_prop],'VariableTypes',VT);

        for i=1:n_prop
            T_Y{:,i} = vector_Y(:,i);
            T_O{:,i} = vector_O(:,i);
        end
        
        % Young
        mdl_Y{ind_stage} = fitglm(vector_Y,ind_blasto_Y,'linear');% Create generalized linear regression model
        lda_Y{ind_stage} = fitcdiscr(vector_Y,ind_blasto_Y);% Fit discriminant analysis classifier
        t_Y{ind_stage} = fitctree(T_Y,ind_blasto_Y);
        
        
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
        mdl_O{ind_stage} = fitglm(vector_O,ind_blasto_O,'linear');% Create generalized linear regression model
        lda_O{ind_stage} = fitcdiscr(vector_O,ind_blasto_O);% Fit discriminant analysis classifier
        t_O{ind_stage} = fitctree(T_O,ind_blasto_O);
        
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
end

