function EllipticSolverA1D()
h = 0.01; % mesh size
x = 0:h:1; % mesh
k = 1.e+3;
kappa = [k k];
g = [0 0];
A = StiffnessAssembler1D(x, @UnitFunction, kappa);
B = StiffnessAssembler1D2(x);
b = SourceAssembler1D(x, @SourceEllipticA, kappa, g);
u = (A+B)\b;
plot(x,u,x,EllipticAExact(x))