% Example of the solution of a Parabolic Partial Differential
% Equation in a rectangular domain using a finite difference 
% schema
% Implicit ADI Method

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
ht = 0.00001;
tf = 4000*ht;
nsteps = tf / ht;
n1 = round(nsteps/3.0);
if (mod(n1,2) ~= 0) 
    n1 = n1 + 1;
end
n2 = round(2*nsteps/3.0);
if (mod(n2,2) ~= 0) 
    n2 = n2 + 1;
end

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

fprintf('nsteps, n1, n2 = %d,%d,%d\n',nsteps, n1, n2)
fprintf('ht, tf = %f,%f\n',ht,tf)
fprintf('rho = %f\n',rho)
fprintf('ny, nx = %d,%d\n',ny,nx)

% Set the initial conditions

u = zeros(nx, ny);
for i = 1:nx
    for j = 1:ny
        u(i,j) = uinit(x(i),y(j));
    end
end

% Set the boundary conditons on the mesh edges

for i = 1:nx
    u(i,1) = uy0(x(i),t);
    u(i,ny) = uymax(x(i),t);
end
for i = 1:ny
    u(1,i) = ux0(y(i),t);
    u(nx,i) = uxmax(y(i),t);
end

% Plot the 2D solution at t=0;

ue = zeros(nx,ny);
for i = 1:nx
    for j=1:ny
        ue(i,j) = Temp(x(i),y(j),t);
    end
end

subplot(2,2,1)
[X,Y] = meshgrid(x,y); 
contour(X,Y,u')
contour(X,Y,ue')
axis ('equal')
xlabel('x')
ylabel('y')
title('t = 0.0')

% Solve the Parabolic Equation

step = 0;

while (t <= tf)
    
    % Solve for the inner niy rows

    u1 = zeros(nx,ny);
    
    % Set the tridiagonal system matrix
    % Note that the size of the system is nix
    % As we exclude x=0 and x=nx

    ut = zeros(1,nix);
    e = -rho*ones(1,nix);
    e(1) = 0.0;
    f = (1+2*rho)*ones(1,nix);
    g = -rho*ones(1,nix);
    g(nix) = 0.0;

    for i = 2:ndy  % For each inner row in the x direction
        d = zeros(1,nix);
        for j = 2:ndx
             d(j-1) = u(i,j) + rho*(u(i,j-1)-2*u(i,j)+u(i,j+1));
        end
        ut = Tridiag(e,f,g,d);
        u1(i,2:ndx) = ut;
    end

    step = step + 1;
    t = t + ht;
    
    % Set the boundary conditions at this time step.
    
    for i = 1:nx
        u1(i,1) = uy0(x(i),t);
        u1(i,ny) = uymax(x(i),t);
    end
    for i = 1:ny
        u1(1,i) = ux0(y(i),t);
        u1(nx,i) = uxmax(y(i),t);
    end

    u = zeros(nx,ny);
    
    % Set the tridiagonal system matrix
    % Note that the size of the system is now niy
    % As we exclude y=0 and y=ny

    ut = zeros(1,niy);
    e = -rho*ones(1,niy);
    e(1) = 0.0;
    f = (1+2*rho)*ones(1,niy);
    g = -rho*ones(1,niy);
    g(niy) = 0.0;

    for j = 2:ndx  % For each inner row in the y direction
       d = zeros(1,niy);
       for i = 2:ndy
            d(i-1) = u1(i,j) + rho*(u1(i-1,j)-2*u1(i,j)+u1(i+1,j));
        end
        ut = Tridiag(e,f,g,d);
        u(2:ndy,j) = ut;
    end

    step = step + 1;
    t = t + ht;
    
    % Set the boundary conditions at this time step.
    
    for i = 1:nx
        u(i,1) = uy0(x(i),t);
        u(i,ny) = uymax(x(i),t);
    end
    for i = 1:ny
        u(1,i) = ux0(y(i),t);
        u(nx,i) = uxmax(y(i),t);
    end
    
    if (step == n1)
        
        ue = zeros(ny,nx);
        for i = 1:ny
            for j=1:nx
                ue(i,j) = Temp(x(i),y(j),t);
            end
        end
            
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
        
        ue = zeros(ny,nx);
        for i = 1:ny
            for j=1:nx
                ue(i,j) = Temp(x(i),y(j),t);
            end
        end
            
        time=num2str(t);
        subplot(2,2,3)
        contour(X,Y,u')
        hold on
        contour(X,Y,ue','--')
        axis ('equal')
        xlabel('x')
        ylabel('y')
        title(strcat('t = ',time))

    end
end

% Plot Final step

ue = zeros(nx,ny);
for i = 1:nx
    for j=1:ny
        ue(i,j) = Temp(x(i),y(j),t);
    end
end
            
time=num2str(t);
subplot(2,2,4)
contour(X,Y,u')
hold on
contour(X,Y,ue','--')
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
    s = 0;%exp(-2*pi*pi*t)*sin(pi*x)*sin(pi*y);
end

