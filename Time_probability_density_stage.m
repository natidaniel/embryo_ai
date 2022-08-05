close all;clear;clc
%%
UseOld = 'TRUE';
UseYoung = 'FALSE';
ind_stage = 7; histfig = 1;vfig = 15;
data_path = 'C:\Nati\Embryos\4Yoni\paper related\Embryos automated system validation time.xlsx';
warning off;
%% Import data from spreadsheet (embryo Time data)
if strcmp(UseOld,'TRUE')
    % application data
    [~, ~, raw] = xlsread(data_path,'AM TIME total Old','B2:B66');
    A1cell = reshape([raw{:}],size(raw));
    clearvars raw;
    [~, ~, raw] = xlsread(data_path,'AM TIME total Old','C2:C66');
    A2cell = reshape([raw{:}],size(raw));
    clearvars raw;
    [~, ~, raw] = xlsread(data_path,'AM TIME total Old','D2:D65');
    A4cell = reshape([raw{:}],size(raw));
    clearvars raw;
    [~, ~, raw] = xlsread(data_path,'AM TIME total Old','E2:E63');
    A8cell = reshape([raw{:}],size(raw));
    clearvars raw;
    [~, ~, raw] = xlsread(data_path,'AM TIME total Old','F2:F63');
    AMorula = reshape([raw{:}],size(raw));
    clearvars raw;
    [~, ~, raw] = xlsread(data_path,'AM TIME total Old','G2:G54');
    AEB = reshape([raw{:}],size(raw));
    clearvars raw;
    [~, ~, raw] = xlsread(data_path,'AM TIME total Old','H2:H47');
    AFB = reshape([raw{:}],size(raw));
    clearvars raw;
    
    % manual data
    [~, ~, raw] = xlsread(data_path,'AM TIME total Old','I2:I66');
    M1cell = reshape([raw{:}],size(raw));
    clearvars raw;
    [~, ~, raw] = xlsread(data_path,'AM TIME total Old','J2:J66');
    M2cell = reshape([raw{:}],size(raw));
    clearvars raw;
    [~, ~, raw] = xlsread(data_path,'AM TIME total Old','K2:K65');
    M4cell = reshape([raw{:}],size(raw));
    clearvars raw;
    [~, ~, raw] = xlsread(data_path,'AM TIME total Old','L2:L63');
    M8cell = reshape([raw{:}],size(raw));
    clearvars raw;
    [~, ~, raw] = xlsread(data_path,'AM TIME total Old','M2:M63');
    MMorula = reshape([raw{:}],size(raw));
    clearvars raw;
    [~, ~, raw] = xlsread(data_path,'AM TIME total Old','N2:N54');
    MEB = reshape([raw{:}],size(raw));
    clearvars raw;
    [~, ~, raw] = xlsread(data_path,'AM TIME total Old','O2:O47');
    MFB = reshape([raw{:}],size(raw));
    clearvars raw;
    
    % create cell matrix
    t_a_o{1,1} = A1cell;t_a_o{1,2} = A2cell;t_a_o{1,3} = A4cell;t_a_o{1,4} = A8cell;t_a_o{1,5} = AMorula;t_a_o{1,6} = AEB;t_a_o{1,7} = AFB;
    t_m_o{1,1} = M1cell;t_m_o{1,2} = M2cell;t_m_o{1,3} = M4cell;t_m_o{1,4} = M8cell;t_m_o{1,5} = MMorula;t_m_o{1,6} = MEB;t_m_o{1,7} = MFB;
end

if strcmp(UseYoung,'TRUE')
    % application data
    [~, ~, raw] = xlsread(data_path,'AM TIME total Young','B2:B88');
    A1cell = reshape([raw{:}],size(raw));
    clearvars raw;
    [~, ~, raw] = xlsread(data_path,'AM TIME total Young','C2:C88');
    A2cell = reshape([raw{:}],size(raw));
    clearvars raw;
    [~, ~, raw] = xlsread(data_path,'AM TIME total Young','D2:D88');
    A4cell = reshape([raw{:}],size(raw));
    clearvars raw;
    [~, ~, raw] = xlsread(data_path,'AM TIME total Young','E2:E88');
    A8cell = reshape([raw{:}],size(raw));
    clearvars raw;
    [~, ~, raw] = xlsread(data_path,'AM TIME total Young','F2:F87');
    AMorula = reshape([raw{:}],size(raw));
    clearvars raw;
    [~, ~, raw] = xlsread(data_path,'AM TIME total Young','G2:G83');
    AEB = reshape([raw{:}],size(raw));
    clearvars raw;
    [~, ~, raw] = xlsread(data_path,'AM TIME total Young','H2:H71');
    AFB = reshape([raw{:}],size(raw));
    clearvars raw;
    
    % manual data
    [~, ~, raw] = xlsread(data_path,'AM TIME total Young','I2:I88');
    M1cell = reshape([raw{:}],size(raw));
    clearvars raw;
    [~, ~, raw] = xlsread(data_path,'AM TIME total Young','J2:J88');
    M2cell = reshape([raw{:}],size(raw));
    clearvars raw;
    [~, ~, raw] = xlsread(data_path,'AM TIME total Young','K2:K88');
    M4cell = reshape([raw{:}],size(raw));
    clearvars raw;
    [~, ~, raw] = xlsread(data_path,'AM TIME total Young','L2:L88');
    M8cell = reshape([raw{:}],size(raw));
    clearvars raw;
    [~, ~, raw] = xlsread(data_path,'AM TIME total Young','M2:M87');
    MMorula = reshape([raw{:}],size(raw));
    clearvars raw;
    [~, ~, raw] = xlsread(data_path,'AM TIME total Young','N2:N83');
    MEB = reshape([raw{:}],size(raw));
    clearvars raw;
    [~, ~, raw] = xlsread(data_path,'AM TIME total Young','O2:O71');
    MFB = reshape([raw{:}],size(raw));
    clearvars raw;
    
    % create cell matrix
    t_a_y{1,1} = A1cell;t_a_y{1,2} = A2cell;t_a_y{1,3} = A4cell;t_a_y{1,4} = A8cell;t_a_y{1,5} = AMorula;t_a_y{1,6} = AEB;t_a_y{1,7} = AFB;
    t_m_y{1,1} = M1cell;t_m_y{1,2} = M2cell;t_m_y{1,3} = M4cell;t_m_y{1,4} = M8cell;t_m_y{1,5} = MMorula;t_m_y{1,6} = MEB;t_m_y{1,7} = MFB;
end
%% PDF of embryo timing (Application vs. Manual)
% overlapping measure
% automatic saving
format short g
if strcmp(UseOld,'TRUE')
    for i=1:ind_stage
        switch i
            case 1
                s_stage = '1cell';
            case 2
                s_stage = '2cell';
            case 3
                s_stage = '4cell';
            case 4
                s_stage = '8cell';
            case 5
                s_stage = 'Morual';
            case 6
                s_stage = 'Early Blastocyst';
            case 7
                s_stage = 'Full Blastocyst';
        end
        [f_a,xi_a] = ksdensity(t_a_o{1,i},'Function','pdf');
        [f_m,xi_m] = ksdensity(t_m_o{1,i},'Function','pdf');
        [mu1,s1,muci1,sci1] = normfit(t_a_o{1,i});
        [mu2,s2,muci2,sci2] = normfit(t_m_o{1,i});
        if (s1 == 0)
            s1 = s1 + .1;
        end
        if (s2 == 0)
            s2 = s2 + .1;
        end
        xstart = min(min(t_a_o{1,i}),min(t_m_o{1,i}));
        xstart = xstart - 10;
        xend = max(max(t_a_o{1,i}),max(t_m_o{1,i}));
        xend = xend + 10;
        xinterval = .1;
        x_range=xstart:xinterval:xend;
        figure(histfig);
        plot(x_range,[normpdf(x_range,mu1,s1)' normpdf(x_range,mu2,s2)']);
        hold on
        area(x_range,min([normpdf(x_range,mu1,s1)' normpdf(x_range,mu2,s2)']'));
        overlap=cumtrapz(x_range,min([normpdf(x_range,mu1,s1)' normpdf(x_range,mu2,s2)']'));
        overlap2 = overlap(end)*100;
        annotation('textbox', 'String', sprintf('overlap area is %.2f',overlap2));  
        legend_a = sprintf('machine mu = %0.2f', mean(t_a_o{1,i}));
        legend_m = sprintf('manual mu = %0.2f', mean(t_m_o{1,i}));
        legend({legend_a, legend_m},'Location','southoutside');
        title({'The probability density of Embryos developmental time', sprintf('at %s stage', s_stage)},'FontSize',10);
        hold off;
        histfig = histfig + 1;
        figure(histfig);
        plot(xi_a, f_a, 'r-');
        hold on;
        plot(xi_m, f_m, 'g-');
        legend_a = sprintf('machine mu = %0.2f', mean(t_a_o{1,i}));
        legend_m = sprintf('manual mu = %0.2f', mean(t_m_o{1,i}));
        legend({legend_a, legend_m},'Location','southoutside');
        title({'The probability density of Embryos developmental time', sprintf('at %s stage', s_stage)},'FontSize',10);
        hold off;
        histfig = histfig + 1;
    end
end

if strcmp(UseYoung,'TRUE')
    for i=1:ind_stage
        switch i
            case 1
                s_stage = '1cell';
            case 2
                s_stage = '2cell';
            case 3
                s_stage = '4cell';
            case 4
                s_stage = '8cell';
            case 5
                s_stage = 'Morual';
            case 6
                s_stage = 'Early Blastocyst';
            case 7
                s_stage = 'Full Blastocyst';
        end
        [f_a,xi_a] = ksdensity(t_a_y{1,i},'Function','pdf');
        [f_m,xi_m] = ksdensity(t_m_y{1,i},'Function','pdf');
        [mu1,s1,muci1,sci1] = normfit(t_a_y{1,i});
        [mu2,s2,muci2,sci2] = normfit(t_m_y{1,i});
        if (s1 == 0)
            s1 = s1 + .1;
        end
        if (s2 == 0)
            s2 = s2 + .1;
        end
        xstart = min(min(t_a_y{1,i}),min(t_m_y{1,i}));
        xstart = xstart - 10;
        xend = max(max(t_a_y{1,i}),max(t_m_y{1,i}));
        xend = xend + 10;
        xinterval = .1;
        x_range=xstart:xinterval:xend;
        figure(histfig);
        plot(x_range,[normpdf(x_range,mu1,s1)' normpdf(x_range,mu2,s2)']);
        hold on
        area(x_range,min([normpdf(x_range,mu1,s1)' normpdf(x_range,mu2,s2)']'));
        overlap=cumtrapz(x_range,min([normpdf(x_range,mu1,s1)' normpdf(x_range,mu2,s2)']'));
        overlap2 = overlap(end)*100;
        annotation('textbox', 'String', sprintf('overlap area is %.2f',overlap2));
        legend_a = sprintf('machine mu = %0.2f', mean(t_a_y{1,i}));
        legend_m = sprintf('manual mu = %0.2f', mean(t_m_y{1,i}));
        legend({legend_a, legend_m},'Location','southoutside');
        title({'The probability density of Embryos developmental time', sprintf('at %s stage', s_stage)},'FontSize',10);
        hold off;
        histfig = histfig + 1;
        figure(histfig);
        plot(xi_a, f_a, 'r-');
        hold on;
        plot(xi_m, f_m, 'g-');
        legend_a = sprintf('machine mu = %0.2f', mean(t_a_y{1,i}));
        legend_m = sprintf('manual mu = %0.2f', mean(t_m_y{1,i}));
        legend({legend_a, legend_m},'Location','southoutside');
        title({'The probability density of Embryos developmental time', sprintf('at %s stage', s_stage)},'FontSize',10);
        hold off;
        histfig = histfig + 1;
    end
end
% save fig
saveFigs('Time_Total_PDF');
close all
%% comparison graphs
x_common_2_cell_mac = 0:5;
name_2_cell_mac = {'2-cell', '4-cell', '8-cell','Morula','Early Blastocyst','Blastocyst'};
% Plot the data usrvival curves
color_vec = [1 0 1;
    0.5 0 0.5;
    0 1 1;
    0 0.5 0;
    0.5 0 0;
    0 0 0.5];

if strcmp(UseOld,'TRUE')
    [~, ~, raw] = xlsread(data_path,'violinplot_data_old','A2:L66');
    raw(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),raw)) = {''};
    % Replace non-numeric cells with NaN
    R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),raw); % Find non-numeric cells
    raw(R) = {NaN}; % Replace non-numeric cells
    % Create output variable
    DataOld = reshape([raw{:}],size(raw));
    % Clear temporary variables
    clearvars raw R;
    t_a_d_o = DataOld(:,1:6);
    t_m_d_o = DataOld(:,7:12);
    % Plot violin
    figure(vfig);hold on
    try
        vs = violinplot(t_a_d_o,[],'ShowData',false,'ViolinColor',color_vec(2,:),'MedianColor',color_vec(2,:));
    catch
    end
    try
        vs = violinplot(t_m_d_o,[],'ShowData',false,'ViolinColor',color_vec(4,:),'MedianColor',color_vec(4,:));
    catch
    end
    set(gca,'xtick',x_common_2_cell_mac+1,'xticklabel',name_2_cell_mac);
    Set_fig_YS(gca,14,14,14);
    set(gca,'XTickLabelRotation',-30);
    ylabel('Time [hrs]');
    title({'The probability density of the Embryos developmental time','at different stages','\fontsize{7}{\color[rgb]{.5 0 .5}Application results \color[rgb]{0 0 0}- \color[rgb]{0 .5 0}Manual results}'},'FontSize',10);
    vfig = vfig + 1;
    
    % Plot box
    figure(vfig);
    data=cell(6,2);
    for ii=1:size(data,1)
        t_a_d_o_c{ii}=t_a_d_o(:,ii);
        t_m_d_o_c{ii}=t_m_d_o(:,ii);
    end
    data=vertcat(t_a_d_o_c,t_m_d_o_c);
    
    name_2_cell_mac = {'2-cell', '4-cell', '8-cell','Morula','Early Blastocyst','Blastocyst'};
    col=[102,255,255, 200;
        0, 0, 255, 200];
    col=col/255;    
    multiple_boxplot(data',name_2_cell_mac,{'Application results', 'Manual results'},col')
    title({'The probability density of the Embryos developmental time','at different stages'},'FontSize',10);
    ylabel('Time [hrs]');
    set(gca,'XTickLabelRotation',-30);
    vfig = vfig + 1;
    
    figure(vfig);
    t_am_d_o(:,:,1) = t_a_d_o;
    t_am_d_o(:,:,2) = t_m_d_o;
    name_2_cell_mac = {'2-cell', '4-cell', '8-cell','Morula','Early Blasto','Blasto'};
    iosr.statistics.boxPlot(name_2_cell_mac,t_am_d_o,...
        'notch',true,...
        'symbolMarker',{'+','o'},...
        'medianColor','k',...
        'boxcolor','auto',...
        'sampleSize',false,...
        'style','hierarchy',...
        'groupLabels',{'App', 'Val'},...
        'showLegend',true);
    box on
    title({'The probability density of the Embryos developmental time','at different stages'},'FontSize',10);
    ylabel('Time [hrs]');
    vfig = vfig + 1;
    
    figure(vfig);
    t_am_d_o(:,:,1) = t_a_d_o;
    t_am_d_o(:,:,2) = t_m_d_o;
    name_2_cell_mac = {'2-cell', '4-cell', '8-cell','Morula','Early Blasto','Blasto'};
    iosr.statistics.boxPlot(name_2_cell_mac,t_am_d_o,...
        'showViolin', true,...
        'medianColor', {color_vec(2,:),color_vec(4,:)},... % 'auto'
        'violinColor', {color_vec(2,:),color_vec(4,:)},... % 'auto'
        'medianColor', 'auto',...
        'lineColor', {color_vec(2,:),color_vec(4,:)},... % 'auto'
        'boxcolor', 'w',...
        'boxWidth', 0.025,...
        'showOutliers', false,...
        'style', 'hierarchy',...
        'groupLabels', {'App', 'Val'});%,...
        %'showLegend', true);
    box on
    title({'The probability density of the Embryos developmental time','at different stages','\fontsize{7}{\color[rgb]{.5 0 .5}Application results \color[rgb]{0 0 0}- \color[rgb]{0 .5 0}Manual results}'},'FontSize',10);
    ylabel('Time [hrs]');
    vfig = vfig + 1;
    
    figure(vfig);
    t_am_d_o(:,:,1) = t_a_d_o;
    t_am_d_o(:,:,2) = t_m_d_o;
    name_2_cell_mac = {'2-cell', '4-cell', '8-cell','Morula','Early Blasto','Blasto'};
    iosr.statistics.boxPlot(name_2_cell_mac,t_am_d_o,...
        'showViolin', true,...
        'medianColor', 'auto',...
        'violinColor', 'auto',...
        'medianColor', 'auto',...
        'lineColor', 'auto',...
        'boxcolor', 'w',...
        'boxWidth', 0.025,...
        'showOutliers', false,...
        'style', 'hierarchy',...
        'groupLabels', {'App', 'Val'},...
        'showLegend', true);
    box on
    title({'The probability density of the Embryos developmental time','at different stages'},'FontSize',10);
    ylabel('Time [hrs]');
    vfig = vfig + 1;
    
    figure(vfig);
    t_am_d_o(:,:,1) = t_a_d_o;
    t_am_d_o(:,:,2) = t_m_d_o;
    name_2_cell_mac = {'2-cell', '4-cell', '8-cell','Morula','Early Blasto','Blasto'};
    iosr.statistics.boxPlot(name_2_cell_mac,t_am_d_o,...
        'showViolin', true,...
        'medianColor', {color_vec(2,:),color_vec(4,:)},... % 'auto'
        'violinColor', {color_vec(2,:),color_vec(4,:)},... % 'auto'
        'medianColor', 'auto',...
        'lineColor', {color_vec(2,:),color_vec(4,:)},... % 'auto'
        'boxcolor', 'w',...
        'boxWidth', 0.025,...
        'showOutliers', false,...
        'groupLabels', {'App', 'Val'});%,...
        %'showLegend', true);
    box on
    title({'The probability density of the Embryos developmental time','at different stages','\fontsize{7}{\color[rgb]{.5 0 .5}Application results \color[rgb]{0 0 0}- \color[rgb]{0 .5 0}Manual results}'},'FontSize',10);
    ylabel('Time [hrs]');
    vfig = vfig + 1;
    
    figure(vfig);
    t_am_d_o(:,:,1) = t_a_d_o;
    t_am_d_o(:,:,2) = t_m_d_o;
    name_2_cell_mac = {'2-cell', '4-cell', '8-cell','Morula','Early Blasto','Blasto'};
    iosr.statistics.boxPlot(name_2_cell_mac,t_am_d_o,...
        'showViolin', true,...
        'medianColor', 'auto',...
        'violinColor', 'auto',...
        'medianColor', 'auto',...
        'lineColor', 'auto',...
        'boxcolor', 'w',...
        'boxWidth', 0.025,...
        'showOutliers', false,...
        'groupLabels', {'App', 'Val'},...
        'showLegend', true);
    box on
    title({'The probability density of the Embryos developmental time','at different stages'},'FontSize',10);
    ylabel('Time [hrs]');
    vfig = vfig + 1;
end

if strcmp(UseYoung,'TRUE')
    [~, ~, raw] = xlsread(data_path,'violinplot_data_young','A2:L88');
    raw(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),raw)) = {''};
    % Replace non-numeric cells with NaN
    R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),raw); % Find non-numeric cells
    raw(R) = {NaN}; % Replace non-numeric cells
    % Create output variable
    DataYoung = reshape([raw{:}],size(raw));
    % Clear temporary variables
    clearvars raw R;
    t_a_d_y = DataYoung(:,1:6);
    t_m_d_y = DataYoung(:,7:12);
    
    % Plot violin
    figure(vfig);hold on
    try
        vs = violinplot(t_a_d_y,[],'ShowData',false,'ViolinColor',color_vec(2,:),'MedianColor',color_vec(2,:));
    catch
    end
    try
        vs = violinplot(t_m_d_y,[],'ShowData',false,'ViolinColor',color_vec(4,:),'MedianColor',color_vec(4,:));
    catch
    end
    set(gca,'xtick',x_common_2_cell_mac+1,'xticklabel',name_2_cell_mac);
    Set_fig_YS(gca,14,14,14);
    set(gca,'XTickLabelRotation',-30);
    ylabel('Time [hrs]');
    title({'The probability density of the Embryos developmental time','at different stages','\fontsize{7}{\color[rgb]{.5 0 .5}Application results \color[rgb]{0 0 0}- \color[rgb]{0 .5 0}Manual results}'},'FontSize',10);
    vfig = vfig + 1;
    
    % Plot box
    figure(vfig);
    data=cell(6,2);
    for ii=1:size(data,1)
        t_a_d_y_c{ii}=t_a_d_y(:,ii);
        t_m_d_y_c{ii}=t_m_d_y(:,ii);
    end
    data=vertcat(t_a_d_y_c,t_m_d_y_c);
    
    name_2_cell_mac = {'2-cell', '4-cell', '8-cell','Morula','Early Blastocyst','Blastocyst'};
    col=[102,255,255, 200;
        0, 0, 255, 200];
    col=col/255;    
    multiple_boxplot(data',name_2_cell_mac,{'Application results', 'Manual results'},col')
    title({'The probability density of the Embryos developmental time','at different stages'},'FontSize',10);
    ylabel('Time [hrs]');
    set(gca,'XTickLabelRotation',-30);
    vfig = vfig + 1;
    
    figure(vfig);
    t_am_d_y(:,:,1) = t_a_d_y;
    t_am_d_y(:,:,2) = t_m_d_y;
    name_2_cell_mac = {'2-cell', '4-cell', '8-cell','Morula','Early Blasto','Blasto'};
    iosr.statistics.boxPlot(name_2_cell_mac,t_am_d_y,...
        'notch',true,...
        'medianColor','k',...
        'symbolMarker',{'+','o'},...
        'boxcolor','auto',...
        'sampleSize',false,...
        'style','hierarchy',...
        'groupLabels',{'App', 'Val'});%,...
        %'showLegend',true);
    box on
    title({'The probability density of the Embryos developmental time','at different stages'},'FontSize',10);
    ylabel('Time [hrs]');
    vfig = vfig + 1;
    
    figure(vfig);
    t_am_d_y(:,:,1) = t_a_d_y;
    t_am_d_y(:,:,2) = t_m_d_y;
    name_2_cell_mac = {'2-cell', '4-cell', '8-cell','Morula','Early Blasto','Blasto'};
    iosr.statistics.boxPlot(name_2_cell_mac,t_am_d_y,...
        'showViolin', true,...
        'medianColor', {color_vec(2,:),color_vec(4,:)},... % 'auto'
        'violinColor', {color_vec(2,:),color_vec(4,:)},... % 'auto'
        'medianColor', {color_vec(2,:),color_vec(4,:)},...
        'lineColor', {color_vec(2,:),color_vec(4,:)},... % 'auto'
        'boxcolor', 'w',...
        'boxWidth', 0.045,...
        'showOutliers', false,...
        'style', 'hierarchy',...
        'groupLabels', {'App', 'Val'});%,...
        %'showLegend', true);
    box on
    title({'The probability density of the Embryos developmental time','at different stages','\fontsize{7}{\color[rgb]{.5 0 .5}Application results \color[rgb]{0 0 0}- \color[rgb]{0 .5 0}Manual results}'},'FontSize',10);
    ylabel('Time [hrs]');
    vfig = vfig + 1;
    
    figure(vfig);
    t_am_d_y(:,:,1) = t_a_d_y;
    t_am_d_y(:,:,2) = t_m_d_y;
    name_2_cell_mac = {'2-cell', '4-cell', '8-cell','Morula','Early Blasto','Blasto'};
    iosr.statistics.boxPlot(name_2_cell_mac,t_am_d_y,...
        'showViolin', true,...
        'medianColor', 'auto',...
        'violinColor', 'auto',...
        'medianColor', 'auto',...
        'lineColor', 'auto',...
        'boxcolor', 'w',...
        'boxWidth', 0.045,...
        'showOutliers', false,...
        'style', 'hierarchy',...
        'groupLabels', {'App', 'Val'},...
        'showLegend', true);
    box on
    title({'The probability density of the Embryos developmental time','at different stages'},'FontSize',10);
    ylabel('Time [hrs]');
    vfig = vfig + 1;
    
    figure(vfig);
    t_am_d_y(:,:,1) = t_a_d_y;
    t_am_d_y(:,:,2) = t_m_d_y;
    name_2_cell_mac = {'2-cell', '4-cell', '8-cell','Morula','Early Blasto','Blasto'};
    iosr.statistics.boxPlot(name_2_cell_mac,t_am_d_y,...
        'showViolin', true,...
        'medianColor', {color_vec(2,:),color_vec(4,:)},... % 'auto'
        'violinColor', {color_vec(2,:),color_vec(4,:)},... % 'auto'
        'medianColor', {color_vec(2,:),color_vec(4,:)},...
        'lineColor', {color_vec(2,:),color_vec(4,:)},... % 'auto'
        'boxcolor', 'w',...
        'boxWidth', 0.045,...
        'showOutliers', false,...
        'groupLabels', {'App', 'Val'});%,...
        %'showLegend', true);
    box on
    title({'The probability density of the Embryos developmental time','at different stages','\fontsize{7}{\color[rgb]{.5 0 .5}Application results \color[rgb]{0 0 0}- \color[rgb]{0 .5 0}Manual results}'},'FontSize',10);
    ylabel('Time [hrs]');
    vfig = vfig + 1;
    
    figure(vfig);
    t_am_d_y(:,:,1) = t_a_d_y;
    t_am_d_y(:,:,2) = t_m_d_y;
    name_2_cell_mac = {'2-cell', '4-cell', '8-cell','Morula','Early Blastocyst','Full Blastocyst'};
    iosr.statistics.boxPlot(name_2_cell_mac,t_am_d_y,...
        'showViolin', true,...
        'medianColor', 'auto',...
        'violinColor', 'auto',...
        'medianColor', 'auto',...
        'lineColor', 'auto',...
        'boxcolor', 'w',...
        'boxWidth', 0.045,...
        'showOutliers', false,...
        'groupLabels', {'Application results', 'Manual results'},...
        'showLegend', true);
    box on
    set(gca,'XTickLabelRotation',-30);
    title({'The probability density of the Embryos developmental time','at different stages'},'FontSize',10);
    ylabel('Time [hrs]');
    vfig = vfig + 1;
end
%% save fig
saveFigs('Time_Violin');