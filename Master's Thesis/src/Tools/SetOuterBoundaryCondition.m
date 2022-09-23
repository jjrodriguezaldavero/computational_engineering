function SetOuterBoundaryCondition()

    global LargeRadius;
    global distrib;
    global BCOut;
    global ValueOut;
    global KappaOut;
    global KappaOutVal;
    global gNOut;
    global gDOut;

    if isequal(BCOut, 'neumann')
    %Resumen: si Dirichlet exterior, kappa grande y gD igual al valor
    %Si von Neumann interior zero, kappa 0 y gN igual a 1
    
        if isequal(ValueOut, -1)
            gNOut = GetForce(distrib, LargeRadius);
        else
            gNOut = ValueOut;
        end
    
    elseif isequal(BCOut, 'dirichlet')

        KappaOut = KappaOutVal;
        if isequal(ValueOut, -1)
            gDOut = GetPotential(distrib, LargeRadius);
        else
            gDOut = ValueOut;
        end
    end
    
end