function phi = GetPotential(distrib, r)

    if isequal(distrib, 'constant')
        phi = ConstantDiskPotential(r);
    elseif isequal(distrib, 'kuzmin')
        phi = KuzminDiskPotential(r);
    elseif isequal(distrib, 'mestel')
        phi = MestelDiskPotential(r);
    elseif isequal(distrib, 'exponential')
        phi = ExponentialDiskPotential(r);
    end

end