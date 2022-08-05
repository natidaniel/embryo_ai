function  [survival_time,cen,xx,f,flow,fup,time_mat] = time2survival(time,x_common)



[emb_num,stages] = size(time);
k = 1;
for i = 1:(emb_num)
    
    if ~isempty(max(find(~isnan(time(i,:)))))
        
        if max(find(~isnan(time(i,:))))<stages
            survival_time(k) = max(find(~isnan(time(i,:))));
            cen(k) = 0;
            
        else
            survival_time(k) = stages;
            cen(k) = 1;
            
%             survival_time(k) = stages+1;
%             cen(k) = 0;
%             
        end
        
        time_mat(k,:) = time(i,:);
        k=k+1;
    end
end
ind = find(survival_time>0);

survival_time = survival_time(ind);
cen = cen(ind);


    [f,x,flow,fup] = ecdf(survival_time,'censoring',cen,...
        'function','survivor','alpha',0.05);
    
    if isempty(f)
        
        xx = x_common;
        f = ones(size(x_common));
        flow = ones(size(x_common));
        fup = ones(size(x_common));
    else
        
        xx = [0  x' x_common(x(end)<x_common)];
        f = [1 f' ones(size(x_common(x(end)<x_common)))*f(end)];
        flow = [1 flow' ones(size(x_common(x(end)<x_common)))*flow(end)];
        fup = [1 fup' ones(size(x_common(x(end)<x_common)))*fup(end)];
        
        flow(isnan(flow))=1;
        fup(isnan(fup))=1;
        
    end

 