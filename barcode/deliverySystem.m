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
function [] = deliverySystem(master, brick)
    %connects the ev3 to MatLab
    %brick = legoev3('USB');

    conveyor = motor(brick,'A');
    pick = motor(brick,'B');
    conveyor.Speed=40;
    time=[0,1,2,3,4,5,6,7];
    pause(2)
    start(conveyor)
    pause(time(legoColorN))
    stop(conveyor)
    pick.Speed=60;
    start(pick);
    pause(.25)
    stop(pick)
    pause(1)
    pick.Speed=-60;
    start(pick);
    pause(.25)
    stop(pick)

    conveyor.Speed=-40
    start(conveyor)
    pause(time(legoColorN))
    stop(conveyor)
end