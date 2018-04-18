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
gate_up_deg = -20; % up position
gate_down_deg = -5; % down position 
sonic = -30;
dispenserMotor.Speed = sonic;
gate.Speed = sonic;
mixer.Speed = 40;
data = zeros(4,2);
start(dispenserMotor);
start(mixer);
holder = zeros(1,3);
NAME = ["big white\n","small white\n","big red\n","small red\n","big blue\n","small blue\n","HDPE\n","STEEL\n"];
% garbo, hdpe, steel, big red, big white, big blue, small red, small white, small blue
valueSet = [-10, -18, -28, -37, -45, -54, -62, -69];
%["big white\n","small white\n","big red\n","small red\n","big blue\n","small blue\n","HDPE\n","STEEL\n"]
keySet = {cell2mat(NAME(7)),cell2mat(NAME(8)),cell2mat(NAME(3)),cell2mat(NAME(1)),cell2mat(NAME(5)),cell2mat(NAME(4)),cell2mat(NAME(2)),cell2mat(NAME(6))};
TURNTABLES = containers.Map(keySet,valueSet); % retrieve with TURNTABLES(cell2mat(NAME(1)))
WS=[35,48,28,23,27,18]; % max r, max g, max b, min r, min g, min b
WB=[134,172,100,58,71,46];
RS=[24,5,4,13,4,3];
RB = [63,9,5,30,6,3];
BS=[7,12,16,5,7,8];
BB=[17,32,45,9,17,19];
STEEL=[10,12,6,6,5,3];
HDPE=[22,28,16,12,13,9];
COLORS = [WB;WS;RB;RS;BB;BS;HDPE;STEEL];
THRESHOLD = 0;
gate.Speed = -20;
start(gate);
disp('gate moving');
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
%                 gate.Speed = 20;
%                 disp('gate closing');
%                 start(gate);
%                 % gate_up_deg is negative
%                 while(readRotation(gate) < gate_down_deg)
%                     % do nothing until while is broken
%                     if(readTouch(button))
%                         stop(arm);
%                         stop(gate);
%                         stop(mixer);
%                         stop(dispenserMotor);
%                         return
%                     end
%                 end
%                 stop(gate);
                disp('gate stopped');
                fprintf(NAME(i));
                data(ceil(i/2),mod(i-1,2)+1)=data(ceil(i/2),mod(i-1,2)+1)+1;
                arm.Speed = -15;
                start(arm);
                disp('arm moving');
                while(readRotation(arm) >  TURNTABLES(cell2mat(NAME(i))))
                    % do nothing until while is broken
                    if(readTouch(button))
                        stop(arm);
                        stop(gate);
                        break
                    end
                end
                stop(arm);
                disp('arm stopped');
                pause(.6);
                % lower the gate
%                 gate.Speed = -20;
%                 start(gate);
%                 disp('gate opening');
%                 % gate_up_deg is negative
%                 while(readRotation(gate) > gate_up_deg)
%                     % do nothing until while is broken
%                     if(readTouch(button))
%                         stop(arm);
%                         stop(gate);
%                         stop(mixer);
%                         stop(dispenserMotor);
%                         return
%                     end
%                 end
%                 stop(gate);
%                 disp('gate stopped');
%                 pause(2);
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
        end
%         garbo_threshold = 5;
%         if(holder(1) > garbo_threshold && holder(2) > garbo_threshold && holder(3) > garbo_threshold-3)
%             this is a garbo marble
%             lift the gate
%             gate_up_deg = -20; % up position
%             gate_down_deg = -5; % down position 
%             disp('GARBO MARBLE DETECTED REEEEEEE');
%             gate.Speed = -20;
%             disp('gate moving');
%             start(gate);
%             gate_up_deg is negative
%             while(readRotation(gate) > gate_up_deg)
%                 do nothing until while is broken
%                 if(readTouch(button))
%                     stop(arm);
%                     stop(gate);
%                     stop(mixer);
%                     stop(dispenserMotor);
%                     return
%                 end
%             end
%             stop(gate);
%             disp('gate stopped');
% 
%             wait 1 second
%             pause(0.75);
% 
%             lower the gate
%             gate.Speed = 20;
%             start(gate);
%             disp('gate moving');
%             gate_up_deg is negative
%             while(readRotation(gate) < gate_down_deg)
%                 do nothing until while is broken
%                 if(readTouch(button))
%                     stop(arm);
%                     stop(gate);
%                     stop(mixer);
%                     stop(dispenserMotor);
%                     return
%                 end
%             end
%             stop(gate);
%             disp('gate stopped');
%             holder = zeros(1,3);
%         end
        holder = zeros(1,3);
    end
    %fprintf("Red: %d Green: %d Blue: %d -- RC: %d GC: %d BC: %d\n",holder(1),holder(2),holder(3), color(1), color(2), color(3));
end
gate.Speed = 15;
start(gate);
disp('gate closing');
while(readRotation(gate) < gate_down_deg)
end
stop(gate);
stop(dispenserMotor);
stop(mixer);
end