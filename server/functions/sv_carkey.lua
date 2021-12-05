-- ServerCallbacks --
ESX.RegisterServerCallback('dream_garage:addSharedCharacter', function(src, cb, charname, userid, vin) 

    local xPlayer = ESX.GetPlayerFromId(src)
    local target = ESX.GetPlayerFromId(userid)

    if getVehicleByVIN(vin).owner ~= xPlayer.getIdentifier() then
        cb('not_allowed')
    elseif xPlayer == nil or target == nil then
        cb('player_not_exist')
    elseif tonumber(src) == tonumber(userid) then
        cb('cant_give_self')
    elseif xPlayer.getInventoryItem('carkey').count < 1 then --TODO itemname aus Config.Itemname
        cb('no_item')
    elseif isSharedCharacter(vin, target.getIdentifier()) then
        cb('owner_exist')
    elseif not addSharedCharacter(charname, target.getIdentifier(), vin) then
        cb('database')
    else
        --TODO Remove Item 'carkey'
        cb('ok', target.getIdentifier())
    end
end)

ESX.RegisterServerCallback('dream_garage:getSharedCharacters', function(src, cb, vin)
    local xPlayer = ESX.GetPlayerFromId(src)

    if getVehicleByVIN(vin).owner == xPlayer.getIdentifier() then
        cb(getSharedCharacters(vin))
    else
        cb({})
    end
end)

ESX.RegisterServerCallback('dream_garage:getAllowedVehicles', function(src, cb)
    local xPlayer = ESX.GetPlayerFromId(src)

    cb(getAllowedVehicles(xPlayer.getIdentifier()))
end)

ESX.RegisterServerCallback('dream_garage:removeSharedCharacter', function(src, cb, vin, key_owner)
    local xPlayer = ESX.GetPlayerFromId(src)

    if getVehicleByVIN(vin).owner ~= xPlayer.getIdentifier() then
        cb('not_allowed')
    elseif xPlayer == nil then
        cb('player_not_exist')
    elseif xPlayer.getWeight() + xPlayer.getInventoryItem('carkey').weight > ESX.GetConfig().MaxWeight then  --TODO itemname aus Config.Itemname
        cb('no_place')
    elseif not removeSharedCharacter(vin, key_owner) then
        cb('database')
    else
        --TODO Add Item 'carkey'
        cb('ok')
    end
end)

ESX.RegisterServerCallback('dream_garage:setSharedCharacterName', function(src, cb, vin, key_owner, newname)
    local xPlayer = ESX.GetPlayerFromId(src)

    if getVehicleByVIN(vin).owner ~= xPlayer.getIdentifier() then
        cb('not_allowed')
    elseif xPlayer == nil then
        cb('player_not_exist')
    elseif not setSharedCharacterName(vin, key_owner, newname) then
        cb('database')
    else
        cb('ok')
    end
end)


-- function --
function addSharedCharacter(charname, identifier, vin)
    local result = 0

    result = MySQL.Sync.execute("INSERT INTO `dream_vehicle_keys`(`vin`, `key_owner`, `name`) VALUES (@vin, @key_owner, @name)" , {
        ['@vin'] = vin,
        ['@key_owner'] = identifier,
        ['@name'] = charname,
    })
    
    if result >= 1 then
        return true
    end

    return false
end

function removeSharedCharacter(vin, identifier)
    local result = 0

    result = MySQL.Sync.execute("DELETE FROM `dream_vehicle_keys` WHERE `key_owner` = @key_owner AND `vin` = @vin" , {
        ['@vin'] = vin,
        ['@key_owner'] = identifier,
    })
    
    if result >= 1 then
        return true
    end

    return false
end

function getSharedCharacters(vin)
    if vin ~= nil then
        
        return MySQL.Sync.fetchAll('SELECT * FROM `dream_vehicle_keys` WHERE `vin` = @vin', {
            ['@vin'] = vin,
        })  
    else
        return MySQL.Sync.fetchAll('SELECT * FROM `dream_vehicle_keys`', {})  
    end
end

function getAllowedVehicles(key_owner)
    if key_owner ~= nil then
        local allowedVehicles = {}
        local allowedChars = MySQL.Sync.fetchAll('SELECT * FROM `dream_vehicle_keys` WHERE `key_owner` = @key_owner', {
            ['@key_owner'] = key_owner,
        })

        for i,v in ipairs(allowedChars) do
            table.insert(allowedVehicles, getVehicleByVIN(v.vin))
        end

        return allowedVehicles
    else
        return MySQL.Sync.fetchAll('SELECT * FROM `dream_vehicle_keys`', {})  
    end
end

function isSharedCharacter(vin, identifier)
    local result = 0
    
    result = MySQL.Sync.fetchAll('SELECT * FROM `dream_vehicle_keys` WHERE `vin` = @vin AND `key_owner` = @key_owner', {
            ['@vin'] = vin,
            ['@key_owner'] = identifier,
    })
    
    if #result >= 1 then
        return true
    end

    return false
end

function setSharedCharacterName(vin, identifier, newname)
    local result = 0

    result = MySQL.Sync.execute("UPDATE `dream_vehicle_keys` SET `name` = @name WHERE `vin` = @vin AND `key_owner` = @key_owner" , {
        ['@name'] = newname,
        ['@vin'] = vin,
        ['@key_owner'] = identifier,
    })
    
    if result >= 1 then
        return true
    end

    return false
end
