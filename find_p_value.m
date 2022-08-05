function [p_value] = find_p_value(DCNN_accuracy_value, acc)
xx = linspace(0,1,10000);
[f,x] = ecdf(acc);
[val,ind] = min(abs(DCNN_accuracy_value-x));
%hold on
%plot(x,f,'-o');plot([c c],[0,1]);
% max(f(x<=DCNN_accuracy_value))
%p_value = 1-f(length(f)-ind);
p_value = f(ind);
end