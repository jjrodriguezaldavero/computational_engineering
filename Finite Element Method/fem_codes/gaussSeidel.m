function [x,numIter] = gaussSeidel(x0,A,b,maxIter,epsilon)

% Solves Ax = b by Gauss-Seidel method with relaxation.
% USAGE: [x,numIter,omega] = gaussSeidel(func,x,maxIter,epsilon)

% INPUT:
%   x0 = starting solution vector
%   A = System Array
%   b = independent vector
%   maxIter = allowable number of iterations (default is 500)
%   epsilon = error tolerance (default is 1.0e-9)
% OUTPUT:
%   x = solution vector
%   numIter = number of iterations carried out

if nargin < 5; epsilon = 1.0e-9; end
if nargin < 4; maxIter = 500; end

sizeX = length(x0);
x = x0;
NormIt = Inf;

for numIter = 1:maxIter
    
  xOld = x;
  for i = 1:sizeX;
      sum = b(i);
      for j = 1:i-1;
          sum = sum - A(i,j)*x(j);
      end
      for j = i+1:sizeX;
          sum = sum - A(i,j)*xOld(j);
      end
      x(i) = sum / A(i,i);
  end
  NormIt = norm(x - xOld);
  
  if NormIt < epsilon; return; end
  
  if numIter == maxIter; end

end
error('Too many iterations')