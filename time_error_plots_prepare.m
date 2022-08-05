%% Young and Old Time error
close all;clear;clc
%% Import data from spreadsheet (embryo Time data)
UseOld = 'TRUE';
UseYoung = 'FALSE';
data_path = 'C:\Nati\Embryos\4Yoni\paper related\Embryos automated system validation time.xlsx';
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
    % freq
    YET1c = (YTE1 ./ M1cell)*100;
    YET2c = (YTE2 ./ M2cell)*100;
    YET4c = (YTE4 ./ M4cell)*100;
    YET8c = (YTE8 ./ M8cell)*100;
    YETm = (YTEm ./ MMorula)*100;
    YETeb = (YTEeb ./ MEB)*100;
    YETfb = (YTEfb ./ MFB)*100;
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
    % freq
    YET1c = (YTE1 ./ M1cell)*100;
    YET2c = (YTE2 ./ M2cell)*100;
    YET4c = (YTE4 ./ M4cell)*100;
    YET8c = (YTE8 ./ M8cell)*100;
    YETm = (YTEm ./ MMorula)*100;
    YETeb = (YTEeb ./ MEB)*100;
    YETfb = (YTEfb ./ MFB)*100;
    YET = [YET1c(:); YET2c(:); YET4c(:); YET8c(:); YETm(:); YETeb(:); YETfb(:)];
    YETABS = abs(YET);
end
