function [t,y] = ode_euler(f,tspan,y0,h)
%Resuelve la EDO y’(t) = f(t,y(t)) mediante el método de Euler para
%tspan = [t0,tf], con condiciones iniciales y0 y paso h.
N = (tspan(2) - tspan(1))/h; %paso
t = tspan(1)+[0:N]'*h;
y(1,:) = y0(:)';
for k = 1:N
y(k + 1,:) = y(k,:) +h*feval(f,t(k),y(k,:)); %Eq.(6.1.7) de la bibliografía
end