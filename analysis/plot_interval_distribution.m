function [a, b] = plot_interval_distribution(t)
%plotIntervalDistribution Plot the distribution of input vector t over set
%intervals
t_i = diff(t);
[a,b] = hist(round(t_i, 3), unique(round(t_i, 3)));
bar(b*1000, a/numel(t)*100);
ytickformat('%g%%')
xlabel('Sample interval (milliseconds)')
ylabel(['Percent occurance out of ' num2str(numel(t)) ' samples'])
end