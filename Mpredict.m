function acc = Mpredict(Trainer, data) 
yfit = Trainer.predictFcn(data(:,1:(end-1)));
ygt = data(:,end);
acc = 100 - sum(abs(yfit-ygt))/length(ygt)*100;