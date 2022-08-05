function [mean_acc,std_acc, se_acc, acc] = bootstrap_nd(N_round,N_smaple,GT,P)


for cnt_round = 1:N_round

    ind = randperm(length(GT));
    ind = ind(1:N_smaple);

    gt_sample = GT(ind);
    p_sample = P(ind);
    
    tpr = sum(p_sample.*gt_sample)/sum(gt_sample);
    tnr = sum((~p_sample).*(~gt_sample))/sum(~gt_sample);
    acc(cnt_round) = (sum(p_sample.*gt_sample) + sum((~p_sample).*(~gt_sample))) / (sum(gt_sample) + sum(~gt_sample));
    
end

%hist(acc);
mean_acc = mean(acc);
std_acc = std(acc);
se_acc =  std(acc)/sqrt(length(acc));
end
