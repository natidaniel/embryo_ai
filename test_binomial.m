% test binomial

% 62.0000   62.0000   61.0000   57.0000   46.0000
%  41.0000   41.0000   39.0000   33.0000   27.0000
clear all

p_vec = linspace(0,1,1000)

N1 = 62; x1 = 16;
N2 = 41; x2 = 14;

% N1 = 61; x1 = 4;
% N2 = 39; x2 = 6;



% N1 = 57; x1 = 11;
% N2 = 33; x2 = 6;

for cnt_p1 = 1:length(p_vec)
%     for cnt_p2 = 1:length(p_vec)

    
%     p1(cnt_p1,cnt_p2) = binocdf(x1,N1,p_vec(cnt_p1));
%     p2(cnt_p1,cnt_p2)= 1- binocdf(x2,N2,p_vec(cnt_p2));
    
    P(cnt_p1) =  binocdf(x1,N1,p_vec(cnt_p1))*(1- binocdf(x2,N2,p_vec(cnt_p1)));
%     DP(cnt_p1,cnt_p2) = abs(p_vec(cnt_p1)-p_vec(cnt_p2));
    
%     end
end

figure(1)
plot(p_vec,P);

r_vec = logspace(-2,1.5,100);
p_young = binopdf(x1,N1,p_vec)/trapz(p_vec,binopdf(x1,N1,p_vec));
p_old = binopdf(x2,N2,p_vec)/trapz(p_vec,binopdf(x2,N2,p_vec));

for cnt_r = 1:length(r_vec)
    for cnt_x = 1:length(p_vec)
        
        
        x = p_vec(cnt_x);
        r = r_vec(cnt_r);
        y = x/r;
        
        [val,ind] = min((abs(y-p_vec)));
        
        
        p_r(cnt_r,cnt_x) = p_old(cnt_x)*p_young(ind);
        
        
        
        
    end
    
    P_R(cnt_r) = trapz(p_vec,p_r(cnt_r,:));
    xx = 1:cnt_r;
    yy = P_R(1:cnt_r);
    if cnt_r ==1
        C_R(cnt_r) =0;
        
    else
        
        C_R(cnt_r) = trapz(xx,yy);
    end
end

figure(2)
subplot(2,1,1);
plot(r_vec,P_R)
subplot(2,1,2);
plot(r_vec,C_R/max(C_R))

% PP =  binocdf(x1,N1,x2/N2)*(1- binocdf(x2,N2,x2/N2))
% 
% % surf(p_vec,p_vec,P);
% % figure
% % plot(p_vec,diag(P));
% % figure
% % plot(DP,P);
% % figure
% % ind = P<0.05;
% % plot(DP(ind))
% 
% figure(2)
% plot(p_vec,binocdf(x1,N1,p_vec));hold on
% plot(p_vec,binocdf(x2,N2,p_vec));hold on
% 
[val,ind_up] = min(abs(binocdf(x1,N1,p_vec)-0.05/2))
[val,ind_down] = min(abs(binocdf(x1,N1,p_vec)-(1-0.05/2)))
x1/N1
p_vec(ind_up)
p_vec(ind_down)

[val,ind_up] = min(abs(binocdf(x2,N2,p_vec)-0.05/2))
[val,ind_down] = min(abs(binocdf(x2,N2,p_vec)-(1-0.05/2)))
x2/N2
p_vec(ind_up)
p_vec(ind_down)
% 
% 
% pp1 = diff(1-binocdf(x1,N1,p_vec))./diff(p_vec)
% pp2 = diff(1-binocdf(x2,N2,p_vec))./diff(p_vec)
% 
% trapz(p_vec(2:end),pp1)
% cdf1 = 1-binocdf(x1,N1,p_vec);
% cdf2 = 1-binocdf(x1,N1,p_vec);
% 
% inv_cdf1 = 10
% 
% for cnt_p1 = 1:length(p_vec(2:end))
%     for cnt_p2 = 1:length(p_vec(2:end))
% 
%         p_r(cnt_p1,cnt_p2) = pp1(cnt_p1).*pp2(cnt_p2);
%         cdf_r(cnt_p1,cnt_p2) = cdf1(cnt_p1).*cdf2(cnt_p2);
%         r(cnt_p1,cnt_p2) = log(p_vec(cnt_p1))-log(p_vec(cnt_p2));
%         
%     end
% end
% 
% 
% for cnt_p1 = 1:length(p_vec)
%     for cnt_p2 = 1:length(p_vec)
% 
%  
%         cdf_r(cnt_p1,cnt_p2) = cdf1(cnt_p1).*cdf2(cnt_p2);
%         r(cnt_p1,cnt_p2) = p_vec(cnt_p1)/(p_vec(cnt_p2));
%         
%     end
% end
% 
% 
% figure
% surf(p_vec(2:end),p_vec(2:end),p_r)
% 
% figure
% surf(p_vec,p_vec,cdf_r)
% 
% 
% [val,ind_up] = min(abs(binocdf(x1,N1,p_vec)-sqrt(0.025)))
% [val,ind_down] = min(abs(binocdf(x1,N1,p_vec)-(1-sqrt(0.025))))
% u1 = p_vec(ind_up)
% d1 = p_vec(ind_down)
% 
% [val,ind_up] = min(abs(binocdf(x2,N2,p_vec)-sqrt(0.025)))
% [val,ind_down] = min(abs(binocdf(x2,N2,p_vec)-(1-sqrt(0.025))))
% u2 = p_vec(ind_up)
% d2 = p_vec(ind_down)
% 
% ind = find(cdf_r<0.05);
% r(ind)
% 
% 
% 1.96*sqrt(x1/N1*(1-x1/N1)/N1)
% 1.96*sqrt(x2/N2*(1-x2/N2)/N2)
% 
% plot(p_vec,binopdf(x1,N1,p_vec)/trapz(p_vec,binopdf(x1,N1,p_vec)))
% 
%  1-betainv(0.05/2,N1-x1,x1+1)
%  1-betainv(1-0.05/2,N1-x1+1,x1)
%  
%  1-betainv(0.05/2,N2-x2,x2+1)
%  1-betainv(1-0.05/2,N2-x2+1,x2)
%%
% N1 = 57; x1 = 11;
% N2 = 33; x2 = 6;

N1 = 61; x1 = 4;
N2 = 39; x2 = 6;

type = [zeros(1,N1) ones(1,N2)];

data = [ones(1,N1-x1) ones(1,x1) ones(1,N2-x2) ones(1,x2)];

cen = [ones(1,N1-x1) zeros(1,x1) ones(1,N2-x2) zeros(1,x2)];

    [b,logl,H,stats] = coxphfit(type,data,'Censoring',cen)
