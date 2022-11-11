function [H,epsilon_mu,epsilon_v]=H_UCB(N,expec,variance,bar,delta)
%for RiskAverse_UCB only
%calculate H for a given instance
%r.v. bounded by [0,1] is 1/2-subguassian
sigma=1/2;
arms=(1:N)';
feasible=arms(variance<=bar);       %feasible arms
infeasible=arms(variance>bar);      %infeasible arms 
if isempty(feasible)
    disp('infeasible instance!!!');
    H=0;
    epsilon_mu=0;
    epsilon_v=0;
else
    %find i_star
    [~,temp]=max(expec(feasible));
    i_star=feasible(temp); 
    %compute Delta_i and set epsilon_mu
    Delta=expec(i_star)-expec;
    epsilon_mu=min(Delta(Delta>0));

    if isempty(infeasible)  %if all the arms are feasible, just set epsilon_v=1
        epsilon_v=1;
    else
        %compute the variance gap and set epsilon_v
        Delta_v=abs(variance-bar);
        %find the infeasible arm with the smallest risk gap
        [~,temp]=min(Delta_v(infeasible));
        i_infeasible=infeasible(temp);
        epsilon_v=Delta_v(i_infeasible);
    end
    %compute H
    constant=3*N*((2*sigma^2/epsilon_mu^2)+4/epsilon_v^2);
    H=constant*log(2*N*constant/delta);
end
end

