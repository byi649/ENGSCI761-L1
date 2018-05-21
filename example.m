% Example from notes, second objective function only
% min c'x
%      Ax =  b
%       x >= 0

c = [-1 -2 0 0];
A = [0 1 1 0;
     3 -1 0 1];
b = [3 6]';
[m,n] = size(A);
basicvars = [3 4];

[success,z,x,basicvars] = rsm(m,n,c',A,b,basicvars);

x
z