function k = Kappa(x,y)

    global SmallRadius;
    global LargeRadius;
    global KappaIn;
    global KappaOut;
    global epsIn;
    global epsOut;
    
    [~, r] = cart2pol(x,y);
    
    k = 0;
    
    if r >= LargeRadius - epsOut
        k = KappaOut;
    elseif r <= SmallRadius + epsIn
        k = KappaIn;
    end
    
end