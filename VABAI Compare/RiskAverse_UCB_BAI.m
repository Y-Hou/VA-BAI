function [i_out,TC] = RiskAverse_UCB_BAI(N,para,bar,epsilon_mu,epsilon_v,H)
%A variance version of RiskAverse-UCB-m-best in PAC Bandits with Risk
%Constraints by Yahel David etc.
%N                  number of arms
%para               parameters for the arms
%bar                threshold for the variance
%epsilon_mu         accuracy for the expectation
%epsilon_v          accuracy for the variance

%% parameters for the algorithm
%confidence level 
delta=0.05;
%arms
arms=(1:N)';

%% algorithm warm up
%pull each of the arms twice
warmup=pull(arms,para);
%count the time step and sampling times
t=N;
count=ones(N,1);
%first momentum
fir=warmup;
%update the empirical mean
em=warmup;
%update the confidence radius
f_mu=alpha(count,N,delta,H);
%upper and lower confidence bound
ucb=em+f_mu;
lcb=em-f_mu;
%second momentum
sec=warmup.^2;
%empirical variance
evar=zeros(N,1);
%update the confidence radius for variance
f_v=beta(count,N,delta,H);
%upper and lower confidence bound for variance
ucbv=evar+f_v;
lcbv=evar-f_v;
flagin=1;
while 1
    hatKt=arms(lcbv<=bar);
    if length(hatKt)==5 && flagin==1
        flagin=0;
        disp(num2str(t));
    end
    [~,temp]=max(ucb(hatKt));
    k_dag=hatKt(temp); 
    pair=k_dag;
    %pull the arms
    x=pull(pair,para);
    %update
    t=t+1;
    count(pair)=count(pair)+1; 
    %first momentum
    fir(pair)=fir(pair)+x;
    %update the empirical mean
    em(pair)=fir(pair)/count(pair);
    %update the confidence radius
    f_mu(pair)=alpha(count(pair),N,delta,H);
    %upper and lower confidence bound
    ucb(pair)=em(pair)+f_mu(pair);
    lcb(pair)=em(pair)-f_mu(pair);
    %second momentum
    sec(pair)=sec(pair)+x.^2;
    %empirical variance
    evar(pair)=(sec(pair)-count(pair).*(em(pair).^2))./(count(pair)-1);
    %update the confidence radius for variance
    f_v(pair)=beta(count(pair),N,delta,H);
    %upper and lower confidence bound for variance
    ucbv(pair)=evar(pair)+f_v(pair);
    lcbv(pair)=evar(pair)-f_v(pair);
    if t>=H || (f_mu(pair)<=epsilon_mu/2 && ucbv(pair)-epsilon_v<=bar)
        i_out=pair;
        TC=t;
        break;
    end
end





end

function [y]=alpha(u,N,delta,H)
%compute the confidence bound
%r.v. bounded in [0,1] is 1/2-subguassian
sigma=1/2;
z=2*sigma^2./u*log(6*H*N/delta);
y=sqrt(z);
end

function [y]=beta(u,N,delta,H)
%compute the confidence bound
z=2./u*log(6*H*N/delta);
y=sqrt(z);
end
