function y = segunda_aprox(x0,h)
format long;
y = (-25*fun(x0) + 48*fun(x0+h) - 36*fun(x0+2*h) + 16*fun(x0+3*h) - 3*fun(x0+4*h))/(12*h);
end