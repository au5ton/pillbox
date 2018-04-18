function master = http_get_inventory()
    master = webwrite('http://198.211.107.5:7000/getinventory','');
end