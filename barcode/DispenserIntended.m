function[data]= DispenserIntended()

marbleSorter = legoev3('USB');
colorMarble = colorSensor(marbleSorter,1);
button = touchSensor(marbleSorter,2);
gate = motor(marbleSorter,'B'); % gate
resetRotation(gate);
mixer = motor(marbleSorter,'A'); % mixer
arm = motor(marbleSorter,'D'); % turntable
resetRotation(arm);
dispenserMotor = motor(marbleSorter,'C'); % elevator

%CONSTANTS
cap = 45;
TIME = 1;
done = false;
sonic = -30;
dispenserMotor.Speed = sonic;
gate.Speed = sonic;
mixer.Speed = 40;

data = zeros(4,2);
start(dispenserMotor);
start(mixer);
holder = zeros(1,3);

WS=[35,48,28,23,27,18]; % max r, max g, max b, min r, min g, min b
WB=[134,172,100,99,131,78];
RS=[24,5,4,13,5,3];
RDB=[54,9,5,40,7,4];
BBR = [80,11,6,62,8,4];
BS=[7,12,16,6,8,10];
BB=[17,32,45,12,24,32];
STEEL=[10,12,6,7,6,4];
HDPE=[22,28,16,13,14,9];
COLORS = [WB;WS;RDB;RS;BB;BS;HDPE;STEEL];
THRESHOLD = 0;
NAME = ["big white\n","small white\n","big red\n","small red\n","big blue\n","small blue\n","HDPE\n","STEEL\n","GARBAGE\n"];
while(readTouch(button) == 0)
    color = readColorRGB(colorMarble); % [1,2,3]
    % update holder with brightest value
    if(color(1)>holder(1)||color(2)>holder(2)||color(3)>holder(3))
        for i = 1:3
            if(color(i)>holder(i))
                holder(i) = color(i);
            end
        end
    end
    % if theres no more bright values (marble already passed)
    if(color(1)-holder(1)<THRESHOLD&&color(2)-holder(2)<THRESHOLD&&color(3)-holder(3)<THRESHOLD)
        % traverse marbles
        for(i=1:8)
            countdown = 3;
            %fprintf("working %d\n",i);
            % traverse individual marble ranges
            for(j = 1:3)
                %disp(holder)
                if(holder(j)<=COLORS(i,j)&&holder(j)>=COLORS(i,j+3))
                    countdown = countdown - 1;
                end
            end
            if(countdown == 0)
                
                fprintf(NAME(i));
                data(ceil(i/2),mod(i-1,2)+1)=data(ceil(i/2),mod(i-1,2)+1)+1;
                pause(1);
                % move the arm
                % i => ['big white','small white','big red','small red','big blue','small blue','HDPE','STEEL'];
                %["big white\n","small white\n","big red\n","small red\n","big blue\n","small blue\n","HDPE\n","STEEL\n"]
                keySet = {cell2mat(NAME(9)), cell2mat(NAME(7)),cell2mat(NAME(8)),cell2mat(NAME(3)),cell2mat(NAME(1)),cell2mat(NAME(5)),cell2mat(NAME(4)),cell2mat(NAME(2)),cell2mat(NAME(6))};
                % valueSet is in order of rotation
                % garbo, hdpe, steel, big red, big white, big blue, small red, small white, small blue
                valueSet = [0, -10, -18, -28, -37, -45, -54, -62, -69];
                gate_up_deg = -20; % up position
                gate_down_deg = -5; % down position 
                TURNTABLES = containers.Map(keySet,valueSet); % retrieve with TURNTABLES(cell2mat(NAME(1)))
                
                % gate starts lowered
                
                % rotate turntable
                arm.Speed = -15;
                start(arm);
                disp('arm moving');
                % basically stop at where it needs to be
                while(readRotation(arm) >  TURNTABLES(cell2mat(NAME(i))))
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
                pause(1.25);

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
                
                break
            end
            %if(done)
            %    resetRotation(gate);
            %    start(gate);
            %    while(readRotation(gate)< cap)
            %    end
            %    stop(gate);
            %    gate.Speed = -sonic;
            %    start(gate);
            %    while(readRotation(gate)> 0)
            %    end
            %    stop(gate);
            %end
                
        end
        garbo_threshold = 5;
        if(holder(1) > garbo_threshold && holder(2) > garbo_threshold && holder(3) > garbo_threshold-3)
            % this is a garbo marble
            % lift the gate
            gate_up_deg = -20; % up position
            gate_down_deg = -5; % down position 
            disp('GARBO MARBLE DETECTED REEEEEEE');
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
            pause(0.75);

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
        end
        holder = zeros(1,3);
    end
    %fprintf("Red: %d Green: %d Blue: %d -- RC: %d GC: %d BC: %d\n",holder(1),holder(2),holder(3), color(1), color(2), color(3));
end   
stop(dispenserMotor);
stop(mixer);
end