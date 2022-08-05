close all;clear;clc
UseOld = 'TRUE';
UseSurvived = 'TRUE';
UseNotSurvived = 'FALSE';
UseYoung = 'FALSE';
ind_stage = 6; histfig = 1;
load('time_compare.mat')
%% remove NaN values from data for non-survived embryos
if strcmp(UseOld,'TRUE')
    % not-survived
    x_o_ns_a = time_mat_machine_O(ind_not_survived_machine_O,:);
    [M,N] = size(x_o_ns_a);
    x_o_ns_a_wn = {};
    for j=1:(N-1)
        x_o_ns_a_wn{1,j} = x_o_ns_a(~isnan(x_o_ns_a(:,j)),j);
    end
    x_o_ns_m = time_mat_manual_O(ind_not_survived_manual_O,[1:3 5:7]);
    [M,N] = size(x_o_ns_m);
    x_o_ns_m_wn = {};
    for j=1:(N-1)
        x_o_ns_m_wn{1,j} = x_o_ns_m(~isnan(x_o_ns_m(:,j)),j);
    end
end
if strcmp(UseYoung,'TRUE')
    % not-survived
    x_y_ns_a = time_mat_machine_Y(ind_not_survived_machine_Y,:);
    [M,N] = size(x_y_ns_a);
    x_y_ns_a_wn = {};
    for j=1:(N-1)
        x_y_ns_a_wn{1,j} = x_y_ns_a(~isnan(x_y_ns_a(:,j)),j);
    end
    x_y_ns_m = time_mat_manual_Y(ind_not_survived_manual_Y,[1:3 5:7]);
    [M,N] = size(x_y_ns_m);
    x_y_ns_m_wn = {};
    for j=1:(N-1)
        x_y_ns_m_wn{1,j} = x_y_ns_m(~isnan(x_y_ns_m(:,j)),j);
    end
end
%% dist of timing + overlapping measure
% Mann-Whitney U-test checked ("mw_p").
% Kolmogorov-Smirnov 2-test checked ("ks_p").
% Kullback-Leibler Divergence is not suitable for our data-type.
if strcmp(UseOld,'TRUE')
    if strcmp(UseNotSurvived,'TRUE')
        mw_p_o_ns = [];
        for i=1:(ind_stage-1)
            [p,h,stats] = ranksum(x_o_ns_a_wn{1,i},x_o_ns_m_wn{1,i});
            mw_p_o_ns = [mw_p_o_ns, p]; 
            switch i
                case 1
                    s_stage = '2cell';
                case 2
                    s_stage = '4cell';
                case 3
                    s_stage = '8cell';
                case 4
                    s_stage = 'Morual';
                case 5
                    s_stage = 'Early Blastocyst';
                case 6
                    s_stage = 'Full Blastocyst';
            end
            [f_a,xi_a] = ksdensity(x_o_ns_a_wn{1,i},'Function','pdf');
            [f_m,xi_m] = ksdensity(x_o_ns_m_wn{1,i},'Function','pdf');
            [mu1,s1,muci1,sci1] = normfit(x_o_ns_a_wn{1,i});
            [mu2,s2,muci2,sci2] = normfit(x_o_ns_m_wn{1,i});
            if (s1 == 0)
                s1 = s1 + .1;
            end
            if (s2 == 0)
                s2 = s2 + .1;
            end
            xstart = min(min(x_o_ns_a_wn{1,i}),min(x_o_ns_m_wn{1,i}));
            xstart = xstart - 10;
            xend = max(max(x_o_ns_a_wn{1,i}),max(x_o_ns_m_wn{1,i}));
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
            legend_a = sprintf('machine mu = %d', round(mean(x_o_ns_a_wn{1,i})));
            legend_m = sprintf('manual mu = %d', round(mean(x_o_ns_m_wn{1,i})));
            legend({legend_a, legend_m});
            title({'The probability density of developmental time of not-survived embryos', sprintf('at %s stage', s_stage)},'FontSize',10);
            hold off;
            histfig = histfig + 1;
            figure(histfig);
            plot(xi_a, f_a, 'r-');
            hold on;
            plot(xi_m, f_m, 'g-');
            legend_a = sprintf('machine mu = %d', round(mean(x_o_ns_a_wn{1,i})));
            legend_m = sprintf('manual mu = %d', round(mean(x_o_ns_m_wn{1,i})));
            legend({legend_a, legend_m});
            title({'The probability density of developmental time of not-survived embryos', sprintf('at %s stage', s_stage)},'FontSize',10);
            hold off;
            histfig = histfig + 1;
        end
    end
    if strcmp(UseSurvived,'TRUE')
        x_o_s_a = time_mat_machine_O(ind_survived_machine_O,:);
        x_o_s_m = time_mat_manual_O(ind_survived_manual_O,[1:3 5:7]);
        mw_p_o_s = []; 
        for i=1:ind_stage
            [p,h,stats] = ranksum(x_o_s_a(:,i),x_o_s_m(:,i));
            mw_p_o_s = [mw_p_o_s,p];
            switch i
                case 1
                    s_stage = '2cell';
                case 2
                    s_stage = '4cell';
                case 3
                    s_stage = '8cell';
                case 4
                    s_stage = 'Morual';
                case 5
                    s_stage = 'Early Blastocyst';
                case 6
                    s_stage = 'Full Blastocyst';
            end
            [f_a,xi_a] = ksdensity(x_o_s_a(:,i),'Function','pdf');
            [f_m,xi_m] = ksdensity(x_o_s_m(:,i),'Function','pdf');
            [mu1,s1,muci1,sci1] = normfit(x_o_s_a(:,i));
            [mu2,s2,muci2,sci2] = normfit(x_o_s_m(:,i));
            if (s1 == 0)
                s1 = s1 + .1;
            end
            if (s2 == 0)
                s2 = s2 + .1;
            end
            xstart = min(min(x_o_s_a(:,i)),min(x_o_s_m(:,i)));
            xstart = xstart - 10;
            xend = max(max(x_o_s_a(:,i)),max(x_o_s_m(:,i)));
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
            legend_a = sprintf('machine mu = %d', round(mean(x_o_s_a(:,i))));
            legend_m = sprintf('manual mu = %d', round(mean(x_o_s_m(:,i))));
            legend({legend_a, legend_m});
            title({'The probability density of developmental time of survived embryos', sprintf('at %s stage', s_stage)},'FontSize',10);
            hold off;
            histfig = histfig + 1;
            figure(histfig);
            plot(xi_a, f_a, 'r-');
            hold on;
            plot(xi_m, f_m, 'g-');
            legend_a = sprintf('machine mu = %d', round(mean(x_o_s_a(:,i))));
            legend_m = sprintf('manual mu = %d', round(mean(x_o_s_m(:,i))));
            legend({legend_a, legend_m});
            title({'The probability density of developmental time of survived embryos', sprintf('at %s stage', s_stage)},'FontSize',10);
            histfig = histfig + 1;
        end
    end
end
if strcmp(UseYoung,'TRUE')
    if strcmp(UseNotSurvived,'TRUE')
        mw_p_y_ns = []; 
        for i=1:(ind_stage-1)
            [p,h,stats] = ranksum(x_y_ns_a_wn{1,i},x_y_ns_m_wn{1,i});
            mw_p_y_ns = [mw_p_y_ns,p]; 
            switch i
                case 1
                    s_stage = '2cell';
                case 2
                    s_stage = '4cell';
                case 3
                    s_stage = '8cell';
                case 4
                    s_stage = 'Morual';
                case 5
                    s_stage = 'Early Blastocyst';
                case 6
                    s_stage = 'Full Blastocyst';
            end
            [f_a,xi_a] = ksdensity(x_y_ns_a_wn{1,i},'Function','pdf');
            [f_m,xi_m] = ksdensity(x_y_ns_m_wn{1,i},'Function','pdf');
            [mu1,s1,muci1,sci1] = normfit(x_y_ns_a_wn{1,i});
            [mu2,s2,muci2,sci2] = normfit(x_y_ns_m_wn{1,i});
            if (s1 == 0)
                s1 = s1 + .1;
            end
            if (s2 == 0)
                s2 = s2 + .1;
            end
            xstart = min(min(x_y_ns_a_wn{1,i}),min(x_y_ns_m_wn{1,i}));
            xstart = xstart - 10;
            xend = max(max(x_y_ns_a_wn{1,i}),max(x_y_ns_m_wn{1,i}));
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
            legend_a = sprintf('machine mu = %d', round(mean(x_y_ns_a_wn{1,i})));
            legend_m = sprintf('manual mu = %d', round(mean(x_y_ns_m_wn{1,i})));
            legend({legend_a, legend_m});
            title({'The probability density of developmental time of not-survived embryos', sprintf('at %s stage', s_stage)},'FontSize',10);
            hold off;
            histfig = histfig + 1;
            figure(histfig);
            plot(xi_a, f_a, 'r-');
            hold on;
            plot(xi_m, f_m, 'g-');
            legend_a = sprintf('machine mu = %d', round(mean(x_y_ns_a_wn{1,i})));
            legend_m = sprintf('manual mu = %d', round(mean(x_y_ns_m_wn{1,i})));
            legend({legend_a, legend_m});
            title({'The probability density of developmental time of not-survived embryos', sprintf('at %s stage', s_stage)},'FontSize',10);
            histfig = histfig + 1;
        end
    end
    if strcmp(UseSurvived,'TRUE')
        x_y_s_a = time_mat_machine_Y(ind_survived_machine_Y,:);
        x_y_s_m = time_mat_manual_Y(ind_survived_manual_Y,[1:3 5:7]);
        mw_p_y_s = []; 
        for i=1:ind_stage
            [p,h,stats] = ranksum(x_y_s_a(:,i),x_y_s_m(:,i));
            mw_p_y_s = [mw_p_y_s,p]; 
            switch i
                case 1
                    s_stage = '2cell';
                case 2
                    s_stage = '4cell';
                case 3
                    s_stage = '8cell';
                case 4
                    s_stage = 'Morual';
                case 5
                    s_stage = 'Early Blastocyst';
                case 6
                    s_stage = 'Full Blastocyst';
            end
            [f_a,xi_a] = ksdensity(x_y_s_a(:,i),'Function','pdf');
            [f_m,xi_m] = ksdensity(x_y_s_m(:,i),'Function','pdf');
            [mu1,s1,muci1,sci1] = normfit(x_y_s_a(:,i));
            [mu2,s2,muci2,sci2] = normfit(x_y_s_m(:,i));
            if (s1 == 0)
                s1 = s1 + .1;
            end
            if (s2 == 0)
                s2 = s2 + .1;
            end
            xstart = min(min(x_y_s_a(:,i)),min(x_y_s_m(:,i)));
            xstart = xstart - 10;
            xend = max(max(x_y_s_a(:,i)),max(x_y_s_m(:,i)));
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
            legend_a = sprintf('machine mu = %d', round(mean(x_y_s_a(:,i))));
            legend_m = sprintf('manual mu = %d', round(mean(x_y_s_m(:,i))));
            legend({legend_a, legend_m});
            title({'The probability density of developmental time of survived embryos', sprintf('at %s stage', s_stage)},'FontSize',10);
            hold off;
            histfig = histfig + 1;
            figure(histfig);
            plot(xi_a, f_a, 'r-');
            hold on;
            plot(xi_m, f_m, 'g-');
            legend_a = sprintf('machine mu = %d', round(mean(x_y_s_a(:,i))));
            legend_m = sprintf('manual mu = %d', round(mean(x_y_s_m(:,i))));
            legend({legend_a, legend_m});
            title({'The probability density of developmental time of survived embryos', sprintf('at %s stage', s_stage)},'FontSize',10);
            histfig = histfig + 1;
        end
    end
end
%% save fig
saveFigs('Time_Dist');