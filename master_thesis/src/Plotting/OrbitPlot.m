function OrbitPlot(p, phi, time_plot)

    global GalaxyRadius;

    [SOL1, SOL2, T] = GetOrbit(p, phi);

    if isequal(time_plot, 'true')
        figure()
        plot(T, SOL1)
        title('Evoluci�n temporal del radio y la velocidad')
        legend('Radio','Velocidad')
        xlabel('Tiempo t')
        ylabel('Valor')

        figure()
        plot(T, SOL2)
        title('Evoluci�n temporal de la coordenada angular')
        xlabel('Tiempo t')
        ylabel('�ngulo \theta')
    end

    figure()
    [X,Y] = pol2cart(SOL2, SOL1(:,1));
    plot(X,Y)
    title('Representaci�n de la �rbita')
    xlabel('Coordenada x')
    ylabel('Coordenada y')
    
    hold on
    [x0, y0] = pol2cart(SOL2(1), SOL1(1,1));
    plot(x0,y0,'*')
    hold on
    circle(0,0,GalaxyRadius, 'r');
    hold on
    plot(0,0,'*')
    
    legend('�rbita','Posici�n inicial', 'Radio gal�ctico', 'Centro gal�ctico')
end