function [para] = bpara(a,b)
%Get the parameters of a beta distribution which has mean a and variance b
alpha=(a.^2.*(1-a)-a.*b)./b;
beta=(a.*(1-a).^2-(1-a).*b)./b;
para=[alpha,beta];
end

