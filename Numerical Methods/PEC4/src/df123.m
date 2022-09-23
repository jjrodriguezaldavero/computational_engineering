function dx = df123(t,x) %Definimos la función del problema
dx = zeros(size(x));
dx(1) = -(x(1))^2 + x(2); dx(2) = (x(1))^2 -2*x(2);