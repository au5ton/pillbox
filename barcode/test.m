

while(true)
    disp(readRotation(m))
end

% TODO: test rotate_back_to_zero

function [] = rotate_back_to_zero(m, velocity)
    m.Speed = velocity;
    if readRotation(m) > 0
        m.Speed = -1 * abs(velocity);
        start(m);
        while(~(readRotation(m) > 0))
            stop(m);
        end
    elseif readRotation(m) < 0
        m.Speed = abs(velocity);
        start(m)
        while(~(readRotation(m) < 0))
            stop(m);
        end
    else
        stop(m);
    end
end