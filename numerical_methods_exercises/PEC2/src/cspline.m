function [S] = cspline(x,y,dy0,dyN)
N = length(x) - 1;

A = zeros(N + 1,N + 1); b = zeros(N + 1,1);
S = zeros(N + 1,4); % Cubic spline coefficient matrix
k = 1:N; h(k) = x(k + 1) - x(k); dy(k) = (y(k + 1) - y(k))/h(k);

A(1,1:2) = [2*h(1) h(1)]; b(1) = 3*(dy(1) - dy0); %Eq.(3.5.5a)
A(N + 1,N:N + 1) = [h(N) 2*h(N)]; b(N + 1) = 3*(dyN - dy(N));%Eq.(3.5.5b)

for m = 2:N
A(m,m - 1:m + 1) = [h(m - 1) 2*(h(m - 1) + h(m)) h(m)];
b(m) = 3*(dy(m) - dy(m - 1));
end
S(:,3) = linsolve(A,b);

for m = 1: N
S(m,4) = (S(m+1,3)-S(m,3))/3/h(m); %Eq.(3.5.9)
S(m,2) = dy(m) -h(m)/3*(S(m + 1,3)+2*S(m,3));
S(m,1) = y(m);
end
S = S(1:N, 4:-1:1); %descending order