function phi = ConstantDiskPotential(r)
    
    global G;
    global GalaxyRadius;
    global rho0;
    
    a = GalaxyRadius;
    n2 = 4*a*r./(a+r).^2;
    [K,E] = ellipke(sqrt(n2));
    phi = -2*G*rho0*((a+r).*E + (a-r).*K);
    
end
