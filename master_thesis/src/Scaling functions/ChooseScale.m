function scale = ChooseScale(s)
    if isequal(s, 'exponential')
        scale = @ExponentialScale;
    elseif isequal(s, 'linear')
        scale = @LinearScale;
    else
        scale = @LinearScale;
    end
end