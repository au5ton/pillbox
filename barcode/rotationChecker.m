function [] = rotationChecker(brick)
    conveyor = motor(brick,'B');
    pick = motor(brick,'D');
    colorMarble = colorSensor(brick,1);
    
    resetRotation(conveyor);
    resetRotation(pick);
    while(true)
        c = readColorRGB(colorMarble);
        fprintf('rot_B = %d ; rot_B = %d; red: %d, green: %d, blue: %d\n',readRotation(conveyor),readRotation(pick), c(1), c(2), c(3));
    end

end