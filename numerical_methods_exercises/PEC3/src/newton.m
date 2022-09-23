function [x,fx,xx] = newton(f,df,x0,TolX,MaxIter)
%newton.m to solve f(x) = 0 by using Newton method.
%input: f = ftn to be given as a string ’f’ if defined in an M-file
% df = df(x)/dx (If not given, numerical derivative is used.)
% x0 = the initial guess of the solution
% TolX = the upper limit of |x(k) - x(k-1)|
% MaxIter = the maximum # of iteration
%output: x = the point which the algorithm has reached
% fx = f(x(last)), xx = the history of x
h = 1e-4; h2 = 2*h; TolFun=eps;
if nargin == 4 & isnumeric(df), MaxIter = TolX; TolX = x0; x0 = df; end
xx(1) = x0; fx = vpa(feval(f,x0),30);
for k = 1: MaxIter
if ~isnumeric(df), dfdx = vpa(feval(df,xx(k)),30); %derivative function
else dfdx = vpa((feval(f,xx(k) + h)-feval(f,xx(k) - h))/h2,30); %numerical drv
end
dx = vpa(-fx/dfdx,30);
xx(k+1) = vpa(xx(k)+dx,30); %Eq.(4.4.2)
fx = vpa(feval(f,xx(k + 1)),30);
if abs(fx)<TolFun | abs(dx) < TolX, break; end
end
x = vpa(xx(k + 1),30);
if k == MaxIter, fprintf('The best in %d iterations\n',MaxIter), end