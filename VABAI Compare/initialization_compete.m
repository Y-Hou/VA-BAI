function [N,para,expec,variance,bar] = initialization_compete(competition,instance,trial)
%arms initialization
%N              number of arms
%test         test term index in H
%experiment     the experiment to show the role of min/max
%instance       the index in one experiment
rng(trial+40);     %this controls the reproducibility
j=instance;
switch competition 
      case 1
        %variance threshold
        bar=0.2;
        %istar
        a=0.3;
        b=0.16;
        mean_variance=[a,b];
        %feasible arms
        a1=(0.1:0.05:0.25)';
        b1=(0.08:0.02:0.14)';
        feasible=[a1,b1];
        mean_variance=vertcat(mean_variance,feasible); 
        %risky arms
        a2=(0.4:0.05:0.6)';
        b2=(bar+0.033-0.003*j)*ones(5,1);%bar+(0.01:0.01:0.04)';
        risky=[a2,b2];
        mean_variance=vertcat(mean_variance,risky); 
      case 2
        %variance threshold
        bar=0.2;
        %istar
        a=0.35;
        b=0.16;
        mean_variance=[a,b];
        %feasible arms
        a1=(0.1:0.05:0.25)';
        b1=(0.08:0.02:0.14)';
        feasible=[a1,b1];
        mean_variance=vertcat(mean_variance,feasible); 
        %risky arms
        a2=(0.4:0.05:0.6)';
        b2=(bar+0.033-0.003*j)*ones(5,1);
        risky=[a2,b2];
        mean_variance=vertcat(mean_variance,risky); 
    case 3
        %variance threshold
        bar=0.2;
        %istar
        a=0.35;
        b=0.16;
        mean_variance=[a,b];
        %feasible arms
        a1=(0.15:0.05:0.3)';
        b1=(0.08:0.02:0.14)';
        feasible=[a1,b1];
        mean_variance=vertcat(mean_variance,feasible); 
        %risky arms
        a2=(0.4:0.05:0.6)';
        b2=(bar+0.033-0.003*j)*ones(5,1);
        risky=[a2,b2];
        mean_variance=vertcat(mean_variance,risky); 
end
N=size(mean_variance,1);
%compute the parameters for beta distribution
para=bpara(mean_variance(:,1),mean_variance(:,2));
alpha=para(:,1);
beta=para(:,2);
expec=alpha./(alpha+beta);
variance=(alpha.*beta)./((alpha+beta).^2.*(alpha+beta+1));
end

