%Resolvemos el apartado f del problema
df = 'df123';
t0 = 0; tf = 10; h = 0.05;
y01 = [1 0]; [tR4,yR4] = ode_RK4(df,[t0 tf],y01,h);
y02 = [1 1]; [tR5,yR5] = ode_RK4(df,[t0 tf],y02,h);
y03 = [0 1]; [tR6,yR6] = ode_RK4(df,[t0 tf],y03,h);

%Representamos las trayectorias para las tres condiciones iniciales
figure(1)
hold on
plot(tR4,yR4); 
plot(tR5,yR5);
plot(tR6,yR6);
xlabel('Tiempo t')
ylabel('Solución y(t)')
legend('y0=[1 0] A','y0=[1 0] B','y0 = [1 1] A','y0=[1 1] B','y0=[0 1] A','y0 = [0 1] B')