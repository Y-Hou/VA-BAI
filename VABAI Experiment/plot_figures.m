% plot the figures in the VA-LUCB experiment. There are 3 cases where the
% sample complexities do not change. Thus these 3 figures are replaced by
% tables in the appendix of the paper which is dealt by
% processing_3SpecialCases.m
close all;
load('experiment_results.mat');
data=table;
delta=0.05;
TC=data(:,5);
H=data(:,6);
standard_deviation=data(:,7);
HlnHdelta=H.*log(H./delta);
for i=1:10
    start=11*i-10;
    stop=11*i;
    tc=TC(start:stop);
    comp=HlnHdelta(start:stop);
    error=standard_deviation(start:stop);
    if i==1
        h2 = figure('Position',[0 0 320 260]);
    elseif i==4
        h2 = figure('Position',[0 0 320 250]);
    else
        h2 = figure('Position',[0 0 320 250]);
    end

    errorbar(comp/1e5, tc, error,'o');
    
    p = polyfit(comp/1e5, tc, 1);
    y = polyval(p,comp/1e5);
    x_max=max(comp/1e5);
    x_min=min(comp/1e5);
    x1=0:1e-2:9/8*x_max;
    hold on;
    plot(x1, polyval(p, x1));
    
    grid;
    set(gca,'XMinorGrid','on');
    set(gca,'YMinorGrid','on');
    if i==1
        legend('data','linear fit','Location','northwest','Interpreter','latex');
        ylabel('Sample complexity','Interpreter','latex');
    end
    if i==8
        xlim([1.3, 2.5]);
    elseif i==4
        xlim([1.3, 2.59]);
    else
        xlim([0, max(x_max*9/8)]);
    end   


xlabel('$(H_{\mathrm{VA}}\ln(H_{\mathrm{VA}}/\delta))/10^5$','Interpreter','latex');
set(gca, 'Fontname', 'Times New Roman','FontSize',16);

saveas(gcf,['C',num2str(i)],'epsc')
end