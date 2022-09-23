function B = StiffnessAssembler1D2(x)
n = length(x)-1;
B = zeros(n+1,n+1);
for i = 1:n
h = x(i+1) - x(i);
xdelta = (x(i+1) - x(i)); % interval
factor = xdelta^3 / (6*h^2);
B(i,i) = 4*factor;
B(i,i+1) = factor;
B(i+1,i) = factor;
B(i+1,i+1) = 4*factor;
end