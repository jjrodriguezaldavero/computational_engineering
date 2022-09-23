function EllipticSolverB1D()
h = 0.01; % mesh size
x = 0:h:1; % mesh
kappa = [1.e+8 1.e-8];
g = [1/kappa(1) -1/kappa(2)];
A = StiffnessAssembler1D(x, @UnitFunction, kappa+[-1 -0.6]); %A is prepared for functions of x
B = StiffnessAssembler1D2(x);
C = StiffnessAssembler1D3(x);
b = SourceAssembler1D(x, @SourceEllipticB, kappa, g);
u = (-A-2*B-C)\b;
plot(x,u,x,EllipticBExact(x))