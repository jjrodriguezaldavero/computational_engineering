function [t,y] = ode_RK4(f,tspan,y0,h,varargin)
%Resuelve la ecuación diferencial y’(t) = f(t,y(t)) mediante el método
%Runge-Kutta de orden 4 para tspan = [t0,tf], con condiciones iniciales y0
%y paso h.
y(1,:) = y0(:)';
N = (tspan(2) - tspan(1))/h; 
t = tspan(1)+[0:N]'*h;

for k = 1:N
f1 = h*feval(f,t(k),y(k,:)); f1 = f1(:)'; %(6.3.2a)
f2 = h*feval(f,t(k) + h/2,y(k,:) + f1/2); f2 = f2(:)';%(6.3.2b)
f3 = h*feval(f,t(k) + h/2,y(k,:) + f2/2); f3 = f3(:)';%(6.3.2c)
f4 = h*feval(f,t(k) + h,y(k,:) + f3); f4 = f4(:)'; %(6.3.2d)
y(k + 1,:) = y(k,:) + (f1 + 2*(f2 + f3) + f4)/6; %Eq.(6.3.1)
end