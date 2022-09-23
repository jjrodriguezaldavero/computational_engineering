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
par1 = rho / (1 + 2*rho);
par2 = (2*rho - 1)/rho;

fprintf('nsteps, n1, n2 = %d,%d,%d\n',nsteps, n1, n2)
fprintf('ht, tf = %f,%f\n',ht,tf)
fprintf('rho, par1, par2 = %f, %f, %f\n',rho,par1,par2)
fprintf('ndx, ndy = %d, %d\n', ndx, ndy)

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

    t = t + ht;
    u1 = zeros(ny,nx);
    
    % Set the boundary conditons on the mesh edges

    for i = 1:nx
        u1(i,1) = uy0(x(i),t);
        u1(i,ny) = uymax(x(i),t);
    end
    for i = 1:ny
        u1(1,i) = ux0(y(i),t);
        u1(nx,i) = uxmax(y(i),t);
    end
    
    for i = 2:ndx
        for j = 2:ndy
            u1(i,j) = par1 * (u1(i-1,j)+u1(i,j-1)+u(i+1,j)+u(i,j+1)-...
                par2*u(i,j));
        end
    end

    step = step + 1;
    
    t = t + ht;
    u = zeros(nx,ny);
    
    % Set the boundary conditons on the mesh edges

    for i = 1:nx
        u(i,1) = uy0(x(i),t);
        u(i,ny) = uymax(x(i),t);
    end
    for i = 1:ny
        u(1,i) = ux0(y(i),t);
        u(nx,i) = uxmax(y(i),t);
    end
    
    for j = ndy:-1:2
        for i = ndx:-1:2
            u(i,j) = par1*(u(i+1,j)+u(i,j+1)+u1(i-1,j)+u1(i,j-1)-... 
                par2*u1(i,j));
        end
    end

    step = step + 1;

    if (step == n1)
        
        ue = zeros(nx,ny);
        for i = 1:nx
            for j=1:ny
                ue(i,j) = Temp(x(i),y(j),t);
            end
        end
            
        time=num2str(t);
        subplot(2,2,2)
        contour(X,Y,u')
        hold on
        contour(X,Y,ue','--')
        axis ('equal')
        xlabel('x')
        ylabel('y')
        title(strcat('t = ',time))
    end
    if (step == n2)
        
        ue = zeros(nx,ny);
        for i = 1:nx
            for j=1:ny
                ue(i,j) = Temp(x(i),y(j),t);
            end
        end
            
        time=num2str(t);
        subplot(2,2,3)
        contour(X,Y,u')
        hold on
%        contour(X,Y,ue','--')
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
    s = 0;
end

