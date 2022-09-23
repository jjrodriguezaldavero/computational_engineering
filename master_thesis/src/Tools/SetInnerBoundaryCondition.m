function SetInnerBoundaryCondition()

    global SmallRadius;
    global distrib;
    global BCIn;
    global ValueIn;
    global KappaIn;
    global KappaInVal;
    global gNIn;
    global gDIn;
    
    if isequal(BCIn, 'neumann')
    %Resumen: si Dirichlet exterior, kappa grande y gD igual al valor
    %Si von Neumann interior zero, kappa 0 y gN igual a 1
    
        if isequal(ValueIn, -1)
            gNIn = GetForce(distrib, SmallRadius);
        else
            gNIn = ValueIn;
        end
    
    elseif isequal(BCIn, 'dirichlet')

        KappaIn = KappaInVal;
        if isequal(ValueIn, -1)
            gDIn = GetPotential(distrib, SmallRadius);
        else
            gDIn = ValueIn;
        end
    end
        
end