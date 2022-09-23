function phi = KuzminDiskPotential(r)

    global G;
    global M;
    global GalaxyRadius;
    
    a = GalaxyRadius;
    phi = -G*M./sqrt(r.^2 + a^2);
    
end