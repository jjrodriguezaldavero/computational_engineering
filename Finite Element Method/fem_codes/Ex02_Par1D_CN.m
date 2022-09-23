% Example 02
% 1D Parabolic Equation
% Crank-Nicholson Method

% Number of Divisions

N = 100;
tmax = 0.1;

% Set the constants and the values of the grid

delta_x = 1 / N;
rho = 0.52;
delta_t = rho * (delta_x)^2;

tsteps = tmax / delta_t; 

xmax = 1.0;
x=[0:delta_x:xmax];
m = length(x);
y=zeros(1,m);

% Set the Initial Condition

for i = 1:m
    y(i) = u0(x(i));
end

% Plot the initial conditions

plot(x,y)
xlabel ('x')
ylabel ('y')
title ('1D Crank-Nicholson')
axis ([0 1 0 1.5])
text (0.1,1.3,strcat('rho=',num2str(rho,2)))
hold on

% Main finite difference schema

t = 0.0;
it = 0;

while (t <= tmax)

ynew = zeros(1,m);

% Set the tridiagonal system matrix
% Note that the size of the system is m-2
% As we exclude x=0 and x=N

n = m-2;
ut = zeros(1,n);
e = -rho*ones(1,n);
e(1) = 0.0;
f = 2*(1+rho)*ones(1,n);
g = -rho*ones(1,n);
g(n) = 0.0;

for i=2:m-1
    ut(i-1)=rho*y(i-1)+2*(1-rho)*y(i)+rho*y(i+1);
end

% Add the boundary conditions at the extremes.

ut(1) = ut(1) + rho*x0(t+delta_t);
ut(n) = ut(n) + rho*xN(t+delta_t);

% Solve the Tridiagonal sytem

unew = Tridiag(e,f,g,ut);

ynew(2:m-1) = unew;

y = ynew;
it = it + 1;
t = t + delta_t;

    if (mod(it,200) == 0)
%    if (it == 1)
        plot (x,y,'r')
        text (0.45,max(y)+0.05,strcat('t=',num2str(t,2)))
        hold on
    end
end

% Initial conditions
function y = u0(x)
   y = -sin(3*pi*x) + 0.25 * sin(6*pi*x)
end

% Boundary conditions 
function y = x0(t)
    y = 0.0;
end
function y = xN(t)
    y = 0.0;
end

