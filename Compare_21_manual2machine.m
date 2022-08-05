close all; clear;clc;
fig = 1;
Machine = 'FALSE';
Manual = 'TRUE';
%% Read Manual data
if strcmp(Manual,'TRUE')
    file_name = 'Embryo All  Times 16.10.18_nd_1701.xlsx';
    x_common_2_cell = [0:6];
    name_2_cell = {'2-cell', '4-cell', '8-cell','Compaction','Morula','Early Blastocyst','Blastocyst'};
    x_common_4_cell = [0:5];
    name_4_cell = {'4','8','M','C','EB','B'};
    ind_main = [2:8];
    [num,txt,raw] = xlsread(file_name,1);
end
%% Read Machine data
if strcmp(Machine,'TRUE')
    file_name = 'Embryos automated system dev time_nd_1701.xlsx';
    x_common_2_cell = [0:5];
    name_2_cell = {'2-cell', '4-cell', '8-cell','Morula','Early Blastocyst','Blastocyst'};
    x_common_4_cell = [0:4];
    name_4_cell = {'4','8','M','EB','B'};
    ind_main = [2:8];
    [num,txt,raw] = xlsread(file_name,1);
end
%% concention first index: condition 1-21;2-5; second age 1-y,2-o
raw_work = raw(ind_main,:);
oxygen = [0.21 0.05];
for ind_cond = 1
    for ind_age = [0 1]    
        ind_data{ind_cond,ind_age+1} = intersect(find(cell2mat(raw(ind_main,5))==oxygen(ind_cond)),...
            find(cell2mat(raw(ind_main,8))==ind_age));
    end
end
%% Run only the 21% exp.
for ind_cond = 1
    for ind_age = [0 1]   
        ind_temp = ind_data{ind_cond,ind_age+1};
        time_temp=[];
        for i = 1:length(ind_temp)
            [num_temp,txt_temp,raw_temp] = xlsread(file_name,cell2mat(raw_work(ind_temp(i),7)),raw_work{ind_temp(i),6});
            time_temp = [time_temp ; cell2mat(raw_temp)];
        end
        time_data{ind_cond,ind_age+1} = time_temp;   
    end
end
%% Plot the data usrvival curves
color_vec = [0 0.5 0.5;
    0.5 0 0.5;
    0.5 0.25 0;
    0 0.5 0;
    0.5 0 0;
    0 0 0.5];
%% 2 cell
ind_cond = 1;% only 21% exp.
for i = 1:2 %old and young
    time =  time_data{ind_cond,i} ;
    [survival_time,cen,xx,f,flow,fup,time_mat] = time2survival(time,x_common_2_cell);
    figure(fig);hold on;
    stairs(xx,f,'color',color_vec(i,:),'linewidth',2);
end
% legend({'1' '2' '3' '4' '5' '6'})
set(gca,'xtick',x_common_2_cell,'xticklabel',name_2_cell)
ylim([0 1.05]);
Set_fig_YS(gca,14,14,14)
set(gca,'XTickLabelRotation',-30)
fig = fig + 1;
%% 4 cell
for i = 1:2
    time =  time_data{ind_cond,i} ;
    [survival_time,cen,xx,f,flow,fup,time_mat] = time2survival(time(:,2:end),x_common_4_cell);
    figure(fig);hold on
    stairs(xx,f,'color',color_vec(i,:),'linewidth',2);
end
set(gca,'xtick',x_common_4_cell,'xticklabel',name_4_cell)
ylim([0.4 1.05]);
Set_fig_YS(gca,18,18,18)
fig = fig + 1;
%% Compare young and old HR for 21%
timeA =  time_data{1,1}; % Young
timeB =  time_data{1,2}; % old
[HR(1),p,NA,NB] = HRfromTime(timeA,timeB,x_common_2_cell)
[HR(2),p,NA,NB] = HRfromTime(timeA(:,2:end),timeB(:,2:end),x_common_2_cell)

figure(fig);
b = bar([HR(1:2)],'FaceAlpha',0.3);
ylim([0.8 1.8]);
fig = fig + 1;
%% Plot the times for young 21%
time =  time_data{1,1};
[survival_time,cen,xx,f,flow,fup,time_mat] = time2survival(time,x_common_2_cell);
ind_survived = find(cen==1);
ind_not_survived = find(cen==0);

figure(fig);hold on
try
    vs = violinplot(time_mat(ind_survived,:),[],'ShowData',false,'ViolinColor',color_vec(2,:),'MedianColor',color_vec(2,:));
catch
end
try
    [n,m]=size(time_mat(ind_not_survived,:))
    if n==1
        plot(time_mat(ind_not_survived,:),'o','color',color_vec(2,:),'markerfacecolor',color_vec(4,:));
    else
        vs = violinplot(time_mat(ind_not_survived,:),[],'ShowData',false,'ViolinColor',color_vec(4,:),'MedianColor',color_vec(4,:));
    end
catch
end
set(gca,'xtick',x_common_2_cell+1,'xticklabel',name_2_cell)
Set_fig_YS(gca,14,14,14)
set(gca,'XTickLabelRotation',-30)
ylabel('Time [hrs]');
title({'The probability density of the Embryos developmental time','at different stages','\fontsize{7}{\color[rgb]{.5 0 .5}Embryo survived \color[rgb]{0 0 0}- \color[rgb]{0 .5 0}Embryo did not survive}'},'FontSize',12);


% Calcuate KS test
for i= 1:7
    deaths(i) = length(find(survival_time==i));
    if i == 1
        alive(i) = NA;
    else
        alive(i) = alive(i-1)-deaths(i-1);
    end
    
    try
        [temp,ks_p(i)] = kstest2(time_mat(ind_survived,i),time_mat(ind_not_survived,i));
    catch
    end
end
p_young = exp(diff(log(alive)));
fig = fig + 1;
%% Plot the times for old 21%
time =  time_data{1,2};
[survival_time,cen,xx,f,flow,fup,time_mat] = time2survival(time,x_common_2_cell);
ind_survived = find(cen==1);
ind_not_survived = find(cen==0);

figure(fig);hold on
try
    vs = violinplot(time_mat(ind_survived,:),[],'ShowData',false,'ViolinColor',color_vec(2,:),'MedianColor',color_vec(2,:));
catch
end
try
    [n,m]=size(time_mat(ind_not_survived,:))
    if n==1
        plot(time_mat(ind_not_survived,:),'o','color',color_vec(2,:),'markerfacecolor',color_vec(4,:));
    else
        vs = violinplot(time_mat(ind_not_survived,:),[],'ShowData',false,'ViolinColor',color_vec(4,:),'MedianColor',color_vec(4,:));
    end
catch
end
set(gca,'xtick',x_common_2_cell+1,'xticklabel',name_2_cell)
Set_fig_YS(gca,14,14,14)
set(gca,'XTickLabelRotation',-30)
ylabel('Time [hrs]');
title({'The probability density of the Embryos developmental time','at different stages','\fontsize{7}{\color[rgb]{.5 0 .5}Embryo survived \color[rgb]{0 0 0}- \color[rgb]{0 .5 0}Embryo did not survive}'},'FontSize',12);


% Calcuate KS test
for i= 1:7
    deaths(i) = length(find(survival_time==i));
    if i == 1
        alive(i) = NA;
    else
        alive(i) = alive(i-1)-deaths(i-1);
    end
    
    try
        [temp,ks_p(i)] = kstest2(time_mat(ind_survived,i),time_mat(ind_not_survived,i));
    catch
    end
end

p_old = exp(diff(log(alive)));
fig = fig + 1;
%% plot the time for survived
time =  time_data{1,1};
[survival_time,cen,xx,f,flow,fup,time_mat] = time2survival(time,x_common_2_cell);
time =  time_data{1,2};
[survival_time,cen_o,xx,f,flow,fup,time_mat_o] = time2survival(time,x_common_2_cell);
ind_survived = find(cen==1);
ind_survived_o = find(cen_o==1);

figure(fig);hold on

vs = violinplot(time_mat(ind_survived,:),[],'ShowData',false,'ViolinColor',color_vec(2,:),'MedianColor',color_vec(2,:));

vs = violinplot(time_mat_o(ind_survived_o,:),[],'ShowData',false,'ViolinColor',color_vec(4,:),'MedianColor',color_vec(4,:));

set(gca,'xtick',x_common_2_cell+1,'xticklabel',name_2_cell)
Set_fig_YS(gca,14,14,14)
set(gca,'XTickLabelRotation',-30)
ylabel('Time [hrs]');
title({'The probability density of the Survived Embryos developmental time','at different stages','\fontsize{7}{\color[rgb]{.5 0 .5}Young Embryo \color[rgb]{0 0 0}- \color[rgb]{0 .5 0}Old Embryo}'},'FontSize',12);

fig = fig + 1;
saveFigs('Time');

%% Save manual and machine data
if strcmp(Machine,'TRUE')
    [survival_time,cen_machine,xx,f,flow,fup,time_mat_machine ] = time2survival(time_data{1,1},x_common_2_cell);
    [survival_time,cen_o_machine,xx,f,flow,fup,time_mat_o_machine] = time2survival(time_data{1,2},x_common_2_cell);
    %save machine_14_03 cen_machine time_mat_machine cen_o_machine time_mat_o_machine
end
if strcmp(Manual,'TRUE')
    [survival_time,cen_manual,xx,f,flow,fup,time_mat_manual ] = time2survival(time_data{1,1},x_common_2_cell);
    [survival_time,cen_o_manual,xx,f,flow,fup,time_mat_o_manual] = time2survival(time_data{1,2},x_common_2_cell);
    %save manual_14_03 cen_manual time_mat_manual cen_o_manual time_mat_o_manual
end
%% Load and compare - plot Manual vs Machine graphs
close all; clear;
fig = 1;
%load manual_18_01.mat  % (9.8,22.8,29.8) = Old 40, Young 38
load manual_14_03.mat  % (9.8,22.8,29.8,6.6) = Old 41, Young 62
%load machine_18_01.mat % (9.8,22.8,29.8) = Old 40, Young 38
load machine_14_03.mat  % (9.8,22.8,29.8,6.6) = Old 41, Young 62
% manual
ind_survived = find(cen_manual==1); ind_not_survived = find(cen_manual==0);
ind_survived_o = find(cen_o_manual==1);    ind_not_survived_o = find(cen_o_manual==0);
% machine
ind_survived_machine = find(cen_machine==1);ind_not_survived_machine = find(cen_machine==0);
ind_survived_o_machine = find(cen_o_machine==1);    ind_not_survived_o_machine = find(cen_o_machine==0);
figure(fig);hold on;
plot(nanmedian(time_mat_manual(ind_survived,[1:3,5:end]))', nanmedian(time_mat_machine(ind_survived_machine,:))','ko');
plot(nanmedian(time_mat_manual(ind_not_survived,[1:3,5:end]))', nanmedian(time_mat_machine(ind_not_survived_machine,:))','kx');

plot(nanmedian(time_mat_o_manual(ind_survived_o,[1:3,5:end]))', nanmedian(time_mat_o_machine(ind_survived_o_machine,:))','ro');
plot(nanmedian(time_mat_o_manual(ind_not_survived_o,[1:3,5:end]))', nanmedian(time_mat_o_machine(ind_not_survived_o_machine,:))','rx');

refline(1,0);
legend({'Young Survive','Young not Survive','Old Survive','old not Survive'})
xlabel('Median Manual')
ylabel('Median Machine')
Set_fig_YS(gcf,18,18,18)
axis equal
fig = fig + 1;

%% Load and compare - plot Manual vs Machine graphs w/o notice to Old and Young
close all; clear;
fig = 1;
%load manual_18_01.mat
%load machine_18_01.mat
load manual_14_03.mat
load machine_14_03.mat

% manual
ind_survived = find(cen_manual==1); ind_not_survived = find(cen_manual==0);
ind_survived_o = find(cen_o_manual==1);    ind_not_survived_o = find(cen_o_manual==0);
% machine
ind_survived_machine = find(cen_machine==1);ind_not_survived_machine = find(cen_machine==0);
ind_survived_o_machine = find(cen_o_machine==1);    ind_not_survived_o_machine = find(cen_o_machine==0);
figure(fig);hold on
p1 = plot(nanmedian(time_mat_manual(ind_survived,[1:3,5:end]))', nanmedian(time_mat_machine(ind_survived_machine,:))','ko');
p2 = plot(nanmedian(time_mat_manual(ind_not_survived,[1:3,5:end]))', nanmedian(time_mat_machine(ind_not_survived_machine,:))','kx');
p3 = plot(nanmedian(time_mat_o_manual(ind_survived_o,[1:3,5:end]))', nanmedian(time_mat_o_machine(ind_survived_o_machine,:))','ko');
p4 = plot(nanmedian(time_mat_o_manual(ind_not_survived_o,[1:3,5:end]))', nanmedian(time_mat_o_machine(ind_not_survived_o_machine,:))','kx');
refline(1,0);
legend('Embryo survived','Embryo did not survive');
xlabel('Median Manual')
ylabel('Median Machine')
Set_fig_YS(gcf,18,18,18)
axis equal
fig = fig + 1;
