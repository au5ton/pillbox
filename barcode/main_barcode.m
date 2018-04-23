% By submitting this assignment, I agree to the following:
%  �Aggies do not lie, cheat, or steal, or tolerate those who do�
%  �I have not given or received any unauthorized aid on this assignment�
% 
% Name: Alexander Shung + Austin Jackson
% Section:	112-542
% Assignment: Engineering Projectc
% Date:	29 January

inventory = [];
% wait until inventory is filled
fprintf('waiting until inventory is populated...');
while(true)
    if(~isempty(http_get_inventory()))
        inventory = http_get_inventory();
        break
    else
        fprintf('.');
    end
    pause(5);
end
fprintf('\ninventory is filled!\n');
inventory,;

% start barcode scanner shit, will return the stuff
%scanned = barCodeReader();
scanned = [2 0; 3 2; 1 2; 1 0];
scanned = [1 1; 1 1; 1 1; 1 1];
scanned,;

for n = 1:1
    % check if inventory is capable of fullfilling the order
    delta = inventory - scanned;
    inventory = inventory - scanned;
    no_negative = true;
    for r = 1:size(delta,1)
        for c = 1:size(delta,2)
            if delta(r,c) < 0
                no_negative = false;
            end
        end
    end
    if no_negative == false
        % error sound
        brick = legoev3('usb');
        for i = 1:5
            for freq = 2500:-50:350
                %fprintf('freq: %d\n',freq);
                % playTone(brick, freq, dur, vol)
                playTone(brick,freq,0.015,10.0)
                pause(0.015);
            end
            for freq = 350:50:2500
                %fprintf('freq: %d\n',freq);
                % playTone(brick, freq, dur, vol)
                playTone(brick,freq,0.015,10.0)
                pause(0.015);
            end
        end
    else
        deliverySystem(scanned);
    end
end

