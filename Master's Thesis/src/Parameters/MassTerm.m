function f = MassTerm(x,y,distrib)

    global G;
    
    [~, r] = cart2pol(x,y);

    if isequal(distrib, 'constant')
        f=-4*pi*G*ConstantDiskMass(r);
    elseif isequal(distrib, 'mestel')
        f=-4*pi*G*r*MestelDiskMass(r);
    elseif isequal(distrib, 'kuzmin')
        f=-4*pi*G*r*KuzminDiskMass(r);
    elseif isequal(distrib, 'exponential')
        f=-4*pi*G*r*ExponentialDiskMass(r);
    end
    
end