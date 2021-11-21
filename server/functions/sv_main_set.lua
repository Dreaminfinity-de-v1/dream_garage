function setVehicle(type, target, data)
    local result = 0

    if Config.VehicleTypes[type] ~= nil and not isPlateExist(data.plate) then
        local xPlayer = ESX.GetPlayerFromId(target)
        local owner = "ERROR"
        local vin = getRandomVehicleIdentificationNumber()

        if xPlayer ~= nil then
            owner = xPlayer.getIdentifier()
        elseif isIdentifierExist(target) == true then
            owner = target
        else
            return false
        end

        result = MySQL.Sync.execute("INSERT INTO `dream_owned_vehicle`(`vin`, `plate`, `owner`, `data`, `garage_id`, `custom_name`, `type`) VALUES (@vin, @plate, @owner, @data, @garage_id, NULL, @type)" , {
            ['@vin'] = vin,
            ['@plate'] = data.plate,
            ['@owner'] = owner,
            ['@data'] = json.encode(data),
            ['@garage_id'] = Config.VehicleTypes[type].default_garage,
            ['@type'] = type,
        })
        
        local sql2 = "INSERT INTO `dream_vehicle_plate_log`( `vin`, `plate`) VALUES (@vin, @plate)"
        result2 = MySQL.Sync.execute(sql2 , {
            ['@vin'] = vin,
            ['@plate'] = data.plate,
        })

        if result2 <= 0 then
            sql2 = string.gsub( sql2,'@vin',vin )
            sql2 = string.gsub( sql2,'@plate',data.plate )
            print('[^1ERROR^7] ' .. sql2)
        end
        
    end
    
    if result >= 1 then
        return true
    end

    return false

end

function setVehicleGarage(plate, garage)
    local result = 0

    if garage ~= nil then
        result = MySQL.Sync.execute("UPDATE `dream_owned_vehicle` SET `garage_id` = @garage_id WHERE `plate` = @plate" , {
            ['@garage_id'] = garage,
            ['@plate'] = plate,
        })
    else
        result = MySQL.Sync.execute("UPDATE `dream_owned_vehicle` SET `garage_id` = NULL WHERE `plate` = @plate" , {
            ['@plate'] = plate,
        })
    end
    
    if result >= 1 then
        return true
    end

    return false
end

function setVehicleData(plate, data)
    local result = 0

    result = MySQL.Sync.execute("UPDATE `dream_owned_vehicle` SET `data` = @data WHERE `plate` = @plate" , {
        ['@data'] = json.encode(data),
        ['@plate'] = plate,
    })
    
    if result >= 1 then
        return true
    end

    return false
end
