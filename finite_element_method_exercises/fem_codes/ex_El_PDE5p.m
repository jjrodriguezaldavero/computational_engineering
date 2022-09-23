% Example of the solution of an Elliptic Partial Differential
% Equation in a rectangular domain using a finite difference 
% scheme of 5 points

% Maximum number of iterations and precison of the solution

maxIter = 500;
tol = 1e-1;

% Set the grid and boundary conditions

% Length of the mesh limits

lx = 1;
ly = 1;
% As we are considering meshes with equal divisions
% the step h, must divide both lx and ly.
h = 0.02;

% Number of divisions per dimension

ndx = lx/h;
ndy = ly/h;

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

x = (xmin:h:xmax);
y = [ymin:h:ymax];

% Set the grid values to zero

u = zeros(ny, nx);

% Set the boundary conditons on the mesh edges

for i = 1:ny
    u(i,1) = ux0(y(i));
    u(i,nx) = uxmax(y(i));
end
for i = 1:nx
    u(1,i) = uy0(x(i));
    u(ny,i) = uymax(x(i));
end

% Set the system matrix. Note that the dimension 
% of the system will be (nx-2)*(ny-2)

nd = nix*niy;
a = zeros(nd,nd);

% Main diagonal.
for i=1:nd
    a(i,i)=4;
end
% Superdiagonal
for j=2:nd
    if (mod(j-1,nix)==0)
        a(j-1,j) = 0;
    else
        a(j-1,j)=-1;
    end
end
% Subdiagonal
for i=2:nd
    if(mod(i-1,nix)==0)
        a(i,i-1)=0;
    else
        a(i,i-1)=-1;
    end
end
% Additional terms
for j=nx-1:nd
    a(j-nx+2,j) = -1;
end
for j=1:nd-nx+2
    a(nx-2+j,j) = -1;
end

% Set the independent term

b = zeros(nd,1);

% First inner row of the mesh (i=2)
for i = 1:nix
    b(i) = u(1,i+1);
end
for i = 1:niy
    b(1+(i-1)*nix) = b(1+(i-1)*nix)+ u(i+1,1);
end
for i = 1:niy
    b(nix+(i-1)*nix) = b(nix+(i-1)*nix)+ u(i+1,nx);
end
% Last inner row of the mesh (i=nix)
for i = 1:nix
    b(nix*(niy-1)+i) = b(nix*(niy-1)+i)+u(ny,i+1);
end

% Solve the Linear system.

% First Approximation

x0 = zeros(nd,1);

% Gauss Seidel Iteration

 [xsol,numIter] = gaussSeidel(x0,a,b,maxIter,tol);
% [xsol,numIter] = jacobi(x0,a,b,maxIter,tol);

if (numIter < maxIter)
    % Reorder the solution on the mesh points
    d = 0;
    for i=1:niy
        for j = 1:nix
            d = d + 1;
            u(i+1,j+1)=xsol(d);
%            fprintf('%d,%d,%d,%f\n',i+1,j+1,d,u(i+1,j+1))
        end
    end

% Plot the 2D solution

    subplot(1,2,1)
    [X,Y] = meshgrid(x,y); 
    surf(X,Y,u)
    subplot(1,2,2)
    contour(X,Y,u)
    xlabel('x')
    ylabel('y')
    title ('Temperature')
    axis equal
    hold on 
    % Plot the Exact Solution
    ue = zeros(ny,nx);
    for i=1:ny
        for j = 1:nx
            ue(i,j)=Temp(x(j),y(i),lx,ly);
        end
    end
    contour(X,Y,ue,'--')
else
    disp('Maximum number of iterations reached. No convergence')
end

% Boundary conditions

% Boundary conditons on the edge y=ymin=0

function y = uy0(x)
%    y = x*x;
    y = sin(3*pi*x);
end

% Boundary conditons on the edge y=ymax

function y = uymax(x)
%    y = (x-1.0)^2;
    y = sin(pi*x);
end

% Boundary conditons on the edge x=xmin=0

function x = ux0(y)
%    x = y*y;
    x = 0;
end

% Boundary conditons on the edge x=xmax

function x = uxmax(y)
%    x = (y-2.0)^2;
    x = 0;
end

% Exact Solution
% The exact solution is an infinte series. We use
% only the first terms.

function s = Temp(x,y,lx,ly)
    s = 0;
    for i=1:2:9
        s = s + 1/(i*sinh(i*pi*ly/lx))*sinh(i*pi*y/lx)*sin(i*pi*x/lx);
    end
    s = s*400/pi;
end

