function OrbitPlot(p, phi, time_plot)

    global GalaxyRadius;

    [SOL1, SOL2, T] = GetOrbit(p, phi);

    if isequal(time_plot, 'true')
        figure()
        plot(T, SOL1)
        title('Evolución temporal del radio y la velocidad')
        legend('Radio','Velocidad')
        xlabel('Tiempo t')
        ylabel('Valor')

        figure()
        plot(T, SOL2)
        title('Evolución temporal de la coordenada angular')
        xlabel('Tiempo t')
        ylabel('Ángulo \theta')
    end

    figure()
    [X,Y] = pol2cart(SOL2, SOL1(:,1));
    plot(X,Y)
    title('Representación de la órbita')
    xlabel('Coordenada x')
    ylabel('Coordenada y')
    
    hold on
    [x0, y0] = pol2cart(SOL2(1), SOL1(1,1));
    plot(x0,y0,'*')
    hold on
    circle(0,0,GalaxyRadius, 'r');
    hold on
    plot(0,0,'*')
    
    legend('Órbita','Posición inicial', 'Radio galáctico', 'Centro galáctico')
end