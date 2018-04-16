function [] = rotationChecker(brick)

    conveyor = motor(brick,'A');
    pick = motor(brick,'B');

    while(true)
        fprintf('rot_A = %d ; rot_B = %d\n',readRotation(conveyor),readRotation(pick));
    end

end