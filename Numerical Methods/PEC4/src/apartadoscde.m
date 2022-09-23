%Resolvemos el apartado c) del problema
df = 'df123';
t0 = 0; tf = 10; y0 = [1 0];
h1 = 0.01; [tR1,yR1] = ode_RK4(df,[t0 tf],y0,h1);
h2 = 0.05; [tR2,yR2] = ode_RK4(df,[t0 tf],y0,h2);
h3 = 0.025; [tR3,yR3] = ode_RK4(df,[t0 tf],y0,h3);

solR1 = [yR1(1/h1,1) yR1(5/h1,1) yR1(10/h1,1) yR1(1/h1,2) yR1(5/h1,2) yR1(10/h1,2)];
solR2 = [yR2(1/h2,1) yR2(5/h2,1) yR2(10/h2,1) yR2(1/h2,2) yR2(5/h2,2) yR2(10/h2,2)];
solR3 = [yR3(1/h3,1) yR3(5/h3,1) yR3(10/h3,1) yR3(1/h3,2) yR3(5/h3,2) yR3(10/h3,2)];
%Resolvemos el apartado d) del problema representando las soluciones
figure(1)
hold on
plot(tE1,yE1(:,1)); 
plot(tE2,yE2(:,1));
plot(tE3,yE3(:,1));
plot(tR1,yR1(:,1));
xlabel('Tiempo t')
ylabel('Solución y(t)')
legend('h=0.01','h=0.05','h=0.025','h=0.01 RK4')
%Resolvemos el apartado e)
figure(2)
hold on
plot(tR1,yR1);
plot(tR2,yR2);
plot(tR3,yR3);
xlabel('Tiempo t')
ylabel('Solución y(t)')
legend('h=0.01 A', 'h=0.01 B', 'h=0.05 A', 'h=0.05 B', 'h=0.025 A', 'h=0.025 B')