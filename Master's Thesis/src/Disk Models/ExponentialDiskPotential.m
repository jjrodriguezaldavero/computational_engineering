function phi = ExponentialDiskPotential(r)

    global G;
    global rho0;
    global GalaxyRadius;
    
    alpha = 1/GalaxyRadius;
    x = alpha*r/2;
    phi = pi*G*ExponentialDiskMass(0)*x.*(besseli(1, x).*besselk(0, x) - besseli(0, x).*besselk(1, x));
    
end