%% Adopt VA-LUCB algorithm to deal with the instances
%Note the reward should be bounded by [0,1]

collect_all=[]; %used to collect all the results
trials=20;  %run the experiment 20 times
N=20;       %number of arms
instance_para=[zeros(1,2),1:N]; %used to store the parameters for the instance
for trial=1:trials  %run the whole experiment trials times to get an averaged Time Complexity
    collect_trial=[];   %used to collect data generated in one trial
    for test=1:10   %test is the index for the experiment: 1-4:Case1(a)-1(d);5:Case2;6:Case3;7-10:Case4(a)-4(d)
        for instance=0:10               %under each test, run each instance
            % arm initialization
            [trial,test,instance]
            tic
            %initialize the parameters for the instance
            [para,expec,variance,bar]=initialization(N,test,instance,trial);  
            %get H_VA of this instance
            [H_VA,delta,delta_v]=Hindex(N,expec,variance,bar); 
            %store the parameters
            instance_para=[instance_para;[repmat([test,instance],4,1),[expec';delta';variance';delta_v']]];
            %implement VA-LUCB
            [i_t,flag,TC] = VA_LUCB(N,para,bar); 
            % save the time complexity and test index
            collect_trial=vertcat(collect_trial,[test,instance,i_t,flag,TC,H_VA]);
            toc
        end
    end
    %collect the data for one trial
    collect_all(:,:,trial)=collect_trial;
end
%%
%Compute the average time complexity
averaged_TC=mean(collect_all(:,5,:),3);
%Compute the standard deviation of time complexity
standard_deviation=std(collect_all(:,5,:),0,3);
%output the result
table=collect_trial;
table(:,5)=averaged_TC;
table=[table,standard_deviation];
filename = 'experiment.xlsx';
save('experiment_results');
writematrix(table,filename,'Sheet',1,'Range','A1');
writematrix(instance_para,filename,'Sheet',2,'Range','A1');
