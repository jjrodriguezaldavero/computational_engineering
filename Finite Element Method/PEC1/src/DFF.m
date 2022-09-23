% Example 02
% 1D Parabolic Equation
% DuFort-Frankel Method

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
title ('1D DuFort Frankel')
axis ([0 1 0 1.5])
text (0.1,1.3,strcat('rho=',num2str(rho,2)))
hold on

% First Iteration using Explicit Method

y1 = zeros(1,m);
t = 0.0;

% Set the boundary condition at x=0
y1(1)=0.0;
for j=2:m-1
     y1(j) = y(j) + rho*(y(j+1) - 2*y(j) + y(j-1));
end
% Set the boundary condition at x=1
y1(m) = 0.0;

% Rename the oldest step
y2 = y;
y = y1;
t = t + delta_t;

% Main finite difference schema

y1 = zeros(1,m);
it = 1;
while (t <= tmax)
    
    % Set the boundary condition at x=0
    y1(1)=0.0;
    for j=2:m-1
        y1(j) = 2*rho/(1+2*rho)*(y(j+1)+y(j-1))+(1-2*rho)/(1+2*rho)*y2(j);
    end
    % Set the boundary condition at x=1
    y1(m) = 0.0;
    
    y2 = y;
    y = y1;
    
    it = it + 1;
    if (mod(it,200) == 0)
%    if (it == 20)
        plot (x,y,'r')
        text (0.45,max(y)+0.05,strcat('t=',num2str(t,2)))
        hold on
    end
    t = t + delta_t;
end

% Initial conditions
function y = u0(x)
   y = -sin(3*pi*x) + 0.25 * sin(6*pi*x)
end

