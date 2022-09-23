function SetConfig()

%% Mesh Variables
    
    global GalaxyRadius;
        GalaxyRadius = 1;
    global LargeRadius;
        LargeRadius = 10;
    global SmallRadius;
        SmallRadius = 1E-6;
        
    global NR;
        NR = 2^7;
    global NT;
        NT = 2^7;
        
    global Scale;
        Scale = 'linear';
        %Scale = 'exponential';

    global eps;
        eps = LargeRadius / NR;
        
%% Model Variables

    global distrib;
        %distrib = 'constant';
        distrib = 'kuzmin';
        %distrib = 'mestel';
        %distrib = 'exponential';
        
    global G;
        G = 1;
    global rho0; %Constant and exponential
        rho0 = 1;
    global M; %Kuzmin
        M = 1;
    global alpha; %Mestel
        alpha = 1;
        
%% Boundary Condition Variables

    global BCIn;
        BCIn = 'dirichlet';
        %BCIn = 'neumann';
    global ValueIn;
        ValueIn = -1;
        
    global BCOut;
        BCOut = 'dirichlet';
        %BCOut = 'neumann';
    global ValueOut;
        ValueOut = -1;
        
    %Calibration
    global epsIn;
        epsIn = 1*eps;
    global epsOut;
        epsOut = 1*eps;
    global KappaInVal;
        KappaInVal = 1E6;
    global KappaOutVal;
        KappaOutVal = 1E6;
        
%% Orbit Variables

    global t;
        t = 100;
    global Nt;
        Nt = 1E4;

    %Initial conditions for the orbit
    global R0;
        R0 = 4.5;
    global TH0;
        TH0 = 1;
    global Rg0;
        Rg0 = -1;
    global THg0;
        THg0 = 0.1;
        
%% Initialization Variables (ignore)
    global KappaIn;
        KappaIn = 0;
    global KappaOut;
        KappaOut = 0;
    global gDIn;
        gDIn = 0;
    global gDOut;
        gDOut = 0;
    global gNIn;
        gNIn = 0;
    global gNOut;
        gNOut = 0;
end