close all; clear;clc;
fig = 1;
%% Read Manual data
file_name_man = 'Embryo All  Times 16.10.18_nd_1701.xlsx';
x_common_2_cell_man = [0:6];
name_2_cell_man = {'2-cell', '4-cell', '8-cell','Compaction','Morula','Early Blastocyst','Blastocyst'};
x_common_4_cell_man = [0:5];
name_4_cell_man = {'4','8','M','C','EB','B'};
ind_main_man = [2:8];
[num_man,txt_man,raw_man] = xlsread(file_name_man,1);
%% Read Machine data
file_name_mac = 'Embryos automated system dev time_nd_1701.xlsx';
x_common_2_cell_mac = [0:5];
name_2_cell_mac = {'2-cell', '4-cell', '8-cell','Morula','Early Blastocyst','Blastocyst'};
x_common_4_cell_mac = [0:4];
name_4_cell_mac = {'4','8','M','EB','B'};
ind_main_mac = [2:8];
[num_mac,txt_mac,raw_mac] = xlsread(file_name_mac,1);
%% concention first index: condition 1-21;2-5; second age 1-y,2-o
% man
raw_work_man = raw_man(ind_main_man,:);
oxygen = [0.21 0.05];
for ind_cond = 1
    for ind_age = [0 1]    
        ind_data_man{ind_cond,ind_age+1} = intersect(find(cell2mat(raw_man(ind_main_man,5))==oxygen(ind_cond)),...
            find(cell2mat(raw_man(ind_main_man,8))==ind_age));
    end
end
%mac
raw_work_mac = raw_mac(ind_main_mac,:);
oxygen = [0.21 0.05];
for ind_cond = 1
    for ind_age = [0 1]    
        ind_data_mac{ind_cond,ind_age+1} = intersect(find(cell2mat(raw_mac(ind_main_mac,5))==oxygen(ind_cond)),...
            find(cell2mat(raw_mac(ind_main_mac,8))==ind_age));
    end
end
%% Run only the 21% exp.
%man
for ind_cond = 1
    for ind_age = [0 1]   
        ind_temp = ind_data_man{ind_cond,ind_age+1};
        time_temp=[];
        for i = 1:length(ind_temp)
            [num_temp,txt_temp,raw_temp] = xlsread(file_name_man,cell2mat(raw_work_man(ind_temp(i),7)),raw_work_man{ind_temp(i),6});
            time_temp = [time_temp ; cell2mat(raw_temp)];
        end
        time_data_man{ind_cond,ind_age+1} = time_temp;   
    end
end
%mac
for ind_cond = 1
    for ind_age = [0 1]   
        ind_temp = ind_data_mac{ind_cond,ind_age+1};
        time_temp=[];
        for i = 1:length(ind_temp)
            [num_temp,txt_temp,raw_temp] = xlsread(file_name_mac,cell2mat(raw_work_mac(ind_temp(i),7)),raw_work_mac{ind_temp(i),6});
            time_temp = [time_temp ; cell2mat(raw_temp)];
        end
        time_data_mac{ind_cond,ind_age+1} = time_temp;   
    end
end
%% Plot the data usrvival curves
color_vec = [0 0.5 0.5;
    0.5 0 0.5;
    0.5 0.25 0;
    0 0.5 0;
    0.5 0 0;
    0 0 0.5];

%% Plot the times for young 21%
time_man =  time_data_man{1,1};time_mac =  time_data_mac{1,1};
[survival_time,cen_man,xx,f,flow,fup,time_mat_man] = time2survival(time_man,x_common_2_cell_man);
[survival_time,cen_mac,xx,f,flow,fup,time_mat_mac] = time2survival(time_mac,x_common_2_cell_mac);

ind_survived_man = find(cen_man==1);
ind_not_survived_man = find(cen_man==0);
ind_survived_mac = find(cen_mac==1);
ind_not_survived_mac = find(cen_mac==0);

%survived
figure(fig);hold on
try
    vs = violinplot(time_mat_man(ind_survived_man,[1:3 5:7]),[],'ShowData',false,'ViolinColor',color_vec(2,:),'MedianColor',color_vec(2,:));
catch
end
try
    vs = violinplot(time_mat_mac(ind_survived_mac,:),[],'ShowData',false,'ViolinColor',color_vec(4,:),'MedianColor',color_vec(4,:));
catch
end
set(gca,'xtick',x_common_2_cell_mac+1,'xticklabel',name_2_cell_mac);
Set_fig_YS(gca,14,14,14);
set(gca,'XTickLabelRotation',-30);
ylabel('Time [hrs]');
title({'The probability density of the Embryos developmental time','at different stages','\fontsize{7}{\color[rgb]{.5 0 .5}Embryo survived - Manual \color[rgb]{0 0 0}- \color[rgb]{0 .5 0}Embryo survived - Machine}'},'FontSize',12);
fig = fig + 1;

%not-survived
figure(fig);hold on
try
    [n,m]=size(time_mat_man(ind_not_survived_man,[1:3 5:7]));
    if n==1
        plot(time_mat_man(ind_not_survived_man,[1:3 5:7]),'o','color',color_vec(2,:),'markerfacecolor',color_vec(2,:));
    else
        vs = violinplot(time_mat_man(ind_not_survived_man,[1:3 5:7]),[],'ShowData',false,'ViolinColor',color_vec(2,:),'MedianColor',color_vec(2,:));
    end
catch
end
try
    [n,m]=size(time_mat_mac(ind_not_survived_mac,:));
    if n==1
        plot(time_mat_mac(ind_not_survived_mac,:),'o','color',color_vec(4,:),'markerfacecolor',color_vec(4,:));
    else
        vs = violinplot(time_mat_mac(ind_not_survived_mac,:),[],'ShowData',false,'ViolinColor',color_vec(4,:),'MedianColor',color_vec(4,:));
    end
catch
end
set(gca,'xtick',x_common_2_cell_mac+1,'xticklabel',name_2_cell_mac);
Set_fig_YS(gca,14,14,14);
set(gca,'XTickLabelRotation',-30);
ylabel('Time [hrs]');
title({'The probability density of the Embryos developmental time','at different stages','\fontsize{7}{\color[rgb]{.5 0 .5}Embryo did not survive - Manual \color[rgb]{0 0 0}- \color[rgb]{0 .5 0}Embryo did not survive - Machine}'},'FontSize',12);
fig = fig + 1;
%% Plot the times for old 21%
time_man =  time_data_man{1,2};time_mac =  time_data_mac{1,2};
[survival_time,cen_man,xx,f,flow,fup,time_mat_man] = time2survival(time_man,x_common_2_cell_man);
[survival_time,cen_mac,xx,f,flow,fup,time_mat_mac] = time2survival(time_mac,x_common_2_cell_mac);

ind_survived_man = find(cen_man==1);
ind_not_survived_man = find(cen_man==0);
ind_survived_mac = find(cen_mac==1);
ind_not_survived_mac = find(cen_mac==0);

%survived
figure(fig);hold on
try
    vs = violinplot(time_mat_man(ind_survived_man,[1:3 5:7]),[],'ShowData',false,'ViolinColor',color_vec(2,:),'MedianColor',color_vec(2,:));
catch
end
try
    vs = violinplot(time_mat_mac(ind_survived_mac,:),[],'ShowData',false,'ViolinColor',color_vec(4,:),'MedianColor',color_vec(4,:));
catch
end
set(gca,'xtick',x_common_2_cell_mac+1,'xticklabel',name_2_cell_mac);
Set_fig_YS(gca,14,14,14);
set(gca,'XTickLabelRotation',-30);
ylabel('Time [hrs]');
title({'The probability density of the Embryos developmental time','at different stages','\fontsize{7}{\color[rgb]{.5 0 .5}Embryo survived - Manual \color[rgb]{0 0 0}- \color[rgb]{0 .5 0}Embryo survived - Machine}'},'FontSize',12);
fig = fig + 1;

%not-survived
figure(fig);hold on
try
    [n,m]=size(time_mat_man(ind_not_survived_man,[1:3 5:7]));
    if n==1
        plot(time_mat_man(ind_not_survived_man,[1:3 5:7]),'o','color',color_vec(2,:),'markerfacecolor',color_vec(2,:));
    else
        vs = violinplot(time_mat_man(ind_not_survived_man,[1:3 5:7]),[],'ShowData',false,'ViolinColor',color_vec(2,:),'MedianColor',color_vec(2,:));
    end
catch
end
try
    [n,m]=size(time_mat_mac(ind_not_survived_mac,:));
    if n==1
        plot(time_mat_mac(ind_not_survived_mac,:),'o','color',color_vec(4,:),'markerfacecolor',color_vec(4,:));
    else
        vs = violinplot(time_mat_mac(ind_not_survived_mac,:),[],'ShowData',false,'ViolinColor',color_vec(4,:),'MedianColor',color_vec(4,:));
    end
catch
end
set(gca,'xtick',x_common_2_cell_mac+1,'xticklabel',name_2_cell_mac);
Set_fig_YS(gca,14,14,14);
set(gca,'XTickLabelRotation',-30);
ylabel('Time [hrs]');
title({'The probability density of the Embryos developmental time','at different stages','\fontsize{7}{\color[rgb]{.5 0 .5}Embryo did not survive - Manual \color[rgb]{0 0 0}- \color[rgb]{0 .5 0}Embryo did not survive - Machine}'},'FontSize',12);
fig = fig + 1;