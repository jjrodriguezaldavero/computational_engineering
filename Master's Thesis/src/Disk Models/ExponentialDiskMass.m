function rho = ExponentialDiskMass(r)

    global GalaxyRadius;
    global rho0;
    
    alpha = 1/GalaxyRadius;
    rho = rho0*exp(-alpha*r);
    
end