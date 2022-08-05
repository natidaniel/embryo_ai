function F = isDie(stat1)
statq_d = [0 3 4 12];
d = diff(stat1);
s = sign(d);
c = conv2(s, [1 1 1], 'valid');
p = find(c == -3);
Lia = ismember(statq_d,d);
if ~isempty(p) || sum(Lia) ~=4 
    F = 'TRUE';
else
    F = 'FALSE';
end
end

