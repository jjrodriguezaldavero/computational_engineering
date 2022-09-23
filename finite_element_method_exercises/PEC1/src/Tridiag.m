function x = Tridiag(e,f,g,r)
% Tridiag: Trodiagonal equation solver banded system
% x = Tridiag(e,f,g,r): Tridiagonal system solver.
% Thomas Algorithm

% input:
% e = subdiagonal vector
% e must be filled from 2 to n
% f = diagonal vector
% f is a full vector from 1 to n
% g = superdiagonal vector
% g must be filled from 1 to n-1
% r = right hand side vector

% output:
% x = solution vector

% Size of the array
n=length(f);

% forward elimination
for k = 2:n
factor = e(k)/f(k-1);
f(k) = f(k) - factor*g(k-1);
r(k) = r(k) - factor*r(k-1);
end

% back substitution
x(n) = r(n)/f(n);
for k = n-1:-1:1
    x(k) = (r(k)-g(k)*x(k+1))/f(k);
end 