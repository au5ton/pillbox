function[]= barCodeReader()
marbleSorter = legoev3('USB');
RED = zeros(1,2);
BLUE = zeros(1,2);
OTHER = zeros(1,2);
WHITE = zeros(1,2);
information = zeros(1,8);
barcodeMotor = motor(marbleSorter,'A');
barcodeMotor.Speed = -20;
DIAMETER =2 + 3/16;
DISTANCE = 1;
light = 100;
THRESHOLD = 18;
rotation = 0;
VALUE = (-180/pi())*(DISTANCE/(DIAMETER/2));
barcode = colorSensor(marbleSorter);
start(barcodeMotor);
while(light > THRESHOLD)
    light = readLightIntensity(barcode,'reflected');
end
% light
resetRotation(barcodeMotor);
for(i= 1:numel(information))
    while(rotation > VALUE)
        rotation = readRotation(barcodeMotor);
    end
    beep(marbleSorter);
    resetRotation(barcodeMotor);
    rotation = 0;
    information(i) = readLightIntensity(barcode,'reflected');
end
stop(barcodeMotor);
for(j=1:numel(information))
    if(information(j)<THRESHOLD)
        information(j)= 1;
    else
        information(j)= 0;
    end
end

number = 0;
MULTIPLY = 2;
for(h = 4:numel(information))
    if(information(h) == 1)
        number = number + MULTIPLY^(h-4);
    end
end
number
number = number-1;
if(information(3)==1)
    OTHER(1)=mod(number,4);
    OTHER(2)=floor(number/4);
elseif(information(2)==1&&information(1)==1)
    BLUE(1) = mod(number,4);
    BLUE(2) = floor(number/4);
elseif(information(2)==1&&information(1)==0)
    RED(1) = mod(number,4);
    RED(2) = floor(number/4);
elseif(information(2)==0&&information(1)==1)
    WHITE(1) = mod(number,4);
    WHITE(2) = floor(number/4);
else
    fprintf("invalid \n");
end
fprintf("RED big = %d \n",RED(1));
fprintf("RED small = %d \n",RED(2));
fprintf("BLUE big = %d \n",BLUE(1));
fprintf("BLUE small = %d \n",BLUE(2));
fprintf("WHITE big = %d \n",WHITE(1));
fprintf("WHITE small = %d \n",WHITE(2));
fprintf("STEEL = %d \n",OTHER(1));
fprintf("HDPE = %d \n",OTHER(2));


end