function ErrorPlot(phi)

    global LargeRadius;
    global SmallRadius;
    global GalaxyRadius;
    global Scale;
    global distrib;
    global NR;
    
    indices = [1:numel(phi)];
    radialindices = find(mod(indices, NR)==0);
    radialphi = phi(radialindices);
    
    scale = ChooseScale(Scale);
    xr = linspace(SmallRadius, LargeRadius, numel(radialindices));
    xr = scale(xr);
    
    figure()  
    
    if isequal(distrib, 'constant')
        plot(xr, radialphi' - ConstantDiskPotential(xr))
        
    elseif isequal(distrib, 'mestel')
        plot(xr, radialphi' - MestelDiskPotential(xr))
        
    elseif isequal(distrib, 'kuzmin')
        plot(xr, radialphi' - KuzminDiskPotential(xr))
        
    elseif isequal(distrib, 'exponential')
        plot(xr, radialphi' - ExponentialDiskPotential(xr))
    end
    
    xline(GalaxyRadius, '-', {'Radio', 'galáctico'});
    title('Error entre el potencial analítico y el simulado')
    xlabel('Radio r')
    ylabel('Potencial gravitatorio \phi')

end