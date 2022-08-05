%%
clc;close all;clear
%%
UseOld = 'FALSE';
UseYoung = 'TRUE';

if strcmp(UseOld,'TRUE')
    load('YET_O.mat'); % including 9.8, 22.8, 29.8 -sync
    %load('YET_O_14_03.mat'); % including 6.6
end

if strcmp(UseYoung,'TRUE')
    load('YET_Y.mat'); % including 9.8, 22.8, 29.8 -sync
    %load('YET_Y_14_03.mat');% including 6.6
end

%load('YET_all.mat'); % old graphs - not sync
%%
figure(1);
histfit(YET);
title('Application Time Error')
xlabel('Error [%]')
ylabel('Time Error Distribution') 

%%
YETABS=abs(YET);
pd = fitdist(YETABS,'Normal');
x_values = 0:.1:100;
y = pdf(pd,x_values);
figure(2);
plot(x_values,y,'LineWidth',2)
title('Application Time Error')
xlabel('Error [%]')
ylabel('Time Error Distribution') 

%%
x_values = 0:.1:10;
YETABS1c=abs(YET1c);pd1c = fitdist(YETABS1c,'Normal');y1 = pdf(pd1c,x_values);
YETABS2c=abs(YET2c);pd2c = fitdist(YETABS2c,'Normal');y2 = pdf(pd2c,x_values);
YETABS4c=abs(YET4c);pd4c = fitdist(YETABS4c,'Normal');y4 = pdf(pd4c,x_values);
YETABS8c=abs(YET8c);pd8c = fitdist(YETABS8c,'Normal');y8 = pdf(pd8c,x_values);
YETABSm=abs(YETm);pdm = fitdist(YETABSm,'Normal');ym = pdf(pdm,x_values);
YETABSeb=abs(YETeb);pdeb = fitdist(YETABSeb,'Normal');ye = pdf(pdeb,x_values);
YETABSfb=abs(YETfb);pdfb = fitdist(YETABSfb,'Normal');yf = pdf(pdfb,x_values);
y1 = nantozero(y1);
yf = nantozero(yf);
figure(3);
plot(x_values,y1);
hold on;
plot(x_values,y2);
hold on;
plot(x_values,y4);
hold on;
plot(x_values,y8);
hold on;
plot(x_values,ym);
hold on;
plot(x_values,ye);
hold on;
plot(x_values,yf);
title('Application Time Error')
xlabel('Error [%]')
ylabel('Time Error Distribution') 
legend('1cell','2cell','4cell','8cell','Morula','Early Blastocyst','Full Blastocyst')

%%
x_values = -5:.1:5;
YTEABS1c=abs(YTE1);pd1 = fitdist(YTEABS1c,'Normal');yt1 = pdf(pd1,x_values);
YTEABS2c=abs(YTE2);pd2 = fitdist(YTEABS2c,'Normal');yt2 = pdf(pd2,x_values);
YTEABS4c=abs(YTE4);pd4 = fitdist(YTEABS4c,'Normal');yt4 = pdf(pd4,x_values);
YTEABS8c=abs(YTE8);pd8 = fitdist(YTEABS8c,'Normal');yt8 = pdf(pd8,x_values);
YTEABSm=abs(YTEm);pdmt = fitdist(YTEABSm,'Normal');ytm = pdf(pdmt,x_values);
YTEABSeb=abs(YTEeb);pdebt = fitdist(YTEABSeb,'Normal');yte = pdf(pdebt,x_values);
YTEABSfb=abs(YTEfb);pdfbt = fitdist(YTEABSfb,'Normal');ytf = pdf(pdfbt,x_values);
yt1 = nantozero(yt1);
ytf = nantozero(ytf);
figure(4);
plot(x_values,yt1);
hold on;
plot(x_values,yt2);
hold on;
plot(x_values,yt4);
hold on;
plot(x_values,yt8);
hold on;
plot(x_values,ytm);
hold on;
plot(x_values,yte);
hold on;
plot(x_values,ytf);
title('Application Time Error')
xlabel('Error [hours]')
ylabel('Time Error Distribution') 
legend('1cell','2cell','4cell','8cell','Morula','Early Blastocyst','Full Blastocyst')

%%
figure(5);
histfit(YTE);
title('Application Time Error')
xlabel('Error [hours]')
ylabel('Time Error Distribution') 

%% 
figure(6);
subplot(2,3,1);
histogram(YTE2,'Normalization','pdf','BinMethod','integers');
xlim([-2, 2]);
title('2cell')
subplot(2,3,2);
histogram(YTE4,'Normalization','pdf','BinMethod','integers');
xlim([-2, 2]);
title('4cell')
subplot(2,3,3);
histogram(YTE8,'Normalization','pdf','BinMethod','integers');
title('8cell')
subplot(2,3,4);
histogram(YTEm,'Normalization','pdf','BinMethod','integers');
title('Morula')
subplot(2,3,5);
histogram(YTEeb,'Normalization','pdf','BinMethod','integers');
title('Early Blastocyst')
subplot(2,3,6);
histogram(YTEfb,'Normalization','pdf','BinMethod','integers');
xlim([-2, 2]);
title('Full Blastocyst')
[ax1,h1]=suplabel('Error [hours]');
[ax2,h2]=suplabel('Frequency','y');
suptitle('Application histograms with a Time error distribution');

%%
figure(7);
subplot(2,3,1);
histogram(YET2c,'Normalization','pdf','BinMethod','integers');
title('2cell')
subplot(2,3,2);
histogram(YET4c,'Normalization','pdf','BinMethod','integers');
title('4cell')
subplot(2,3,3);
histogram(YET8c,'Normalization','pdf','BinMethod','integers');
title('8cell')
subplot(2,3,4);
histogram(YETm,'Normalization','pdf','BinMethod','integers');
title('Morula')
subplot(2,3,5);
histogram(YETeb,'Normalization','pdf','BinMethod','integers');
title('Early Blastocyst')
subplot(2,3,6);
histogram(YETfb,'Normalization','pdf','BinMethod','integers');
xlim([-2, 2]);
title('Full Blastocyst')
[ax1,h1]=suplabel('Error [%]');
[ax2,h2]=suplabel('Frequency','y');
suptitle('Application histograms with a Time error distribution');

%%
figure(8);
subplot(2,4,1);
histogram(YTE2,'Normalization','pdf','BinMethod','integers');
xlim([-2, 2]);
title('2cell')
subplot(2,4,2);
histogram(YTE4,'Normalization','pdf','BinMethod','integers');
xlim([-2, 2]);
title('4cell')
subplot(2,4,3);
histogram(YTE8,'Normalization','pdf','BinMethod','integers');
title('8cell')
subplot(2,4,5);
histogram(YTEm,'Normalization','pdf','BinMethod','integers');
title('Morula')
subplot(2,4,6);
histogram(YTEeb,'Normalization','pdf','BinMethod','integers');
title('Early Blastocyst')
xlabel('Error [hours]')   
subplot(2,4,7);
histogram(YTEfb,'Normalization','pdf','BinMethod','integers');
xlim([-2, 2]);
title('Full Blastocyst')
subplot(2,4,[4,8])
h1 = histogram(YET,'Normalization','pdf','BinMethod','integers');
title('All embryo stages')
xlabel('Error [%]')   
[ax2,h2]=suplabel('Frequency','y');
suptitle('Application histograms with a Time error distribution');

%%
figure(9);
h = histogram(YET,'Normalization','pdf','BinMethod','integers');
title('Application Time Error')
xlabel('Error [%]')
ylabel('Frequency') 

%%
figure(10);
h = histogram(YTE,'Normalization','pdf','BinMethod','integers');
title('Application Time Error')
xlabel('Error [%]')
ylabel('Frequency') 

%%
figure(11);
subplot(1,2,1)
h1 = histogram(YET,'Normalization','pdf','BinMethod','integers');
xlabel('Error [%]')   
subplot(1,2,2)
h2 = histogram(YTE,'Normalization','pdf','BinMethod','integers');
xlabel('Error [hours]')
[ax2,h2]=suplabel('Frequency','y');
suptitle('Application histograms with a Time error distrubution');

%% save fig
saveFigs('Time_Error_plots');