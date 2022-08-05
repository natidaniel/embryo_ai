function ad = ADC(YET_ps)
ad = sum(abs(YET_ps-mean(YET_ps)))/length(YET_ps);
