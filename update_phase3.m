function [basicvars, CB, B, xB] = update_phase3(C, A, b, s, r, basicvars, CB, B)
% Updates the basis representation.
% Input:
%   C         = nx2 cost matrix
%   A         = mxn constraint matrix
%   b         = mx1 rhs matrix
%   s         = index of entering variable
%   r         = position in the basis of the leaving variable
%   basicvars = 1xm vector of indices of basic variables
%   CB        = mx2 basic cost matrix
%   B         = mxm basis matrix
%   xB        = mx1 basic variable vector
% Output:
%   basicvars = 1xm updated basicvars vector
%   CB        = mx2 updated basic cost matrix
%   B         = mxm updated basis matrix
%   xB        = mx1 updated basic variable vector

basicvars(r) = s;
CB(r,:) = C(s,:);
B(:,r) = A(:,s);
xB = inv(B) * b;        
