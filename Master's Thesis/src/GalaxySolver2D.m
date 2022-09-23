function GalaxySolver2D()

    %Initialize configuration
    SetConfigConstantCloseDD()
      
    %Create the circular symmetric mesh and compute its matrices
    showplot = 'false';
    [p,e,t] = CircularMesh(showplot);

    %Define the boundary conditions
    SetInnerBoundaryCondition()
    SetOuterBoundaryCondition()

    %Build the objects for FEM to work
    A = StiffnessAssembler2D(p,t,@NonLinearTerm);
    b = LoadAssembler2D(p,t,@MassTerm);
    R = RobinMassMatrix2D(p,e,@Kappa);
    r = RobinLoadVector2D(p,e,@Kappa,@gD,@gN);
    
    %Compute the gravitational potential
    phi = (A+R)\(b+r);
    
%     %Check results accuracy by plotting against analytical solution
    ComparisonPlot(phi);
%     ErrorPlot(phi);
%     
%     %Plot some quantities of interest
%     SurfPlot(p,t,phi)
%     GradPlot(p,e,t,phi)
%     ContourPlot(p,t,phi)

    %Plot orbit
%     time_plot = 'false';
%     OrbitPlot(p, phi, time_plot);

end