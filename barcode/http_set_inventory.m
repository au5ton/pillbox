function [] = http_set_inventory(master)

    data = struct('payload', master);    
    url = 'http://198.211.107.5:7000/setinventory';

    options = weboptions('MediaType','application/json','ContentType','json');
    response = webwrite(url, data, options);
    
end