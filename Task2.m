clear all

BLP_input_2017

[m, n] = size(A);

slack_A = eye(m);
slack_C = zeros(2, m);

A = [A, slack_A];
C = [C, slack_C];

basicvars = n+1:1:m+n; % Initial basis of slacks

[m, n] = size(A);

[result, X, Y, basis, lambdas, t] = parametric_biobjective_simplex(m, n, C, A, b, basicvars);

strings = cellstr(num2str(lambdas(1:end)'));
for i = 1:length(strings)
    strings{i} = strtrim(strings{i});
    strings{i} = ['\lambda = ', strings{i}];
end

scatter(Y(1,:), Y(2,:));
xlabel('f(1)')
ylabel('f(2)')
title('Objective space')

text(Y(1,:) + 0.05, Y(2,:) + 0.05, strings(1:end-1));