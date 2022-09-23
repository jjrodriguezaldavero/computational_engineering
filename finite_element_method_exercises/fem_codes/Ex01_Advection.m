% Example 01
% Advection

% Fluid Velocity 
c = 1.0;

% Set the constants and the values of the grid

delta_t = 0.5;
delta_x = 0.5;

Courant = c * delta_t / delta_x;

xmax = 20.0;
x=[0:delta_x:xmax];
m = length(x);
y=zeros(1,m);

% Set the Initial Condition

i = find(x == 4);
j = find(x == 5);
k = find(x ==6);

for l = i:j
    y(l) = (x(l)-4);
end
for l = j:k
    y(l) = (6-x(l));
end

% Plot the initial conditions

plot(x,y)
xlabel ('x')
ylabel ('y')
title ('Advection')
axis ([0 20 0 1.5])
hold on

% Main finite difference schema

ynew = zeros(1,m);
t = 0.0;
while (t <= 20.0)
    
    ynew(1)=0.0;
    for j=2:m
        ynew(j) = (1-Courant)*y(j) + Courant*y(j-1);
    end
    y = ynew;
    if mod(t,5) == 0
        plot (x,y)
        hold on
    end
    t = t + delta_t;
end