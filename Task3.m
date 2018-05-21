%% Input problem data and assume phase II solution
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

% Calculate reduced cost vector
C_r = (C' - CB' * inv(B) * A)';

nonbasicvars = setdiff(1:n, basicvars); % extract nonbasic variables
R = C_r(nonbasicvars, :)';

%% Solve LP to find efficient entering variables
j = 1;

% Preallocate zeros for simplicity
[m, n] = size(R);
A = zeros(m + n, m + 1);
b = zeros(m + n, 1);

% Maximise \lambda_min
f = [zeros(m, 1); -1];

% \lambda' * R >= 0
A(1:n, 1:m) = -R';

% \lambda' * r_j = 0
Aeq = [R(:, j)', 0];
beq = 0;

% \lambda_min <= lamda
A(n+1:end, 1:m) = -eye(m);
A(n+1:end, m+1:end) = ones(m,1);

% \lambda_min > 0
% \lambda_min >= epsilon
lb = [zeros(m, 1); 1e-3]; 

% Bound problem
ub = ones(m+1, 1);

x = linprog(f, A, b, Aeq, beq, lb, ub);

%% Find feasible bases
% Efficient entering variables: index 1, 2 -> x1, x3
% Current variables in basis: x2, x5, x6

for i = [1, 3]
    for j = 1:3
        basicvars_test = basicvars;
        basicvars_test(j) = i;
        B = A(:, basicvars_test);
        % Check for feasibility
        if ( det(B) ~= 0 && sum( inv(B)*b > 0 ) == 3 )
            disp(basicvars_test);
        end
    end
end
