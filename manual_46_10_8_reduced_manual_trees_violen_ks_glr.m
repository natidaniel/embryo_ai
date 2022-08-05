% need to run morp_tsne_pca.m first
% manual fixed trees with 10 and 8 features
treefiguresdir = 'C:\Nati\Embryos\4Yoni\Embryo Deep learning\plot_nati\trees\6_6\';
clear vector_O vector_Y
tfig = 555; % only for tree figures
fig = 1; 

morp_list_y = {'area','autocorr','corr','var','smoot','suma','round','lpsf','tskew','time'};
morp_list_o = {'area','autocorr','var','suma','dws','hpsf','tskew','time'};        
        
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
    
    
     % perform KS test
    for cnt_morp = 1:m  
        % Young
        v1_Y = vector_Y(find(ind_blasto_Y_stage==1),cnt_morp);
        v0_Y = vector_Y(find(ind_blasto_Y_stage==0),cnt_morp);
        [h,p] = kstest2(v1_Y,v0_Y);
        p_val_Y(ind_stage,cnt_morp) = p;
    end
    
    % normalize along embryo
    [n,m] = size(vector_O);
    E = repmat(mean(vector_O),[n 1]);
    s = repmat(std(vector_O),[n 1]);
    vector_O = (vector_O - E)./s;
    
    % perform KS test
    for cnt_morp = 1:m  %m = should be 26/46
        % Old
        v1_O = vector_O(find(ind_blasto_O_stage==1),cnt_morp);
        v0_O = vector_O(find(ind_blasto_O_stage==0),cnt_morp);
        [h,p] = kstest2(v1_O,v0_O);
        p_val_O(ind_stage,cnt_morp) = p;
    end  
    
    figure(fig);subplot(2,3,ind_stage);hold on;
    titleplot = sprintf('Young, ind stage = %d', ind_stage);
    title(titleplot);
    violinplot(vector_Y(find(ind_blasto_Y_stage==1),:),[],'ShowData',false,'ViolinColor',color_vec(1,:),'MedianColor',color_vec(1,:));
    violinplot(vector_Y(find(ind_blasto_Y_stage==0),:),[],'ShowData',false,'ViolinColor',color_vec(2,:),'MedianColor',color_vec(2,:));
    ax = gca;
    ax.XTick = 1:10; 
    ax.XTickLabels = morp_list_y;
    ax.XTickLabelRotation = 45;

    figure(fig+1);subplot(2,3,ind_stage);hold on;
    titleplot = sprintf('Old, ind stage = %d', ind_stage);
    title(titleplot);
    violinplot(vector_O(find(ind_blasto_O_stage==1),:),[],'ShowData',false,'ViolinColor',color_vec(1,:),'MedianColor',color_vec(1,:));
    violinplot(vector_O(find(ind_blasto_O_stage==0),:),[],'ShowData',false,'ViolinColor',color_vec(2,:),'MedianColor',color_vec(2,:));
    ax = gca;
    ax.XTick = 1:8; 
    ax.XTickLabels = morp_list_o;
    ax.XTickLabelRotation = 45;

    figure(fig+2);subplot(2,3,ind_stage);hold on;
    titleplot = sprintf('Young, ind stage = %d', ind_stage);
    title(titleplot);
    bar(p_val_Y(ind_stage,:));
    ax = gca;
    ax.XTick = 1:10; 
    ax.XTickLabels = morp_list_y;
    ax.XTickLabelRotation = 45;

    figure(fig+3);subplot(2,3,ind_stage);hold on;
    titleplot = sprintf('Old, ind stage = %d', ind_stage);
    title(titleplot);
    bar(p_val_O(ind_stage,:));
    ax = gca;
    ax.XTick = 1:8; 
    ax.XTickLabels = morp_list_o;
    ax.XTickLabelRotation = 45;
    
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
    mdl_Y{ind_stage} = fitglm(vector_Y,ind_blasto_Y_stage,'linear');% Create generalized linear regression model
    lda_Y{ind_stage} = fitcdiscr(vector_Y,ind_blasto_Y_stage);% Fit discriminant analysis classifier
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

    % perform glr
    for i=2:length(mdl_Y{ind_stage}.Coefficients.pValue)
        if isnan(mdl_Y{ind_stage}.Coefficients.pValue(i))
            p_glr_Y(i-1,ind_stage) = 0;
        else
            p_glr_Y(i-1,ind_stage) = mdl_Y{ind_stage}.Coefficients.pValue(i);
        end
    end
    p_glr_Y = p_glr_Y'; 
    
    % Old
    mdl_O{ind_stage} = fitglm(vector_O,ind_blasto_O_stage,'linear');% Create generalized linear regression model
    lda_O{ind_stage} = fitcdiscr(vector_O,ind_blasto_O_stage);% Fit discriminant analysis classifier
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
    
    % perform glr
    for i=2:length(mdl_O{ind_stage}.Coefficients.pValue)
        if isnan(mdl_O{ind_stage}.Coefficients.pValue(i))
            p_glr_O(i-1,ind_stage) = 0;
        else
            p_glr_O(i-1,ind_stage) = mdl_O{ind_stage}.Coefficients.pValue(i);
        end
    end
    p_glr_O = p_glr_O';  
    
    % ks and glr both young and old
    figure(fig+4);subplot(2,3,ind_stage);hold on;
    titleplot = sprintf('Young, ind stage = %d', ind_stage);
    title(titleplot);
    w1 = 0.5;
    ax = gca;
    ax.XTick = 1:10; 
    ax.XTickLabels = morp_list_y;
    ax.XTickLabelRotation = 45;
    bar(ax.XTick,p_val_Y(ind_stage,:),w1,'FaceColor',[0.2 0.2 0.5]);
    hold on
    w2 = .25;
    bar(ax.XTick,p_glr_Y(ind_stage,:),w2,'FaceColor',[0 0.7 0.7]);
    grid on
    ylabel('Coefficients')
    legend({'Two-sample Kolmogorov-Smirnov test','generalized linear regression model test'},'Location','northwest')
    hold off 

    figure(fig+5);subplot(2,3,ind_stage);hold on;
    titleplot = sprintf('Old, ind stage = %d', ind_stage);
    title(titleplot);
    w1 = 0.5;
    ax = gca;
    ax.XTick = 1:8; 
    ax.XTickLabels = morp_list_o;
    ax.XTickLabelRotation = 45;
    bar(ax.XTick,p_val_O(ind_stage,:),w1,'FaceColor',[0.2 0.2 0.5]);
    hold on
    w2 = .25;
    bar(ax.XTick,p_glr_O(ind_stage,:),w2,'FaceColor',[0 0.7 0.7]);
    grid on
    ylabel('Coefficients')
    legend({'Two-sample Kolmogorov-Smirnov test','generalized linear regression model test'},'Location','northwest')
    hold off 

    % plot cdf
    % Young
    pd_gamma_p12 = makedist('Gamma','a',1,'b',2);
    ax = gca;
    ax.XTick = 1:10;
    cdf_gamma_y_ks = cdf(pd_gamma_p12,p_val_Y(ind_stage,:));
    cdf_gamma_y_glr = cdf(pd_gamma_p12,p_glr_Y(ind_stage,:));
    figure(fig+6);
    subplot(2,3,ind_stage);hold on;
    titleplot = sprintf('Young, ind stage = %d, Gamma function', ind_stage);
    title(titleplot);
    J = plot(ax.XTick,cdf_gamma_y_ks,'color',[0.2 0.2 0.5]);
    hold on;
    L = plot(ax.XTick,cdf_gamma_y_glr,'m-.');
    set(J,'LineWidth',2);
    legend([J L],'KS','GLR','Location','southoutside');
    xlim([1 10])
    ax.XTickLabels = morp_list_y;
    ax.XTickLabelRotation = 45;
    hold off;

    % Old
    pd_gamma_p12 = makedist('Gamma','a',1,'b',2);
    ax = gca;
    ax.XTick = 1:8;
    cdf_gamma_o_ks = cdf(pd_gamma_p12,p_val_O(ind_stage,:));
    cdf_gamma_o_glr = cdf(pd_gamma_p12,p_glr_O(ind_stage,:));
    figure(fig+7);
    subplot(2,3,ind_stage);hold on;
    titleplot = sprintf('Old, ind stage = %d, Gamma function', ind_stage);
    title(titleplot);
    J = plot(ax.XTick,cdf_gamma_o_ks,'color',[0.2 0.2 0.5]);
    hold on;
    L = plot(ax.XTick,cdf_gamma_o_glr,'m-.');
    set(J,'LineWidth',2);
    legend([J L],'KS','GLR','Location','southoutside');
    xlim([1 8])
    ax.XTickLabels = morp_list_o;
    ax.XTickLabelRotation = 45;
    hold off;
end
%saveFigs('Manual_46_10_8');