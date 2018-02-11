%  "Aggies do not lie, cheat, or steal, or tolerate those who do"

% macOS bluetooth connection:
% myev3 = legoev3('Bluetooth','/dev/tty.EV3-SerialPort');
% see: https://www.mathworks.com/help/supportpkg/legomindstormsev3io/examples/getting-started-with-matlab-support-package-for-lego-mindstorms-ev3-hardware.html

% confirm a proper environment
if exist('myev3') == 0
    fprintf('create a legoev3 object called `myev3`\nsee: https://www.mathworks.com/help/supportpkg/legomindstormsev3io/examples/getting-started-with-matlab-support-package-for-lego-mindstorms-ev3-hardware.html\n')
    return
end

for i = 1:100
    beep(myev3);
end
