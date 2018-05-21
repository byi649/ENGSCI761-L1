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


% Solve LP to find efficient entering variables
[m, n] = size(R);
A = zeros(m + n, m + 1);
b = zeros(m + n, 1);
f = [zeros(m, 1); -1];

% \lambda' * R >= 0
A(1:n, 1:m) = -R';

% \lambda' * r_1 = 0
Aeq = [R(:, 1)', 0];
beq = 0;

% \lambda_min <= lamda
A(n+1:end, 1:m) = eye(m);
A(n+1:end, m+1:end) = ones(m,1);

% \lambda > 0
A = [A; -ones(1, m), 0];
b = [b; -1];

lb = zeros(m+1, 1);
ub = [];
x = linprog(f, A, b, Aeq, beq, lb, ub);