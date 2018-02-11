%  "Aggies do not lie, cheat, or steal, or tolerate those who do"

% macOS bluetooth connection:
% myev3 = legoev3('Bluetooth','/dev/tty.EV3-SerialPort');
% myev3 = legoev3('usb');
% see: https://www.mathworks.com/help/supportpkg/legomindstormsev3io/examples/getting-started-with-matlab-support-package-for-lego-mindstorms-ev3-hardware.html

% confirm a proper environment
if exist('myev3') == 0
    fprintf('create a legoev3 object called `myev3`\nmylego = legoev3(''usb'')\nsee: https://www.mathworks.com/help/supportpkg/legomindstormsev3io/examples/getting-started-with-matlab-support-package-for-lego-mindstorms-ev3-hardware.html\n')
    return
end

mycolorsensor = colorSensor(myev3);
mymotor = motor(myev3,'A');

mymotor.Speed = -10;
ray(1) = 0;

% while not black, go slowly until 'START' bar
start(mymotor);
while readLightIntensity(mycolorsensor, 'reflected') > 21
    fprintf('.');
end
stop(mymotor); % motor will stop when light sensor reads <= X

% while not black, keep going
start(mymotor);
while readLightIntensity(mycolorsensor, 'reflected') > 21
    fprintf('x');
end
stop(mymotor); % motor will stop when light sensor reads <= X
% on stop, measure distance

disp(ray);

% for i = 1:100
%     beep(myev3);
% end
