function [i_t,flag,TC] = VA_Uniform(N,para,bar)
%LUCB for the variance constrained case
%% parameters for the algorithm
%confidence level 
delta=0.05;
%arms
arms=(1:N)';

%% algorithm warm up
%pull each of the arms 1 time
warm_up=pull(arms,para);
%count the sampling times
T=N;
count=ones(N,1);

%empirical mean set up
empirical_mean=warm_up;
%compute the confidence radius
cr=theta(count,T,N,delta);
%upper bound for empirical mean
ucb=empirical_mean+cr;
%lower bound for empirical mean
lcb=empirical_mean-cr;

%second moment
sec=warm_up.^2;
%empirical variance
evar=zeros(N,1);
%confidence bound for variance
cbv=cr;
%upper bound for variance
ucbv=evar+cbv;
%lower bound for variance
lcbv=evar-cbv;
%track the samplings
% history=zeros(15,2);

%%
while 1
    %find feasible/almost feasible/infeasible arms
    feasible=arms(ucbv<=bar); %feasible arms at time t
    not_infeasible=arms(lcbv<=bar);   %not infeasible arms at time t
    %infeasible=arms(lcbv>bar);    %infeasible arms at time t
    if isempty(feasible)
        potential=1:N;
        flag=0;
    else
        %get i_t^\star
        [~,temp]=max(empirical_mean(feasible));
        i_tstar=feasible(temp); 
        % get the potential arms at time t
        potential=arms(ucb>lcb(i_tstar)); 
        potential=setdiff(potential,i_tstar);
        flag=1;
    end
    if isempty(intersect(not_infeasible,potential))    %no not feasible arms at time t
        if flag==0
            i_t=0;
        else
            i_t=i_tstar;
        end
        break;
    end
    
    pair=randi(N,2,1);
    while pair(1)==pair(2)
        pair=randi(N,2,1);
    end
    %pull the arms
    x=pull(pair,para);
    
    %% 
    %update
    %update the empirical mean
    empirical_mean(pair)=(empirical_mean(pair).*count(pair)+x)./(count(pair)+1);   
    %update the confidence bound
    cr=theta(count,T,N,delta);
    %upper bound
    ucb=empirical_mean+cr;
    %lower bound
    lcb=empirical_mean-cr;
    %second momentum
    sec(pair)=sec(pair)+x.^2;
    %empirical variance
    evar(pair)=(sec(pair)-(count(pair)+1).*empirical_mean(pair).^2)./count(pair);
    %confidence bound for variance
    cbv=cr;
    %upper bound for variance
    ucbv=evar+cbv;
    %lower bound for variance
    lcbv=evar-cbv;
    
    count(pair)=count(pair)+1;
    T=T+1;

end
TC=sum(count);
%save(index);

function [y]=theta(u,t,n,delta)
%compute the confidence bound
k=5/2;  %k=5/2 is enough if only considering the confidence bound for uniform sampling
z=0.5./u*log(k*n*t^4/delta);
y=sqrt(z);
end
end

