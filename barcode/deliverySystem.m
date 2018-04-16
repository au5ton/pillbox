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
    conveyor_speed = 40;
    pick_speed = 60;
    resetRotation(conveyor); % conveyor should be 0 at starting position

    % process inventory into a queue for the conveyor to travel to
    queue = master_to_slots(master);
    disp(queue);

    % traverse the queue
    for i = 1:length(queue)
        pop_slot(conveyor, pick, conveyor_speed, pick_speed, queue(i));
    end
end








