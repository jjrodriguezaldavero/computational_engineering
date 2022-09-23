function [x,fx,xx] = secant(f,x0,TolX,MaxIter,varargin)
% solve f(x) = 0 by using the secant method.
%input : f = ftn to be given as a string �f� if defined in an M-file
% x0 = the initial guess of the solution
% TolX = the upper limit of |x(k) - x(k - 1)|
% MaxIter = the maximum # of iteration
%output: x = the point which the algorithm has reached
% fx = f(x(last)), xx = the history of x
h = 1e-4; h2 = 2*h; TolFun=eps;
xx(1) = x0; fx = feval(f,x0,varargin{:});
for k = 1: MaxIter
if k <= 1, dfdx = (feval(f,xx(k) + h,varargin{:})-...
feval(f,xx(k) - h,varargin{:}))/h2;
else dfdx = (fx - fx0)/dx;
end
dx = -fx/dfdx;
xx(k + 1) = xx(k) + dx; %Eq.(4.5.2)
fx0 = fx;
fx = feval(f,xx(k+1));
if abs(fx) < TolFun | abs(dx) < TolX, break; end
end
x = xx(k + 1);
if k == MaxIter, fprintf('The best in %d iterations\n',MaxIter), end