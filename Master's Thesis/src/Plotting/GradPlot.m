function z = GradPlot(p,e,t,phi)
    
    global GalaxyRadius;
    figure()
    [phix,phiy] = pdegrad(p,t,phi); % derivatives of ’phi’
     u = phix';
     v = phiy';
     pdeplot(p,e,t,'flowdata',[u v])
     hold on
     circle(0,0,GalaxyRadius, 'b');
     legend('Fuerza gravitatoria','Radio galáctico')
     title('Campo gravitatorio en el plano del disco')
     xlabel('Componente x')
     ylabel('Componente y')
end