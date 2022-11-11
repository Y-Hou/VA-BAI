function [reward_i] = pull(i,para)
%This function gives a reward of arm i after pull it once

%sample arm i
reward_i=betarnd(para(i,1),para(i,2));

end

