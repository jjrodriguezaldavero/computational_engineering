%Resolvemos el apartado a) del problema
df = 'df123';
t0 = 0; tf = 10; y0 = [1 0];
h1 = 0.01; [tE1,yE1] = ode_euler(df,[t0 tf],y0,h1);
h2 = 0.05; [tE2,yE2] = ode_euler(df,[t0 tf],y0,h2);
h3 = 0.025; [tE3,yE3] = ode_euler(df,[t0 tf],y0,h3);

solE1 = [yE1(1/h1,1) yE1(5/h1,1) yE1(10/h1,1) yE1(1/h1,2) yE1(5/h1,2) yE1(10/h1,2)];
solE2 = [yE2(1/h2,1) yE2(5/h2,1) yE2(10/h2,1) yE2(1/h2,2) yE2(5/h2,2) yE2(10/h2,2)];
solE3 = [yE3(1/h3,1) yE3(5/h3,1) yE3(10/h3,1) yE3(1/h3,2) yE3(5/h3,2) yE3(10/h3,2)];
%Resolvemos el apartado b) del problema representando las soluciones
hold on
plot(tE1,yE1(:,1)); 
plot(tE2,yE2(:,1));
plot(tE3,yE3(:,1));
xlabel('Tiempo t')
ylabel('Solución y(t)')
legend('h=0.01','h=0.05','h=0.025')