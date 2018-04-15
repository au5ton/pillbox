% By submitting this assignment, I agree to the following:
%  �Aggies do not lie, cheat, or steal, or tolerate those who do�
%  �I have not given or received any unauthorized aid on this assignment�
% 
% Name: Austin Jackson
% Section:	112-542
% Assignment: Engineering Projectc
% Date:	29 January

keySet = {'red_big','red_small','blue_big','blue_small','white_big','white_small','steel','hdpe'};
valueSet = [1 * 360, 2 * 360, 3 * 360, 4 * 360, 5 * 360, 6 * 360, 7 * 360, 8 * 360];
MARBLES = containers.Map(keySet,valueSet);
% MARBLES('blue_big') => (3 * 360)

main();

function [] = main()
    % prepare some variables
    brick = legoev3('USB');
    conveyor = motor(brick,'A');
    pick = motor(brick,'B');
    conveyor_speed = 40;
    pick_speed = 60;
    resetRotation(conveyor); % conveyor should be 0 at starting position

    % process inventory into a queue for the conveyor to travel to
    queue = master_to_slots(master);

    % traverse the queue
    for i = 1:length(queue)
        pop_slot(conveyor, pick, conveyor_speed, pick_speed, queue(i));
    end
end

function [slots] = master_to_slots(master)

    % for every row in master
    for r = 1:size(master,1)
        % for every column in that row
        for c = 1:size(master, 2)
            % for n amount in that individual cell
            for n = 1:master(r,c)
                % append the cell rotation to the slots queue
                if(r == 1 && c == 1)
                    slots = [slots MARBLES('white_big')];
                end
                if(r == 1 && c == 2)
                    slots = [slots MARBLES('white_small')];
                end
                if(r == 2 && c == 1)
                    slots = [slots MARBLES('red_big')];
                end
                if(r == 2 && c == 2)
                    slots = [slots MARBLES('red_small')];
                end
                if(r == 3 && c == 1)
                    slots = [slots MARBLES('blue_big')];
                end
                if(r == 3 && c == 2)
                    slots = [slots MARBLES('blue_small')];
                end
                if(r == 4 && c == 1)
                    slots = [slots MARBLES('steel')];
                end
                if(r == 4 && c == 2)
                    slots = [slots MARBLES('hdpe')];
                end
            end
        end
    end

    % fprintf('RED big = %d \n',master(2,1));
    % fprintf('RED small = %d \n',master(2,2));
    % fprintf('BLUE big = %d \n',master(3,1));
    % fprintf('BLUE small = %d \n',master(3,2));
    % fprintf('WHITE big = %d \n',master(1,1));
    % fprintf('WHITE small = %d \n',master(1,2));
    % fprintf('STEEL = %d \n',master(4,1));
    % fprintf('HDPE = %d \n',master(4,2));
end


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

% only responsible for performing a kicking motion
function [] = kick_marble(m, speed)
    m.Speed = abs(speed);
    start(m);
    pause(0.25);
    stop(m);
    pause(1);
    m.Speed = -1 * abs(speed);
    start(m);
    pause(0.25);
    stop(m);
end

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