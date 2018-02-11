%  "Aggies do not lie, cheat, or steal, or tolerate those who do"re

clear
myev3 = legoev3('usb');
stop

mycolorsensor = colorSensor(myev3);
mymotor = motor(myev3,'A');

mymotor.Speed = -8;

rots(1) = 0;
i = 1;

% go until first 'start' black bar
start(mymotor);
while readLightIntensity(mycolorsensor, 'reflected') > 21
    fprintf('.');
end

% measure
while true
    if readLightIntensity(mycolorsensor, 'reflected') < 21
        rots(i) = readRotation(mymotor);
        i = i + 1;
        while readLightIntensity(mycolorsensor, 'reflected') < 21
            % wait until it passes
        end
        resetRotation(mymotor);
    end
    if i > 4
        break
    end
end
stop(mymotor); % motor will stop when light sensor reads <= X
