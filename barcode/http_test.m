import matlab.net.*
import matlab.net.http.*

% retrieve data 
x = webwrite('http://localhost:7000/getinventory','');
disp(x);

% send data

master = [1 1; 1 1; 1 1; 1 1];

data = struct('payload', master);    
url = 'http://127.0.0.1:7000/setinventory';

options = weboptions('MediaType','application/json','ContentType','json');
response = webwrite(url, data, options);