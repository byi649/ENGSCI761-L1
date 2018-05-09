function [s,minrc] = find_entering_variable(n,red_cost,basicvars)
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
minrc = 0;

nonbasicvars = setdiff([1:n],basicvars); % extract nonbasic variables

for j = nonbasicvars
    if red_cost(j) < minrc
        minrc = red_cost(j);
        s = j;
    end 
end

