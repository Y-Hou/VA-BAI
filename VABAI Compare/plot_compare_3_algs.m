%% results of VA-LUCB
load("VALUCB_compete2.mat")
data=table;
averaged_TC=data(:,5);
standard_deviation=data(:,7);
table11=[averaged_TC';standard_deviation'];
%% results of RiskAverse_UCB_BAI
load("RiskAverse2.mat")
data=table;
averaged_TC=data(:,4);
standard_deviation=data(:,6);
table22=[averaged_TC';standard_deviation'];
%% results of VA-Uniform
load("VAUniform_compete2.mat")
data=table;
averaged_TC=data(:,5);
standard_deviation=data(:,7);
table33=[averaged_TC';standard_deviation'];
%%
clear bar;
% test=categorical({'1','2','3','4','5','6','7','8','9','10'});
% test=reordercats(test,{'1','2','3','4','5','6','7','8','9','10'});
tc=[table11(1,:)',table22(1,:)',table33(1,:)'];
f=figure(2);
b= bar(1:10,tc);
hold on;
err=[table11(2,:)',table22(2,:)',table33(2,:)'];
[ngroups,nbars] = size(tc);
% Get the x coordinate of the bars
x = nan(nbars, ngroups);
for i = 1:nbars
    x(i,:) = b(i).XEndPoints;
end
% Plot the errorbars
errorbar(x',tc,err,'k','linestyle','none');
set(gca,'Yscale','log','Fontname', 'Times New Roman','FontSize',20);
% set(gca,'Fontname', 'Times New Roman','FontSize',20);
ylim([10^5,5*10^7]);
xlabel('Instance','Interpreter','latex');
ylabel('Sample complexity', 'Interpreter','latex');
legend('VA-LUCB','RiskAverse-UCB-BAI','VA-Uniform','Interpreter','latex','Location','northwest');
set(gcf,'Position',[0,0, 600, 400])
hold off
str=['Comparison','.eps'];
grid;
exportgraphics(f,str);





