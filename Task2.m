clear all

T2_input

[m, n] = size(A);

slack_A = eye(m);
slack_C = zeros(2, m);

A = [A, slack_A];
C = [C, slack_C];

B = n+1:1:m+n; % Initial basis of slacks

[m, n] = size(A);

[ result,X,Y,basis,lambdas,t ] = parametric_biobjective_simplex( m,n,C,A,b,B );