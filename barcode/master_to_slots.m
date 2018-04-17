function [slots] = master_to_slots(master)

    keySet = {'red_big','red_small','blue_big','blue_small','white_big','white_small','steel','hdpe'};
    valueSet = [200, 436, 340, 568, 260, 500, 107, 0];
    MARBLES = containers.Map(keySet,valueSet);
    slots = [];
    % MARBLES('blue_big') => (3 * 360)

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