function s = log_sum(a,b)
m = max(a,b);
s = m + log(exp(a - m) + exp(b - m));
end