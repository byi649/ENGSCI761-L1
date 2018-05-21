function [result,z,x,basicvars] = rsm(m,n,c,A,b,basicvars)
% Solves a linear program using the Revised Simplex Method
% Assumes standard computational form
% Starts from the given initial basic feasible solution
% Input:
%   m,n       = number of constraints and variables
%   c         = nx1 cost vector
%   A         = mxn constraint matrix
%   b         = mx1 rhs vector
%   basicvars = 1xm vector of indices of basic variables
% Output:
%   result    = 1 if problem optimal, -1 if unbounded
%   z         = objective function value
%   x         = nx1 solution vector
%   basicvars = 1xm vector of indices of basic variables

% Initialise
cB = c(basicvars);
B = A(:,basicvars);
xB = inv(B)*b;
result = 0;

% Do RSM iterations
while result == 0
    % Calculate reduced cost vector
    red_cost = c'-(cB'*inv(B))*A;

    % Find nonbasic entering variable
    [s,rc] = find_entering_variable(n,red_cost,basicvars);
    
    if s > 0
        % Calculate Binv*As
        BinvAs = inv(B)*A(:,s);
        
        % Find basic leaving variable
        [r,ratio] = find_leaving_variable(m,xB,BinvAs);
        if r > 0
            % Update basis representation          
            [basicvars,cB,B,xB] = update(m,c,A,b,s,r,basicvars,cB,B,xB);

        else
            result = -1;  % unbounded
        end
    else % declare optimal
        result = 1;  % optimal
    end
end

x = zeros(n,1);
x(basicvars) = xB;
z = cB'*xB;

