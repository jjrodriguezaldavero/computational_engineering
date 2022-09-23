% Example of the solution of a Parabolic Partial Differential
% Equation in a rectangular domain using a finite difference 
% schema

% Set the grid and boundary conditions

% Length of the mesh limits

lx = 1;
ly = 1;

% Number of divisions per dimension

hx = 0.01;
hy = 0.01;

ndx = lx / hx;
ndy = ly / hy;

% Initial time, timestep and final time

t = 0.0;
ht = 0.000001;
tf = 0.01;
nsteps = tf / ht;
n1 = round(nsteps/3.0);
n2 = round(2*nsteps/3.0);

fprintf('%d,%d,%d\n',nsteps, n1, n2)

rho = ht/(hx*hy);

% Number of mesh points per dimension

nx = ndx + 1;
ny = ndy + 1;

% Number of inner mesh points per dimension

nix = ndx - 1;
niy = ndy - 1;

xmin = 0.0;
xmax = lx;
ymin = 0.0;
ymax = ly;

% Set the postion of the nodes 

x = (xmin:hx:xmax);
y = (ymin:hy:ymax);

% Set the initial conditions

u = zeros(ny, nx);
for i = 1:ny
    for j = 1:nx
        u(i,j) = uinit(x(i),y(j));
    end
end

% Set the boundary conditons on the mesh edges

for i = 1:ny
    u(i,1) = ux0(y(i),t);
    u(i,nx) = uxmax(y(i),t);
end
for i = 1:nx
    u(1,i) = uy0(x(i),t);
    u(ny,i) = uymax(x(i),t);
end

% Plot the 2D solution at t=0;

subplot(2,2,1)
[X,Y] = meshgrid(x,y); 
contour(X,Y,u)
axis ('equal')
xlabel('x')
ylabel('y')
title('t = 0.0')

% Solve the Parabolic Equation

step = 0;

while (t <= tf)

    unew = zeros(ny,nx);

    for i = 2:niy
        for j = 2:nix
            unew(i,j)=(1-4*rho)*u(i,j) + rho*(u(i-1,j)+u(i+1,j)+ ... 
                u(i,j-1)+u(i,j+1));
        end
    end
    
    ue = zeros(ny,nx);
    for i = 1:ny
        for j=1:nx
            ue(i,j) = Temp(x(i),y(j),t);
        end
    end
            
    t = t + ht;
    
    u = unew;
    
    % Set the boundary conditons on the mesh edges

    for i = 1:ny
        u(i,1) = ux0(y(i),t);
        u(i,nx) = uxmax(y(i),t);
    end
    for i = 1:nx
        u(1,i) = uy0(x(i),t);
        u(ny,i) = uymax(x(i),t);
    end
    
    step = step + 1;

    if (step == n1)
        time=num2str(t);
        subplot(2,2,2)
        contour(X,Y,u)
        hold on
        contour(X,Y,ue,'--')
        axis ('equal')
        xlabel('x')
        ylabel('y')
        title(strcat('t = ',time))
    end
    if (step == n2)
        time=num2str(t);
        subplot(2,2,3)
        contour(X,Y,u)
        hold on
        contour(X,Y,ue,'--')
        axis ('equal')
        xlabel('x')
        ylabel('y')
        title(strcat('t = ',time))
    end
end

% Plot Final step

ue = zeros(ny,nx);
for i = 1:ny
   for j=1:nx
            ue(i,j) = Temp(x(i),y(j),t);
   end
end
            
time=num2str(t);
subplot(2,2,4)
contour(X,Y,u)
hold on
contour(X,Y,ue,'--')
axis ('equal')
xlabel('x')
ylabel('y')
title(strcat('t = ',time))
    
% Boundary conditions

% Initial conditions

function s = uinit(x,y)
    s = 100;
end

% Boundary conditons on the edge y=ymin=0

function s = uy0(x,t)
    s = 0.0;
end

% Boundary conditons on the edge y=ymax

function s = uymax(x,t)
    s = 100.0;
end

% Boundary conditons on the edge x=xmin=0

function s = ux0(y,t)
    s = 0.0;
end

% Boundary conditons on the edge x=xmax

function s = uxmax(y,t)
    s = 0.0;
end

% Exact Solution

function s = Temp(x,y,t)
    s = 0;
end

