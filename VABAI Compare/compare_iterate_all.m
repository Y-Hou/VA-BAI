%% Compare VA-Uniform algorithm with other algorithms
%Note the reward should be bounded by [0,1]

%used to store the results
collect_all=[];
trials=20;  %run the experiment trials times
%risk parameter
delta=0.05;
%number of arms
N=10;
instance_para=[zeros(1,2),1:N];
for trial=1:trials  %run the whole experiment trials times to get an averaged Time Complexity
    collect_trial=[];   %used to store the results generated in one trial
    for test=1:1    %index of the experiment
        for instance=1:10   %index of the instance in one experiment
            [trial,test,instance]
            tic
            % arm initialization
            [N,para,expec,variance,bar]=initialization_compete(test,instance,trial);  
            %get H_VA of this instance
            [H_VA,epsilon_mu,epsilon_v]=Hindex(N,expec,variance,bar); 
            %store the parameters
            instance_para=[instance_para;[repmat([test,instance],2,1),[expec';variance']]];
            % implement VA-LUCB
            [i_out,flag,TC] = VA_Uniform(N,para,bar); 
            % save the time complexity and test index
            collect_trial=vertcat(collect_trial,[test,instance,flag,i_out,TC,H_VA]); 
            toc
        end
    end
    %collect all the data from each trial
    collect_all(:,:,trial)=collect_trial;
end
% %%
%compute average time complexity
averaged_TC=mean(collect_all(:,5,:),3);
%compute standard deviation of time complexity
standard_deviation=std(collect_all(:,5,:),0,3);
%output the result
table=collect_trial;
table(:,5)=averaged_TC;
table=[table,standard_deviation];
filename = 'VAUniform_compete2.xlsx';
save('VAUniform_compete2');
writematrix(table,filename,'Sheet',1,'Range','A1');
writematrix(instance_para,filename,'Sheet',2,'Range','A1');
%%
%% LUCB1 algorithm in variance constrained scenario
%Note it's only for feasible instance and reward should be bounded by [0,1]
%%
%rng(5); %for reproduction
collect_all=[];
% trials=20;  %run the experiment 20 times
trials=20;  %run the experiment 5 times
delta=0.05;
N=10;
instance_para=[zeros(1,2),1:N];
for trial=1:trials  %run the whole experiment trials times to get an averaged Time Complexity
    collect_trial=[];
    for test=1:1
        for instance=1:10
            % arm initialization
            [trial,test,instance]
            tic
            [N,para,expec,variance,bar]=initialization_compete(test,instance,trial);  %N,test,subtest,instance,trial
            %[para,expec,variance,bar]=initialization(N,test,instance,trial);  %N,test,subtest,instance,trial
            [H,epsilon_mu,epsilon_v]=H_UCB(N,expec,variance,bar,delta); %get H of this instance
            if H>0
                instance_para=[instance_para;[repmat([test,instance],2,1),[expec';variance']]];
                % implement VA-LUCB
                [i_out,TC] = RiskAverse_UCB_BAI(N,para,bar,epsilon_mu,epsilon_v,H); 
                % save the time complexity and test index
                collect_trial=vertcat(collect_trial,[test,instance,i_out,TC,H]);
            end
            toc
        end
    end
    collect_all(:,:,trial)=collect_trial;
end
%%
averaged_TC=mean(collect_all(:,4,:),3);
standard_deviation=std(collect_all(:,4,:),0,3);
table=collect_trial;
table(:,4)=averaged_TC;
table=[table,standard_deviation];
filename = 'RiskAverse2.xlsx';
save('RiskAverse2');
writematrix(table,filename,'Sheet',1,'Range','A1');
writematrix(instance_para,filename,'Sheet',2,'Range','A1');
%%
%% Compare VA-LUCB algorithm with other algorithms
%Note the reward should be bounded by [0,1]

%used to store the results
collect_all=[];
trials=20;  %run the experiment trials times
%risk parameter
delta=0.05;
%number of arms
N=10;
instance_para=[zeros(1,2),1:N];
for trial=1:trials  %run the whole experiment trials times to get an averaged Time Complexity
    collect_trial=[];   %used to store the results generated in one trial
    for test=1:1      %index of the experiment
        for instance=1:10  %index of the instance in one experiment
            [trial,test,instance]
            tic
            % arm initialization
            [N,para,expec,variance,bar]=initialization_compete(test,instance,trial);  
            %get H_VA of this instance
            [H_VA,epsilon_mu,epsilon_v]=Hindex(N,expec,variance,bar); 
            %store the parameters
            instance_para=[instance_para;[repmat([test,instance],2,1),[expec';variance']]];
            % implement VA-LUCB
            [i_out,flag,TC] = VA_LUCB(N,para,bar); 
            % save the time complexity and test index
            collect_trial=vertcat(collect_trial,[test,instance,flag,i_out,TC,H_VA]); 
            toc
        end
    end
    %collect all the data from each trial
    collect_all(:,:,trial)=collect_trial;
end
%%
%compute average time complexity
averaged_TC=mean(collect_all(:,5,:),3);
%compute standard deviation of time complexity
standard_deviation=std(collect_all(:,5,:),0,3);
%output the result
table=collect_trial;
table(:,5)=averaged_TC;
table=[table,standard_deviation];
filename = 'VALUCB_compete2.xlsx';
save('VALUCB_compete2');
writematrix(table,filename,'Sheet',1,'Range','A1');
writematrix(instance_para,filename,'Sheet',2,'Range','A1');
