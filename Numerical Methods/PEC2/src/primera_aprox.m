function y = primera_aprox(x0,h)
format long;
y = (fun(x0 + h) - fun(x0))/h;
end