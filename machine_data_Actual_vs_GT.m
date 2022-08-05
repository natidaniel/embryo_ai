close all;clear;clc
warning off;
%% loading young data
% An application and manual transition time for each stage
UseOld = 'FALSE';
UseYoung = 'TRUE';

if strcmp(UseOld,'TRUE')
   %load('violin_old_data.mat'); % including 9.8, 22.8, 29.8 -sync
   load('violin_old_data_14_03.mat'); % including 6.6
   t_a_d_y = t_a_d_o;
   t_m_d_y = t_m_d_o;
end    

if strcmp(UseYoung,'TRUE')
    %load('violin_young_data.mat'); % including 9.8, 22.8, 29.8 -sync
    load('violin_young_data_14_03.mat'); % including 6.6
end
%% comparison graphs
vfig = 1;
x_common_2_cell_mac = 0:5;
name_2_cell_mac = {'2-cell', '4-cell', '8-cell','Morula','Early Blastocyst','Full Blastocyst'};
% Plot the data usrvival curves
color_vec = [0 0.5 0.5;
    0.5 0 0.5;
    0.5 0.25 0;
    0 0.5 0;
    0.5 0 0;
    0 0 0.5];

% Plot violin
figure(vfig);%hold on
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

name_2_cell_mac = {'2-cell', '4-cell', '8-cell','Morula','Early Blastocyst','Full Blastocyst'};
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
name_2_cell_mac = {'2-cell', '4-cell', '8-cell','Morula','Early Blastocyst','Blastocyst'};
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
set(gca,'XTickLabelRotation',-30);
title({'The probability density of the Embryos developmental time','at different stages'},'FontSize',10);
ylabel('Time [hrs]');
vfig = vfig + 1;

figure(vfig);
t_am_d_y(:,:,1) = t_a_d_y;
t_am_d_y(:,:,2) = t_m_d_y;
name_2_cell_mac = {'2-cell', '4-cell', '8-cell','Morula','Early Blastocyst','Blastocyst'};
iosr.statistics.boxPlot(name_2_cell_mac,t_am_d_y,...
    'showViolin', true,...
    'medianColor', {color_vec(2,:),color_vec(4,:)},... % 'auto'
    'violinColor', {color_vec(2,:),color_vec(4,:)},... % 'auto'
    'lineColor', {color_vec(2,:),color_vec(4,:)},... % 'auto'
    'boxcolor', 'w',...
    'boxWidth', 0.045,...
    'showOutliers', false,...
    'style', 'hierarchy',...
    'groupLabels', {'App', 'Val'});%,...
%'showLegend', true);
box on
set(gca,'XTickLabelRotation',-30);
title({'The probability density of the Embryos developmental time','at different stages','\fontsize{7}{\color[rgb]{.5 0 .5}Application results \color[rgb]{0 0 0}- \color[rgb]{0 .5 0}Manual results}'},'FontSize',10);
ylabel('Time [hrs]');
vfig = vfig + 1;

figure(vfig);
t_am_d_y(:,:,1) = t_a_d_y;
t_am_d_y(:,:,2) = t_m_d_y;
name_2_cell_mac = {'2-cell', '4-cell', '8-cell','Morula','Early Blastocyst','Blastocyst'};
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
set(gca,'XTickLabelRotation',-30);
title({'The probability density of the Embryos developmental time','at different stages'},'FontSize',10);
ylabel('Time [hrs]');
vfig = vfig + 1;

figure(vfig);
t_am_d_y(:,:,1) = t_a_d_y;
t_am_d_y(:,:,2) = t_m_d_y;
name_2_cell_mac = {'2-cell', '4-cell', '8-cell','Morula','Early Blastocyst','Full Blastocyst'};
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
set(gca,'XTickLabelRotation',-30);
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


figure(vfig);
t_am_d_y(:,:,1) = t_a_d_y;
t_am_d_y(:,:,2) = t_m_d_y;
name_2_cell_mac = {'2-cell', '4-cell', '8-cell','Morula','Early Blastocyst','Full Blastocyst'};
iosr.statistics.boxPlot(name_2_cell_mac,t_am_d_y,...
    'showViolin', true,...
    'medianColor', {color_vec(2,:),color_vec(4,:)},... % 'auto'
    'violinColor', {color_vec(2,:),color_vec(4,:)},... % 'auto'
    'lineColor', {color_vec(2,:),color_vec(4,:)},... % 'auto'
    'boxWidth', 0.045,...
    'boxcolor', 'w',...
    'showOutliers', false,...
    'groupLabels', {'Application results', 'Manual results'},...
    'showLegend', true);
box on
set(gca,'XTickLabelRotation',-30);
title({'The probability density of the Embryos developmental time','at different stages'},'FontSize',10);
ylabel('Time [hrs]');
vfig = vfig + 1;

figure(vfig);
t_am_d_y(:,:,1) = t_a_d_y;
t_am_d_y(:,:,2) = t_m_d_y;
name_2_cell_mac = {'2-cell', '4-cell', '8-cell','Morula','Early Blastocyst','Full Blastocyst'};
iosr.statistics.boxPlot(name_2_cell_mac,t_am_d_y,...
    'notch',true,...
    'medianColor','k',...
    'boxcolor','auto',...
    'sampleSize',false,...
    'groupLabels', {'Application results', 'Manual results'},...
    'showLegend', true);
box on
set(gca,'XTickLabelRotation',-30);
title({'The probability density of the Embryos developmental time','at different stages'},'FontSize',10);
ylabel('Time [hrs]');
vfig = vfig + 1;


%% save fig
saveFigs('Time_Violin_4Yoni');