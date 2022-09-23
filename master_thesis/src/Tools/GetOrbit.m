function [SOL1, SOL2, T] = GetOrbit(p, phi)

    global NT;
    global t;
    global Nt;
    global R0;
    global TH0;
    global Rg0;
    global THg0;
    
    %Compute the radial potential
    indices = [1:numel(phi)];
    indices_r = find(mod(indices, NT)==0);
    rv = p(1,indices_r);
    phi_r = phi(indices_r);
    
    %Compute the gradient of the radial potential
    gv = gradient(phi_r); %Discrete
    G = @(x)interp1(rv(:), gv(:), x); %Continuous interpolation
    
    %Define the system of ODEs for the radius
    Lz = R0^2*THg0;
    EqnsR = @(t,r,rv,gv) [r(2); -G(r(1)) + Lz^2/r(1)^3];
    tspan = linspace(0, t, Nt); %Time array
    T = tspan';
    ic1 = [R0; Rg0]; %Initial conditions
    
    %Solve the system of ODEs for the radius
    [~, SOL1] = ode45(@(t,r)EqnsR(t,r,rv,gv), tspan, ic1);

    %Define the system of ODEs for theta
    R = @(t)interp1(tspan, SOL1(:,1), t); %Continuous interpolation of the time evolution of R
    EqnsTH = @(t,theta)[Lz/R(t)^2];
    ic2 = TH0;

    %Solve the system of ODEs for theta
    [~, SOL2] = ode45(@(t,theta)EqnsTH(t,theta), tspan, ic2);
 
