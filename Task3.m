clear all

T3_input

[m, n] = size(A);
[p, ~] = size(C);

slack_A = eye(m);
slack_C = zeros(p, m);

A = [A, slack_A];
C = [C, slack_C]';

[m, n] = size(A);

basicvars = [2, 5, 6];

% Initialise phase III variables
CB = C(basicvars,:);
B = A(:,basicvars);
xB = inv(B)*b;
result = 0;

% Phase III: biobjective simplex iterations
% Do parametric simplex iterations ...

% Calculate reduced cost vector
C_r = (C' - CB' * inv(B) * A)';

nonbasicvars = setdiff(1:n, basicvars); % extract nonbasic variables
R = C_r(nonbasicvars, :);