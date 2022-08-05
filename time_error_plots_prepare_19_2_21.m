%% Young and Old Time error
close all;clear;clc
%% Import data from spreadsheet (embryo Time data)
UseOld = 'TRUE';
UseYoung = 'FALSE';
data_path = 'C:\Nati\Embryos\4Yoni\paper related\Embryos automated system validation time_reduced_19_2_21.xlsx';
if strcmp(UseOld,'TRUE')
    % application data
    [~, ~, raw] = xlsread(data_path,'AM TIME total Old','B2:B42');
    A1cell = reshape([raw{:}],size(raw));
    clearvars raw;
    [~, ~, raw] = xlsread(data_path,'AM TIME total Old','C2:C42');
    A2cell = reshape([raw{:}],size(raw));
    clearvars raw;
    [~, ~, raw] = xlsread(data_path,'AM TIME total Old','D2:D41');
    A4cell = reshape([raw{:}],size(raw));
    clearvars raw;
    [~, ~, raw] = xlsread(data_path,'AM TIME total Old','E2:E40');
    A8cell = reshape([raw{:}],size(raw));
    clearvars raw;
    [~, ~, raw] = xlsread(data_path,'AM TIME total Old','F2:F40');
    AMorula = reshape([raw{:}],size(raw));
    clearvars raw;
    [~, ~, raw] = xlsread(data_path,'AM TIME total Old','G2:G34');
    AEB = reshape([raw{:}],size(raw));
    clearvars raw;
    [~, ~, raw] = xlsread(data_path,'AM TIME total Old','H2:H27');
    AFB = reshape([raw{:}],size(raw));
    clearvars raw;
    
    % manual data
    [~, ~, raw] = xlsread(data_path,'AM TIME total Old','I2:I42');
    M1cell = reshape([raw{:}],size(raw));
    clearvars raw;
    [~, ~, raw] = xlsread(data_path,'AM TIME total Old','J2:J42');
    M2cell = reshape([raw{:}],size(raw));
    clearvars raw;
    [~, ~, raw] = xlsread(data_path,'AM TIME total Old','K2:K41');
    M4cell = reshape([raw{:}],size(raw));
    clearvars raw;
    [~, ~, raw] = xlsread(data_path,'AM TIME total Old','L2:L40');
    M8cell = reshape([raw{:}],size(raw));
    clearvars raw;
    [~, ~, raw] = xlsread(data_path,'AM TIME total Old','M2:M40');
    MMorula = reshape([raw{:}],size(raw));
    clearvars raw;
    [~, ~, raw] = xlsread(data_path,'AM TIME total Old','N2:N34');
    MEB = reshape([raw{:}],size(raw));
    clearvars raw;
    [~, ~, raw] = xlsread(data_path,'AM TIME total Old','O2:O27');
    MFB = reshape([raw{:}],size(raw));
    clearvars raw;
    
    % create cell matrix
    t_a_o{1,1} = A1cell;t_a_o{1,2} = A2cell;t_a_o{1,3} = A4cell;t_a_o{1,4} = A8cell;t_a_o{1,5} = AMorula;t_a_o{1,6} = AEB;t_a_o{1,7} = AFB;
    t_m_o{1,1} = M1cell;t_m_o{1,2} = M2cell;t_m_o{1,3} = M4cell;t_m_o{1,4} = M8cell;t_m_o{1,5} = MMorula;t_m_o{1,6} = MEB;t_m_o{1,7} = MFB;
end

if strcmp(UseYoung,'TRUE')
    % application data
    [~, ~, raw] = xlsread(data_path,'AM TIME total Young','B2:B63');
    A1cell = reshape([raw{:}],size(raw));
    clearvars raw;
    [~, ~, raw] = xlsread(data_path,'AM TIME total Young','C2:C63');
    A2cell = reshape([raw{:}],size(raw));
    clearvars raw;
    [~, ~, raw] = xlsread(data_path,'AM TIME total Young','D2:D63');
    A4cell = reshape([raw{:}],size(raw));
    clearvars raw;
    [~, ~, raw] = xlsread(data_path,'AM TIME total Young','E2:E63');
    A8cell = reshape([raw{:}],size(raw));
    clearvars raw;
    [~, ~, raw] = xlsread(data_path,'AM TIME total Young','F2:F62');
    AMorula = reshape([raw{:}],size(raw));
    clearvars raw;
    [~, ~, raw] = xlsread(data_path,'AM TIME total Young','G2:G58');
    AEB = reshape([raw{:}],size(raw));
    clearvars raw;
    [~, ~, raw] = xlsread(data_path,'AM TIME total Young','H2:H47');
    AFB = reshape([raw{:}],size(raw));
    clearvars raw;
    
    % manual data
    [~, ~, raw] = xlsread(data_path,'AM TIME total Young','I2:I63');
    M1cell = reshape([raw{:}],size(raw));
    clearvars raw;
    [~, ~, raw] = xlsread(data_path,'AM TIME total Young','J2:J63');
    M2cell = reshape([raw{:}],size(raw));
    clearvars raw;
    [~, ~, raw] = xlsread(data_path,'AM TIME total Young','K2:K63');
    M4cell = reshape([raw{:}],size(raw));
    clearvars raw;
    [~, ~, raw] = xlsread(data_path,'AM TIME total Young','L2:L63');
    M8cell = reshape([raw{:}],size(raw));
    clearvars raw;
    [~, ~, raw] = xlsread(data_path,'AM TIME total Young','M2:M62');
    MMorula = reshape([raw{:}],size(raw));
    clearvars raw;
    [~, ~, raw] = xlsread(data_path,'AM TIME total Young','N2:N58');
    MEB = reshape([raw{:}],size(raw));
    clearvars raw;
    [~, ~, raw] = xlsread(data_path,'AM TIME total Young','O2:O47');
    MFB = reshape([raw{:}],size(raw));
    clearvars raw;
    
    % create cell matrix
    t_a_y{1,1} = A1cell;t_a_y{1,2} = A2cell;t_a_y{1,3} = A4cell;t_a_y{1,4} = A8cell;t_a_y{1,5} = AMorula;t_a_y{1,6} = AEB;t_a_y{1,7} = AFB;
    t_m_y{1,1} = M1cell;t_m_y{1,2} = M2cell;t_m_y{1,3} = M4cell;t_m_y{1,4} = M8cell;t_m_y{1,5} = MMorula;t_m_y{1,6} = MEB;t_m_y{1,7} = MFB;
end
%% prepare time stats
if strcmp(UseOld,'TRUE')
    % time
    YTE1 = t_m_o{1,1}-t_a_o{1,1};
    YTE2 = t_m_o{1,2}-t_a_o{1,2};
    YTE4 = t_m_o{1,3}-t_a_o{1,3};
    YTE8 = t_m_o{1,4}-t_a_o{1,4};
    YTEm = t_m_o{1,5}-t_a_o{1,5};
    YTEeb = t_m_o{1,6}-t_a_o{1,6};
    YTEfb = t_m_o{1,7}- t_a_o{1,7};
    YTE = [YTE1(:); YTE2(:); YTE4(:); YTE8(:); YTEm(:); YTEeb(:); YTEfb(:)];
    YTE_mean_abs_per_state = [mean(abs(YTE1)),mean(abs(YTE2)),mean(abs(YTE4)),mean(abs(YTE8)),mean(abs(YTEm)),mean(abs(YTEeb)),mean(abs(YTEfb))];
    YTE_mean_abs_per_state_wo_zero = [mean(abs(YTE1(find(YTE1~=-0)))),mean(abs(YTE2(find(YTE2~=-0)))),mean(abs(YTE4(find(YTE4~=-0)))),mean(abs(YTE8(find(YTE8~=-0)))),mean(abs(YTEm(find(YTEm~=-0)))),mean(abs(YTEeb(find(YTEeb~=-0)))),mean(abs(YTEfb(find(YTEfb~=-0))))];
    % freq
    YET1c = (YTE1 ./ M1cell)*100;
    YET2c = (YTE2 ./ M2cell)*100;
    YET4c = (YTE4 ./ M4cell)*100;
    YET8c = (YTE8 ./ M8cell)*100;
    YETm = (YTEm ./ MMorula)*100;
    YETeb = (YTEeb ./ MEB)*100;
    YETfb = (YTEfb ./ MFB)*100;
    YET_mean_abs_per_state = [mean(abs(YET1c)),mean(abs(YET2c)),mean(abs(YET4c)),mean(abs(YET8c)),mean(abs(YETm)),mean(abs(YETeb)),mean(abs(YETfb))];
    YET_mean_abs_per_state_wo_zero = [mean(abs(YET1c(find(YET1c~=-0)))),mean(abs(YET2c(find(YET2c~=-0)))),mean(abs(YET4c(find(YET4c~=-0)))),mean(abs(YET8c(find(YET8c~=-0)))),mean(abs(YETm(find(YETm~=-0)))),mean(abs(YETeb(find(YETeb~=-0)))),mean(abs(YETfb(find(YETfb~=-0))))];
    YET = [YET1c(:); YET2c(:); YET4c(:); YET8c(:); YETm(:); YETeb(:); YETfb(:)];
    YETABS = abs(YET);
end    

if strcmp(UseYoung,'TRUE')
    % time
    YTE1 = t_m_y{1,1}-t_a_y{1,1};
    YTE2 = t_m_y{1,2}-t_a_y{1,2};
    YTE4 = t_m_y{1,3}-t_a_y{1,3};
    YTE8 = t_m_y{1,4}-t_a_y{1,4};
    YTEm = t_m_y{1,5}-t_a_y{1,5};
    YTEeb = t_m_y{1,6}-t_a_y{1,6};
    YTEfb = t_m_y{1,7}- t_a_y{1,7};
    YTE = [YTE1(:); YTE2(:); YTE4(:); YTE8(:); YTEm(:); YTEeb(:); YTEfb(:)];
    YTE_mean_abs_per_state = [mean(abs(YTE1)),mean(abs(YTE2)),mean(abs(YTE4)),mean(abs(YTE8)),mean(abs(YTEm)),mean(abs(YTEeb)),mean(abs(YTEfb))];
    YTE_mean_abs_per_state_wo_zero = [mean(abs(YTE1(find(YTE1~=-0)))),mean(abs(YTE2(find(YTE2~=-0)))),mean(abs(YTE4(find(YTE4~=-0)))),mean(abs(YTE8(find(YTE8~=-0)))),mean(abs(YTEm(find(YTEm~=-0)))),mean(abs(YTEeb(find(YTEeb~=-0)))),mean(abs(YTEfb(find(YTEfb~=-0))))];
    % freq
    YET1c = (YTE1 ./ M1cell)*100;
    YET2c = (YTE2 ./ M2cell)*100;
    YET4c = (YTE4 ./ M4cell)*100;
    YET8c = (YTE8 ./ M8cell)*100;
    YETm = (YTEm ./ MMorula)*100;
    YETeb = (YTEeb ./ MEB)*100;
    YETfb = (YTEfb ./ MFB)*100;
    YET_mean_abs_per_state = [mean(abs(YET1c)),mean(abs(YET2c)),mean(abs(YET4c)),mean(abs(YET8c)),mean(abs(YETm)),mean(abs(YETeb)),mean(abs(YETfb))];
    YET_mean_abs_per_state_wo_zero = [mean(abs(YET1c(find(YET1c~=-0)))),mean(abs(YET2c(find(YET2c~=-0)))),mean(abs(YET4c(find(YET4c~=-0)))),mean(abs(YET8c(find(YET8c~=-0)))),mean(abs(YETm(find(YETm~=-0)))),mean(abs(YETeb(find(YETeb~=-0)))),mean(abs(YETfb(find(YETfb~=-0))))];
    YET = [YET1c(:); YET2c(:); YET4c(:); YET8c(:); YETm(:); YETeb(:); YETfb(:)];
    YETABS = abs(YET);
end
