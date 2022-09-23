function rho = ConstantDiskMass(r)
    global GalaxyRadius;
    global SmallRadius;
    global rho0;
    
    if r >= SmallRadius & r <= GalaxyRadius
        rho = rho0;
    else
        rho = 0;
    end
end