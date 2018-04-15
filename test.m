function[data]= DispenserIntended()
marbleSorter = legoev3('USB');
stopMotor = motor(marbleSorter,'C');
dispenserMotor = motor(marbleSorter,'A');
colorMarble = colorSensor(marbleSorter,1);
mixer = motor(marbleSorter,'B');
%CONSTANTS
TIME = 0.5;
dispenserMotor.Speed = -30;
mixer.Speed = 40;
data = zeros(4,2);
start(dispenserMotor);
start(mixer);
holder = zeros(1,3);
WS=[46,62,37,30,40,25]; % max r, max g, max b, min r, min g, min b
WB=[103,134,79,87,108,66];
RS=[22,5,4,18,5,3];
RB=[64,10,5,55,8,4];
BS=[7,11,14,6,9,12];
BB=[15,30,42,12,21,32];
STEEL=[9,9,5,7,7,4];
HDPE=[20,23,15,18,21,13];
COLORS = [WB;WS;RB;RS;BB;BS;HDPE;STEEL];
THRESHOLD = 0;
NAME = ['big white\n','small white\n','big red\n','small red\n','big blue\n','small blue\n','HDPE\n','STEEL\n'];
run = true;
totalcalls = 0;
resetRotation(stopMotor);
while(abs(readRotation(stopMotor))<90)
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
    if(color(1)-holder(1)<THRESHOLD&&color(2)-holder(2)<THRESHOLD&&color(3)-holder(3)<THRESHOLD)%&&run)
        totalcalls = totalcalls + 1;
        %disp(['marb passed ' num2str(totalcalls)])
        % countdown = 3;
        % i = 1;
        % % traverse marbles
        % while(i<=size(COLORS,1))%&&run)
        %     fprintf('working %d\n',i);
        %     % traverse individual marble ranges
        %     for(j = 1:size(COLORS,2)/2)
        %         %disp(holder)
        %         if(holder(j)<=COLORS(i,j)&&holder(j)>=COLORS(i,j+3))
        %             countdown = countdown - 1;
        %         end
        %     end
        %     if(countdown == 0)
        %         fprintf(NAME(i));
        %         data(ceil(i/2),mod(i-1,2)+1)=data(ceil(i/2),mod(i-1,2)+1)+1;
        %         holder = zeros(1,3);
        %         pause(TIME);
        %         break
        %     end
        %     i=i+1;
        % end
    end
    run = true;
    fprintf('Red: %d Green: %d Blue: %d -- RC: %d GC: %d BC: %d\n',holder(1),holder(2),holder(3), color(1), color(2), color(3));
end   
stop(dispenserMotor);
stop(mixer);
end