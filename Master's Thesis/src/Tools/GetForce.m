function F = GetForce(distrib, r)
    
    global eps;

    phi0 = GetPotential(distrib, r);
    phi1 = GetPotential(distrib, r + eps);
    gradientvector = gradient([phi0, phi1]);
    F = -gradientvector(1)/eps;

end