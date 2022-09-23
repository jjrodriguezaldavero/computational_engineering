function z = gN(x,y)

    global SmallRadius;
    global LargeRadius;
    global gNIn;
    global gNOut;
    global eps;
    
    [~, r] = cart2pol(x,y);
    
    z = 0;
    
    if r >= LargeRadius - eps
        z = gNOut;
    elseif r <= SmallRadius + eps
        z = gNIn;
    end
    
end