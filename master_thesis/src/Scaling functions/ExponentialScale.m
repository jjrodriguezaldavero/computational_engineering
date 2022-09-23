function s = ExponentialScale(r)
    global SmallRadius;
    global LargeRadius;
    %global NR;

    a = LargeRadius;
    b = SmallRadius;
    
    s = b*(a/b).^(r/LargeRadius);
    
end