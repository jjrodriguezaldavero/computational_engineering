function INTf=smpsns2(x,y)
%integral of an unknown function over an equispaced interval [x(1), x(N)] and its image [y(1), y(N)] by
%Simpson's rule with N points and N-1 segments. The number of segments has
%to be even.
format long;
N = length(x)-1; %number of segments
h = (x(N) - x(1))/(N-1); %length of segment
kodd = 2:2:N; keven = 3:2:N - 1; %the set of odd/even indices
INTf = h/3 * (y(1) + y(N+1) + 4*sum(y(kodd)) + 2*sum(y(keven)));
