% only responsible for taking in the motors and speeds, ...
% ...navigating to the `deg` degrees, calling kick_marble(), and resetting the arm back to the start
function [] = pop_slot(conveyor, pick, con_v, pick_v, deg)

    % ASSUMES THAT THE CONVEYOR IS ALREADY AT ZERO

    conveyor.Speed = abs(con_v);
    start(conveyor);
    % readRotation should be around 0, going up to N degrees
    while(readRotation(conveyor) < deg)
        stop(conveyor);
    end
    pause(1); % wait before kicking because fuck it
    kick_marble(pick, pick_v);
    rotate_back_to_zero();
end