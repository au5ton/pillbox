% only responsible for putting the motor `m` back to 0
function [] = rotate_back_to_zero(m, velocity)
    m.Speed = velocity;
    if readRotation(m) > 0
        m.Speed = -1 * abs(velocity);
        start(m);
        % basically stop at 0
        while(readRotation(m) > 10)
            % do nothing until while is broken
        end
    end
    stop(m);
end