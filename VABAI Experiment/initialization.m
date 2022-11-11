function [para,expec,variance,bar] = initialization(N,test,instance,trial)
%arms initialization
%N              number of arms
%test         test term index in H
%experiment     the experiment to show the role of min/max
%instance       the index in one experiment
rng(trial+20);     %for reproducibility
j=instance;
switch test %test the four terms
    case 1
        %variance threshold
        bar=0.25;
        %istar
        a=0.7;
        delta_istar=0.01*1.2^j;  
        b=0.09;
        mean_variance=[a,b];
        %istarstar
        a1=a-delta_istar;
        b1=0.09;
        mean_variance=vertcat(mean_variance,[a1,b1]);
        %other arms
        a2=0.2;
        b2=0.09;
        mean_variance=vertcat(mean_variance,repmat([a2,b2],N-2,1));
    case 2
        %variance threshold
        bar=0.25;
        %istar
        a=0.55;
        delta_istar=0.02;
        b=bar-0.01*1.2^j;  
        mean_variance=[a,b];
        %istarstar
        a1=a-delta_istar;
        b1=0.09;
        mean_variance=vertcat(mean_variance,[a1,b1]);
        %other arms
        a2=0.15;
        b2=0.09;
        mean_variance=vertcat(mean_variance,repmat([a2,b2],N-2,1));
    case 3
        %variance threshold
        bar=0.25;
        %istar
        a=0.55;
        delta_istar=0.4;
        b=bar-0.01*1.2^j;  
        mean_variance=[a,b];
        %istarstar
        a1=0.15;
        b1=0.09;
        mean_variance=vertcat(mean_variance,[a1,b1]);
        %other arms
        a2=0.15;
        b2=0.09;
        mean_variance=vertcat(mean_variance,repmat([a2,b2],N-2,1));
    case 4
        %variance threshold
        bar=0.04;
        %istar
        a=0.7;
        delta_istar=0.02*1.1^j;    %j=0:10
        b=0.03;  
        mean_variance=[a,b];
        %istarstar
        a1=a-delta_istar;
        b1=0.03;
        mean_variance=vertcat(mean_variance,[a1,b1]);
        %other arms
        a2=0.3;
        b2=0.03;
        mean_variance=vertcat(mean_variance,repmat([a2,b2],N-2,1));
    case 5
        %variance threshold
        bar=0.25;
        %istar
        a=0.7;
        delta_istar=0.02*1.2^j;    
        b=0.09;  
        mean_variance=[a,b];
        %istarstar
        a1=a-delta_istar;
        b1=0.09;
        mean_variance=vertcat(mean_variance,[a1,b1]);
        %other arms
        a2=a-delta_istar;   %j=0:10
        b2=0.09;
        mean_variance=vertcat(mean_variance,repmat([a2,b2],N-2,1));
    case 6
        %variance threshold
        bar=0.04;
        %other arms
        a2=0.55;   
        b2=bar+0.01*1.2^j; %j=0:4
        mean_variance=repmat([a2,b2],N,1);
    case 7
        %variance threshold
        bar=0.04;
        %istar
        a=0.7;
        delta_istar=0.02*1.2^j;   
        b=0.03;  
        mean_variance=[a,b];
        %istarstar
        a1=a-delta_istar;
        b1=0.2;
        mean_variance=vertcat(mean_variance,[a1,b1]);
        %other arms
        a2=a-delta_istar;   
        b2=0.2;
        mean_variance=vertcat(mean_variance,repmat([a2,b2],N-2,1));
    case 8
        %variance threshold
        bar=0.04;
        %istar
        a=0.55;
        delta_istar=0.02;       
        b=0.03;  
        mean_variance=[a,b];
        %istarstar
        a1=0.53;
        b1=bar+0.05*1.1^j;     %j=0:10
        mean_variance=vertcat(mean_variance,[a1,b1]);
        %other arms
        a2=0.53;
        b2=b1;      %j=0:4
        %mean_variance=vertcat(mean_variance,repmat([a2,b2],n-2,1));
        mean_variance=vertcat(mean_variance,repmat([a2,b2],N-2,1));
    case 9
        %variance threshold
        bar=0.2;
        %istar
        a=0.7;
        delta_istar=0.09*1.1^j;    %j=0:10
        b=0.04;  
        mean_variance=[a,b];
        %other arms
        a2=a-delta_istar; 
        b2=0.21;      
        mean_variance=vertcat(mean_variance,repmat([a2,b2],N-1,1));
    case 10
        %variance threshold
        bar=0.04;
        %istar
        a=0.7;
        delta_istar=0.4;       
        b=0.03;  
        mean_variance=[a,b];
        %other arms
        a2=0.3; 
        b2=bar+0.01*1.2^j;       %j=0:10
        mean_variance=vertcat(mean_variance,repmat([a2,b2],N-1,1));        
end
%compute the parameters for beta distribution
para=bpara(mean_variance(:,1),mean_variance(:,2));
alpha=para(:,1);
beta=para(:,2);
expec=alpha./(alpha+beta);
variance=(alpha.*beta)./((alpha+beta).^2.*(alpha+beta+1));
end

