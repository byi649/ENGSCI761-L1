function [ result,X,Y,basis,lambdas,t ] = parametric_biobjective_simplex( m,n,C,A,b,basicvars )
% Solves a linear program using the parametric biobjective simplex method
% Assumes input in form
%       min Cx
%           Ax = b
%            x >= 0
%
% Assumes initial basic feasible solution given in basicvars
% Input:
%   m,n       = number of constraints and variables
%   C         = 2xn cost matrix
%   A         = mxn constraint matrix
%   b         = mx1 rhs vector
%   basicvars = mx1 vector of indices of basic variables
% Output:
%   result  = 1 if problem optimal, -1 if unbounded
%   X       = matrix of nx1 basic feasible solutions, one per nondominated 
%             (extreme) point. X(:,i) is ith efficient solution.
%   Y       = matrix of px1 objective vectors, one per nondominated 
%             (extreme) point. Y(:,i) is ith objective vector.
%   basis   = matrix of mx1 basis, one per nondominated extreme point. 
%             basis(:,i) contains the indices of the variables in the ith
%             basis
%   lambdas = vector of lambdas, one for each basis above. 
%             basis(:,i) is optimal for lambda values between lambdas(i)
%             and lambdas(i+1)
%   t       = total number of (extreme) points found

% Phase I: construct initial feasible basis
% omitted as we assume initial feasible basis is given.



% Phase II: Find optimal solution of LP(1)
% TODO ...


% Phase III: biobjective simplex iterations
% Do parametric simplex iterations ...
while result == 0
    % while the optimal solution of LP(0) has not been found ... 
    % TODO ...

    % identify entering variable s and lambda ...
    
    % identify leaving variable r ...
    
    % update basis, etc ...
    
end

end
