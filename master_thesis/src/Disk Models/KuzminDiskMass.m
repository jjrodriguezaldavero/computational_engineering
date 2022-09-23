function rho = KuzminDiskMass(r)

    global GalaxyRadius;
    global M;
    
    a = GalaxyRadius;
    rho = M*a./(2*pi*(r^2 + a^2).^1.5);
    
end