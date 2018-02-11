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
for i = 1:20
    start(mymotor)
    java.lang.Thread.sleep(250);
    stop(mymotor);
    java.lang.Thread.sleep(500);
    ray(i) = readLightIntensity(mycolorsensor,'reflected');
end
disp(ray);

% for i = 1:100
%     beep(myev3);
% end
