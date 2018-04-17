% By submitting this assignment, I agree to the following:
%  �Aggies do not lie, cheat, or steal, or tolerate those who do�
%  �I have not given or received any unauthorized aid on this assignment�
% 
% Name: Alexander Shung + Austin Jackson
% Section:	112-542
% Assignment: Engineering Projectc
% Date:	29 January

% start barcode scanner shit, will return the stuff
%master = barCodeReader()
% w ; r ; b; o
%master = [0 0; 0 0; 0 1; 0 0];
master = [1 1; 1 1; 1 1; 1 1];
fprintf('WHITE big = %d \n',master(1,1));
fprintf('WHITE small = %d \n',master(1,2));
fprintf('RED big = %d \n',master(2,1));
fprintf('RED small = %d \n',master(2,2));
fprintf('BLUE big = %d \n',master(3,1));
fprintf('BLUE small = %d \n',master(3,2));
fprintf('STEEL = %d \n',master(4,1));
fprintf('HDPE = %d \n',master(4,2));
pause(5);
% master = barCodeReader();
deliverySystem(master);