clear
brick = legoev3('usb');
arm = motor(brick,'D');
gate = motor(brick,'B');
button = touchSensor(brick,2);

resetRotation(arm);
resetRotation(gate);
gate_up_deg = -20; % up position
gate_down_deg = -5; % down position 

while(true)
    deg = input('arm deg: ');
    % gate starts lowered

    % rotate turntable
    arm.Speed = -15;
    start(arm);
    disp('arm moving');
    % basically stop at where it needs to be
    while(readRotation(arm) > deg)
        % do nothing until while is broken
        if(readTouch(button))
            stop(arm);
            stop(gate);
            return
        end
    end
    stop(arm);
    disp('arm stopped');

    % lift the gate
    gate.Speed = -20;
    disp('gate moving');
    start(gate);
    % gate_up_deg is negative
    while(readRotation(gate) > gate_up_deg)
        % do nothing until while is broken
        if(readTouch(button))
            stop(arm);
            stop(gate);
            stop(mixer);
            stop(dispenserMotor);
            return
        end
    end
    stop(gate);
    disp('gate stopped');

    % wait 1 second
    pause(3);

    % lower the gate
    gate.Speed = 20;
    start(gate);
    disp('gate moving');
    % gate_up_deg is negative
    while(readRotation(gate) < gate_down_deg)
        % do nothing until while is broken
        if(readTouch(button))
            stop(arm);
            stop(gate);
            stop(mixer);
            stop(dispenserMotor);
            return
        end
    end
    stop(gate);
    disp('gate stopped');

    % return turntable to reset position
    arm.Speed = 15;
    start(arm);
    disp('arm moving');
    % basically stop at where it needs to be
    while(readRotation(arm) < -1)
        % do nothing until while is broken
        if(readTouch(button))
            stop(arm);
            stop(gate);
            stop(mixer);
            stop(dispenserMotor);
            return
        end
    end
    stop(arm);
    disp('arm stopped');
end