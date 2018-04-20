function [] = colorChecker(brick)
    %conveyor = motor(brick,'C');
    %pick = motor(brick,'D');
    colorMarble = colorSensor(brick,1);
    
    %resetRotation(conveyor);
    %resetRotation(pick);
    h = [0 0 0];
    while(true)
        c = readColorRGB(colorMarble);
        h(1) = max([c(1) h(1)]);
        h(2) = max([c(2) h(2)]);
        h(3) = max([c(3) h(3)]);
        fprintf('rc: %d, gc: %d, bc: %d, rh: %d, gh: %d, bh: %d\n', c(1), c(2), c(3), h(1), h(2), h(3));
    end

end