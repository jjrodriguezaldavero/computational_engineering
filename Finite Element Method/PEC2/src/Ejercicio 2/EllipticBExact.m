function y = EllipticBExact(x)
y = 0.25*(-1 -2*x + exp(-2*x).*(exp(2)*(exp(1)-6)+2*exp(3*x)*(1+3*exp(1)^2))/(2+exp(1)^3));