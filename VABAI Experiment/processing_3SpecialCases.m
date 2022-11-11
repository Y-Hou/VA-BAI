% output the results for the 3 instances where the time complexity should
% remain in each of the instances
load('experiment_results.mat');
data=table;
T1S2=12:22;
T4S1=67:77;
T4S4=100:110;
format short e;
table1=[0:10;data(T1S2,5)';data(T1S2,7)'];
table2=[0:10;data(T4S1,5)';data(T4S1,7)'];
table3=[0:10;data(T4S4,5)';data(T4S4,7)'];
table=[table1;table2;table3];
filename = '3 special cases.xlsx';
writematrix(table,filename,'Sheet',1,'Range','A1');