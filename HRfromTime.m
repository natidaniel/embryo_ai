function [HR,p,NA,NB] = HRfromTime(timeA,timeB,x_common)



    [survival_time_y,cen_y,xx,f,flow,fup,time_mat] = time2survival(timeA,x_common);
    
    [survival_time_o,cen_o,xx,f,flow,fup,time_mat] = time2survival(timeB,x_common);
    
    
    type = [zeros(size(survival_time_y)),ones(size(survival_time_o))];
    data_c = [survival_time_y,survival_time_o];
    cen = [cen_y,cen_o];
    [b,logl,H,stats] = coxphfit(type,data_c);
    p = stats.p;
    HR = exp(b);
    NA = length(cen_y);
    NB = length(cen_o);