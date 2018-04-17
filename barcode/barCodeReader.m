% By submitting this assignment, I agree to the following:
%  �Aggies do not lie, cheat, or steal, or tolerate those who do�
%  �I have not given or received any unauthorized aid on this assignment�
% 
% Name: Alexander Shung
% Section:	112-542
% Assignment: Engineering Projectc
% Date:	29 January
% Reads barcodes that is fed through a motor and records the specific data
% that the barcode represents
function[master]= barCodeReader()
    %connects the ev3 to MatLab
    barcodeBrick = legoev3('USB');
    %array that will be used to store the information
    master = zeros(4,2);
    %array that is used to as a placeholder for barcode data
    information = zeros(1,8);
    %sets the barcode motor as a motor found in port a on the EV brick
    barcodeMotor = motor(barcodeBrick,'C');
    %speed of the barcode motor
    barcodeMotor.Speed = -20;
    %constant of the diameter of the wheel
    DIAMETER =2 + 3/16;
    %the thickness of the barcode lines
    DISTANCE = 1;
    %the amount that light needs to be under to be considered a black stripe
    THRESHOLD = 18;
    %the amount of degrees of that the motor has moved
    rotation = 0;
    %formula to convert the thickness of a stripe to a degree for the motor
    VALUE = (-180/pi())*(DISTANCE/(DIAMETER/2));
    %name of color sensor used for barcode reading
    barcode = colorSensor(barcodeBrick);
    %button sensor used to control when the code starts
    button = touchSensor(barcodeBrick,2);
    %reads whether the button has been pushed to end the code
    buttonValue = readTouch(button);
    %keeps going until the button is pushed during the last reading of the
    %barcode
    while(buttonValue == 0)
        %starts the barcode motor,
        start(barcodeMotor);
        %arbitrary big starting value
        light = 100;
        %continuously checks if there is a black stripe
        while(light > THRESHOLD)
            light = readLightIntensity(barcode,'reflected');
        end
        % resets the amount of degrees back to 0
        resetRotation(barcodeMotor);
        %goes and finds the color of the stripes at specific distances and puts the
        %data in the information array
        for(i= 1:numel(information))
            %waits until it has gone over a certain number of degrees
            while(rotation > VALUE)
                rotation = readRotation(barcodeMotor);
            end
            %beeps to tell user that it has found a point
            beep(barcodeBrick);
            %resets the rotations
            resetRotation(barcodeMotor);
            %preps for the next reading of the barcode reader
            rotation = 0;
            %puts a value in a holder name
            holder = readLightIntensity(barcode,'reflected');
            %changes the holder value to 1 for black or 0 for white
            if(holder<THRESHOLD)
                information(i)= 1;
            else
                information(i)= 0;
            end
        end
        %stops barcode motor
        stop(barcodeMotor);
        % a place holder for a decimal value
        number = 0;
        MULTIPLY = 2;
        %used the quantity part of the barcode and changes the binary to decimal
        for(h = 4:numel(information))
            if(information(h) == 1)
                number = number + MULTIPLY^(h-4);
            end
        end
        %code to put the quantity into right place holder
        number = number-1;
        if(information(3)==1)
            master(4,1)=master(4,1)+mod(number,4);
            master(4,2)=master(4,2)+floor(number/4);
        elseif(information(2)==1&&information(1)==1)
            master(3,1) = master(3,1)+mod(number,4);
            master(3,2) = master(3,2)+floor(number/4);
        elseif(information(2)==1&&information(1)==0)
            master(2,1) = master(2,1)+mod(number,4);
            master(2,2) = master(2,2)+floor(number/4);
        elseif(information(2)==0&&information(1)==1)
            master(1,1) = master(1,1)+mod(number,4);
            master(1,2) = master(1,2)+floor(number/4);
        else
            %prints if there was something wrong with the scanning
            fprintf("Sum Tin Wong \n");
        end
        %checks if the button is pushed to end the barcode reading
        buttonValue = readTouch(button);
    end
    %prints out the result of the test
    fprintf('RED big = %d \n',master(2,1));
    fprintf('RED small = %d \n',master(2,2));
    fprintf('BLUE big = %d \n',master(3,1));
    fprintf('BLUE small = %d \n',master(3,2));
    fprintf('WHITE big = %d \n',master(1,1));
    fprintf('WHITE small = %d \n',master(1,2));
    fprintf('STEEL = %d \n',master(4,1));
    fprintf('HDPE = %d \n',master(4,2));

    barcodeBrick = [];
    barcodeMotor = [];
    barcode = [];
    button = [];
end