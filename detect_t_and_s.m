clear t
clear s
t = []
s = []
for i=2:(length(Embryosstats)-1)
    if Embryosstats(46,i)~=Embryosstats(46,i-1)
        t = [t,i];
        s = [s,Embryosstats(46,i)];
    end
end
s
t