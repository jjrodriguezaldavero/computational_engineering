function EllipticSolverB1D()
h = 0.01; % mesh size
x = 0:h:1; % mesh
kappa = [1.e+8 0];
g = [0 -1/kappa(2)];
A = StiffnessAssembler1D(x, @UnitFunction, kappa+[1 1]); %A is prepared for functions of x
B = StiffnessAssembler1D2(x);
C = StiffnessAssembler1D3(x);
unit = [1 1];
nu = [0 1];
b = SourceAssembler1D(x, @SourceEllipticB, +unit, nu);
u = (-A-2*B-C)\b;
plot(x,u,x,EllipticBExact(x))