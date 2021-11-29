-- ServerCallbacks --
ESX.RegisterServerCallback('dream_garage:addSharedCharacter', function(src, cb, charname, userid, plate) 

    local xPlayer = ESX.GetPlayerFromId(src)
    local target = ESX.GetPlayerFromId(userid)

    if getVehicleByPlate(plate).owner ~= xPlayer.getIdentifier() then
        cb('not_allowed')
    elseif xPlayer == nil or target == nil then
        cb('player_not_exist')
    elseif tonumber(src) == tonumber(userid) then
        cb('cant_give_self')
    elseif xPlayer.getInventoryItem('carkey').count < 1 then
        cb('no_item')
    elseif isSharedCharacter(plate, target.getIdentifier()) then
        cb('owner_exist')
    elseif not addSharedCharacter(charname, target.getIdentifier(), plate) then
        cb('database')
    else
        cb('ok', target.getIdentifier())
    end
end)

ESX.RegisterServerCallback('dream_garage:getSharedCharacters', function(src, cb, plate)
    local xPlayer = ESX.GetPlayerFromId(src)

    if getVehicleByPlate(plate).owner == xPlayer.getIdentifier() then
        cb(getSharedCharacters(plate))
    else
        cb({})
    end

end)

ESX.RegisterServerCallback('dream_garage:removeSharedCharacter', function(src, cb, data)
    local xPlayer = ESX.GetPlayerFromId(src)

    if getVehicleByPlate(data.plate).owner ~= xPlayer.getIdentifier() then
        cb('not_allowed')
    elseif xPlayer == nil then
        cb('player_not_exist')
    elseif xPlayer.getWeight() + xPlayer.getInventoryItem('carkey').weight > ESX.GetConfig().MaxWeight then
        cb('no_place')
    elseif not removeSharedCharacter(data.plate, data.key_owner) then
        cb('database')
    else
        cb('ok')
    end
end)

ESX.RegisterServerCallback('dream_garage:setSharedCharacterName', function(src, cb, data, newname)
    local xPlayer = ESX.GetPlayerFromId(src)

    if getVehicleByPlate(data.plate).owner ~= xPlayer.getIdentifier() then
        cb('not_allowed')
    elseif xPlayer == nil then
        cb('player_not_exist')
    elseif not setSharedCharacterName(data.plate, data.key_owner, newname) then
        cb('database')
    else
        cb('ok')
    end
end)


-- function --
function addSharedCharacter(charname, identifier, plate)
    local result = 0

    result = MySQL.Sync.execute("INSERT INTO `dream_vehicle_keys`(`plate`, `key_owner`, `name`) VALUES (@plate, @key_owner, @name)" , {
        ['@plate'] = plate,
        ['@key_owner'] = identifier,
        ['@name'] = charname,
    })
    
    if result >= 1 then
        return true
    end

    return false
end

function removeSharedCharacter(plate, identifier)
    local result = 0

    result = MySQL.Sync.execute("DELETE FROM `dream_vehicle_keys` WHERE `key_owner` = @key_owner AND `plate` = @plate" , {
        ['@plate'] = plate,
        ['@key_owner'] = identifier,
    })
    
    if result >= 1 then
        return true
    end

    return false
end

function getSharedCharacters(plate)
    if plate ~= nil then
        
        return MySQL.Sync.fetchAll('SELECT * FROM `dream_vehicle_keys` WHERE `plate` = @plate', {
            ['@plate'] = plate,
        })  
    else
        return MySQL.Sync.fetchAll('SELECT * FROM `dream_vehicle_keys`', {})  
    end
end

function isSharedCharacter(plate, identifier)
    local result = 0
    
    result = MySQL.Sync.fetchAll('SELECT * FROM `dream_vehicle_keys` WHERE `plate` = @plate AND `key_owner` = @key_owner', {
            ['@plate'] = plate,
            ['@key_owner'] = identifier,
    })
    
    if #result >= 1 then
        return true
    end

    return false
end

function setSharedCharacterName(plate, identifier, newname)
    local result = 0

    result = MySQL.Sync.execute("UPDATE `dream_vehicle_keys` SET `name` = @name WHERE `plate` = @plate AND `key_owner` = @key_owner" , {
        ['@name'] = newname,
        ['@plate'] = plate,
        ['@key_owner'] = identifier,
    })
    
    if result >= 1 then
        return true
    end

    return false
end
