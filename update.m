function [basicvars,cB,B,xB] = update(m,c,A,b,s,r,basicvars,cB,B,xB)
% Updates the basis representation.
% Input:
%   m,n       = number of constraints and variables
%   c         = nx1 cost vector
%   A         = mxn constraint matrix
%   b         = mx1 rhs matrix
%   s         = index of entering variable
%   r         = position in the basis of the leaving variable
%   basicvars = 1xm vector of indices of basic variables
%   nonbasicvars = 1x(n-m) vector of indices of non-basic variables
%   cB        = mx1 basic cost vector
%   B         = mxm basis matrix
%   xB        = mx1 basic variable vector
% Output:
%   basicvars = 1xm updated basicvars vector
%   cB        = mx1 updated basic cost vector
%   B         = mxm updated basis matrix
%   xB        = mx1 updated basic variable vector

basicvars(r) = s;
cB(r) = c(s);
B(:,r) = A(:,s);
xB = inv(B)*b;        
