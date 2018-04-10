function [] = rotate_to_deg(motor, deg)

    start(motor);
    while(abs(readRotation(motor)) > deg)
        stop(motor);
    end
    resetRotation(motor);
end