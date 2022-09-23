function ComparisonPlot(phi)

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
    plot(xr, radialphi)
    xline(GalaxyRadius, '-', {'Radio', 'galáctico'});
        hold on
    
    x = linspace(SmallRadius, LargeRadius, 1000);    
       
    if isequal(distrib, 'constant')
        plot(x, ConstantDiskPotential(x))
        
    elseif isequal(distrib, 'mestel')
        plot(x, MestelDiskPotential(x))
        
    elseif isequal(distrib, 'kuzmin')
        plot(x, KuzminDiskPotential(x))
        
    elseif isequal(distrib, 'exponential')
        plot(x, ExponentialDiskPotential(x))
    end
    
    title('Comparación entre el potencial analítico y el simulado')
    legend('Simulado','Analítico')
    xlabel('Radio r')
    ylabel('Potencial gravitatorio \phi')

end