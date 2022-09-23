function z = SurfPlot(p,t,phi)
    figure()
    pdesurf(p,t,phi)
    title('Representación de la superficie del potencial gravitatorio')
    xlabel('Componente x')
    ylabel('Componente y')
    zlabel('Potencial gravitatorio \phi')
end