function [s,lambda] = find_entering_variable_phase3(n,red_cost_1,red_cost_2,basicvars)
% Returns the index of the entering variable and its reduced cost,
% or returns s = 0 if no entering variable exists
% Input:
%   n          = number of variables
%   red_cost   = 1xn reduced cost vector
%   basicvars  = 1xm vector of indices of basic variables
% Output:
%   s     = index of the entering variable
%   minrc = reduced cost of the entering variable

s = 0;
lambda = 0;

nonbasicvars = setdiff([1:n],basicvars); % extract nonbasic variables

for j = nonbasicvars
    lambda_temp = -red_cost_2(j) / (red_cost_1(j) - red_cost_2(j));
    if lambda_temp > lambda && red_cost_1(j) > 0 && red_cost_2(j) < 0
        lambda = lambda_temp;
        s = j;
    end 
end

