function z = gD(x,y)

    global SmallRadius;
    global LargeRadius;
    global gDIn;
    global gDOut;
    global eps;
    
    [~, r] = cart2pol(x,y);
    
    z = 0;
    
    if r >= LargeRadius - eps
        z = gDOut;
    elseif r <= SmallRadius + eps
        z = gDIn;
    end
    
end