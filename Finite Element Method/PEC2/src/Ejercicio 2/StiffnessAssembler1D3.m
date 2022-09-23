function C = StiffnessAssembler1D3(x)
n = length(x)-1;
C = zeros(n+1,n+1);
for i = 1:n
h = x(i+1) - x(i);
xdelta = (x(i+1) - x(i)); % interval
factor = xdelta^2 / (2*h^2);
C(i,i) =  1*factor;
C(i,i+1) = -1*factor;
C(i+1,i) = -1*factor;
C(i+1,i+1) = 1*factor;
end