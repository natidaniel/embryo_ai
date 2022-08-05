function yout = nantozero(yin)
l=length(yin);
for i=1:l
    if isnan(yin(1,l))
        yout(1,l)=0;
    else
        yout(1,l)=yin(1,l);
    end
end
end