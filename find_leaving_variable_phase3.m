function [r,minratio] = find_leaving_variable_phase3(m,xB,BinvAs,B)
% Returns the position in the basis of the leaving variable,
% or returns 0 if no leaving variable exists
% Input:
%   m         = number of constraints
%   xB        = mx1 basic variable vector
%   BinvAs    = mx1 vector of Binv*As
%   basicvars = 1xm vector of indices of basic variables

% Output:
%   r        = position in the basis of the leaving variable
%   minratio = minimum ratio from ratio test

r = 0;
minratio = Inf;
for i = 1 : m
    if BinvAs(i)>0
        ratio = inv(B)*xB(i)/BinvAs(i) ;
        if ratio < minratio
            minratio = ratio;
            r = i;
        end
    end
end
