function [result, X, Y, basis, lambdas, t] = parametric_biobjective_simplex(m, n, C, A, b, basicvars)
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
C = C';

[success, ~, x, basicvars] = rsm(m, n, C(:,1), A, b, basicvars);
if (success == -1)
    result = -1;
    return
end

% Initialise phase III variables
CB = C(basicvars,:);
B = A(:,basicvars);
xB = inv(B)*b;
result = 0;

% Initialise output vectors
lambdas = 1;
X = x;
z = CB' * xB;
Y = z;
basis = basicvars';

% Phase III: biobjective simplex iterations
% Do parametric simplex iterations ...
while result == 0
    % while the optimal solution of LP(0) has not been found ... 

    % Calculate reduced cost vector
    red_cost_1 = C(:,1)' - CB(:,1)' * (inv(B) * A);
    red_cost_2 = C(:,2)' - CB(:,2)' * (inv(B) * A);

    % identify entering variable s and lambda ...
    [s, lambda] = find_entering_variable_phase3(n, red_cost_1, red_cost_2, basicvars);
    
    % identify leaving variable r ...
    if s > 0
        % Calculate Binv*As
        BinvAs = inv(B) * A(:,s);
        
        % Find basic leaving variable
        [r, ~] = find_leaving_variable_phase3(m, xB, BinvAs);
        if r > 0
            % Update basis representation          
            [basicvars, CB, B, xB] = update_phase3(C, A, b, s, r, basicvars, CB, B);

        else
            result = -1;  % unbounded
        end
        
        basis = [basis, basicvars'];
        
        x = zeros(n,1);
        x(basicvars) = xB;
        X = [X, x];
        
        z = CB'*xB;
        Y = [Y, z];
        
    else % declare optimal
        result = 1;  % optimal
    end
    
    lambdas = [lambdas, lambda];

end

t = length(Y);

end
