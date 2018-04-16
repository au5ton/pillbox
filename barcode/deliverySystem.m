% By submitting this assignment, I agree to the following:
%  �Aggies do not lie, cheat, or steal, or tolerate those who do�
%  �I have not given or received any unauthorized aid on this assignment�
% 
% Name: Austin Jackson
% Section:	112-542
% Assignment: Engineering Projectc
% Date:	29 January

% example master: master = [1 1; 0 1; 1 1; 0 1];
% example call: deliverySystem(master)

function [] = deliverySystem(master)
    % prepare some variables
    brick = legoev3('USB');
    conveyor = motor(brick,'A');
    pick = motor(brick,'B');
    touch = touchSensor(brick);
    conveyor_speed = 40;
    pick_speed = 60;
    resetRotation(conveyor); % conveyor should be 0 at starting position
    resetRotation(pick);

    % process inventory into a queue for the conveyor to travel to
    queue = master_to_slots(master);
    disp(queue);

    % traverse the queue
    for i = 1:length(queue)
        disp(['queue item: ' num2str(i) ', travel to: ' num2str(queue(i))]);
        if(readTouch(touch))
            stop(conveyor);
            stop(pick);
            return
        end
        % pop_slot.m
        conveyor.Speed = abs(conveyor_speed);
        start(conveyor);
        % readRotation should be around 0, going up to N degrees
        while(readRotation(conveyor) < queue(i))
            if(readTouch(touch))
                stop(conveyor);
                stop(pick);
                return
            end
        end
        stop(conveyor);
        pause(1); % wait before kicking because fuck it
        
        % kick_marble.m begin
        pick_rot_distance = 60;
        if(queue(i) > 460)
            pick.Speed = 60;
        else
            pick.Speed = 55;
        end
        start(pick);
        while(readRotation(pick) < pick_rot_distance)
            % do nothing
        end
        stop(pick);
        pause(1)
        pick.Speed=-15;
        start(pick);
        while(readRotation(pick) > 0)
            % do nothing
        end
        stop(pick)
        % kick_marble.m end
        % rotate_back_to_zero.m begin
        conveyor.Speed = conveyor_speed;
        if readRotation(conveyor) > 0
            conveyor.Speed = -1 * abs(conveyor_speed);
            start(conveyor);
            % basically stop at 0
            while(readRotation(conveyor) > 0)
                % do nothing until while is broken
                if(readTouch(touch))
                    stop(conveyor);
                    stop(pick);
                    return
                end
            end
        end
        stop(conveyor);
        % rotate_back_to_zero.m end

    end
    disp('finished with queue');
end








