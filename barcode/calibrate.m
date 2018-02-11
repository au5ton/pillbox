%  "Aggies do not lie, cheat, or steal, or tolerate those who do"

if exist('myev3') == 0
    fprintf('create a legoev3 object called `myev3`\nmyev3 = legoev3(''usb'')\nsee: https://www.mathworks.com/help/supportpkg/legomindstormsev3io/examples/getting-started-with-matlab-support-package-for-lego-mindstorms-ev3-hardware.html\n')
    return
end

mycolorsensor = colorSensor(myev3);
mymotor = motor(myev3,'A');
mymotor.Speed = -7;
ray(1) = 0;
% for i = 1:20
%     start(mymotor)
%     java.lang.Thread.sleep(250);
%     stop(mymotor);
%     java.lang.Thread.sleep(500);
%     ray(i) = readLightIntensity(mycolorsensor,'reflected');
% end

% while not black, go slowly until 'START' bar
start(mymotor);
while true
    disp(readLightIntensity(mycolorsensor, 'reflected'));
end

% while not black, keep going
% on stop, measure distance


disp(ray);
