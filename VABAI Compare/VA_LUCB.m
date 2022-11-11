function [i_out,flag,TC] = VA_LUCB(N,para,bar)
%LUCB for the variance constrained case
%% parameters for the algorithm
%confidence level 
delta=0.05;
%arms
arms=(1:N)';

%% algorithm warm up
%pull each of the arms twice
warmup=zeros(N,2);
warmup(:,1)=pull(arms,para);
warmup(:,2)=pull(arms,para);
%count the time step and sampling times
t=N;
count=2*ones(N,1);
pfeasible=arms;
%%
flagin=1;
while 1
     if length(pfeasible)==5 && flagin==1
        flagin=0;
        disp(num2str(t));
    end
    if t==N
        %first momentum
        fir=sum(warmup,2);
        %update the empirical mean
        em=fir/2;
        %update the confidence radius
        cr=theta(count,t,N,delta);
        %upper bound
        ucb=em+cr;
        %lower bound
        lcb=em-cr;
        %second momentum
        sec=sum(warmup.^2,2);
        %empirical variance
        evar=sum((warmup-[em,em]).^2,2);
        %upper bound for variance
        ucbv=evar+cr;
        %lower bound for variance
        lcbv=evar-cr;
    else
        %first momentum
        fir(pair)=fir(pair)+x;
        %update the empirical mean
        em(pair)=fir(pair)./count(pair);   
        %update the confidence bound
        cr(pfeasible)=theta(count(pfeasible),t,N,delta);
        %upper bound
        ucb(pfeasible)=em(pfeasible)+cr(pfeasible);
        %lower bound
        lcb(pfeasible)=em(pfeasible)-cr(pfeasible);
        %second momentum
        sec(pair)=sec(pair)+x.^2;
        %empirical variance
        evar(pair)=(sec(pair)-count(pair).*(em(pair).^2))./(count(pair)-1);
        %upper bound for variance
        ucbv(pfeasible)=evar(pfeasible)+cr(pfeasible);
        %lower bound for variance
        lcbv(pfeasible)=evar(pfeasible)-cr(pfeasible);
    end

    %find feasible/almost feasible/infeasible arms
    feasible=arms(ucbv<=bar); %feasible arms at time t
    pfeasible=arms(lcbv<=bar);   %possibly feasible arms at time t
    %infeasible=arms(lcbv>bar);    %infeasible arms at time t
    if isempty(feasible)
        potential=(1:N)';
    else
        %get i_t^\star
        [~,temp]=max(em(feasible));
        i_tstar=feasible(temp); 
        % get the potential arms at time t
        potential=arms(ucb>=lcb(i_tstar)); 
        potential=setdiff(potential,i_tstar);
    end
    if isempty(intersect(pfeasible,potential))    %no not feasible arms at time t
        if isempty(feasible)
            flag=0;
            i_out=0;
        else
            [~,temp]=max(em(pfeasible));
            i_t=pfeasible(temp);  
            i_out=i_t;
            flag=1;    
        end
        break;
    end
    %exist at least one not_infeasible arm at time t
    %get i_t
    [~,temp]=max(em(pfeasible));
    i_t=pfeasible(temp);  
    %get the other arm c_t
    pfeasible1=setdiff(pfeasible,i_t);
    if isempty(pfeasible1) %in case there's only one arm in pinfeasible
        pair=i_t;
    else
        [~,temp]=max(ucb(pfeasible1));
        c_t=pfeasible1(temp);
        if ucb(c_t)>=lcb(i_t)
            pair=[i_t;c_t];
        else
            pair=i_t;
        end
    end
    
    %pull the arms
    x=pull(pair,para);
    
    count(pair)=count(pair)+1;
    t=t+1;

end
TC=sum(count);
%save(index);

function [y]=theta(u,t,N,delta)
%compute the confidence bound
k=2;
z=0.5./u*log(k*N*t^4/delta);
y=sqrt(z);
end
end

