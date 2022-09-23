function INTf = trpzds2(x,y)
%integral of an unknown function over an equispaced interval [x(1), x(N)] and its image [y(1), y(N)] by
%trapezoidal rule with N points and N-1 segments.
format long;
N = length(x);
h = (x(N) - x(1))/(N-1); %length of segment
INTf = h*((y(1)+y(N))/2 + sum(y(2:N-1))); %we apply Eq.(5.6.1) from book