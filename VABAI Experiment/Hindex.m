function [H,Delta,Delta_v]=Hindex(N,expec,variance,bar)
%calculate H for a given instance
arms=(1:N)';
feasible=arms(variance<=bar);       %feasible arms
infeasible=arms(variance>bar);      %infeasible arms 
Delta=zeros(N,1);
if isempty(feasible)
    Delta_v=abs(variance-bar);
    H=sum(1./Delta_v.^2);
else
    [~,temp]=max(expec(feasible));
    i_star=feasible(temp); 
    suboptimal=arms(expec<expec(i_star));
    infU=intersect(infeasible,arms(expec>=expec(i_star)));
    infL=intersect(infeasible,arms(expec<expec(i_star)));
    FS=setdiff(feasible,[i_star]);

    Delta=max(0,expec(i_star)-expec);
    if isempty(Delta(Delta>0))
        Delta(i_star)=inf;  %MATLAB has 1/inf=0 and 1/0=inf
    else
        Delta(i_star)=min(Delta(Delta>0));
    end
    Delta_v=abs(variance-bar);
    H=1./min(Delta(i_star)/2,Delta_v(i_star))^2;
    H=H+sum(1./(Delta(FS)./2).^2);
    H=H+sum(1./Delta_v(infU).^2);
    H=H+sum(1./max(Delta(infL)./2,Delta_v(infL)).^2);
end
end

