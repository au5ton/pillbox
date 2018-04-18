function master = http_get_inventory()
    master = webwrite('http://localhost:7000/getinventory','');
end