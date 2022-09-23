function ContourPlot(p,t,phi)

    global GalaxyRadius;

    figure()
    pdecont(p,t,phi)
    hold on
    circle(0,0,GalaxyRadius, 'r');
    legend('Potencial gravitatorio','Radio gal�ctico')
    title('L�neas de contorno del potencial gravitatorio')
    xlabel('Componente x')
    ylabel('Componente y')
end