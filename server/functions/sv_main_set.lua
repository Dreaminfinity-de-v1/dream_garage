function setVehicle(type, target, data)
    local result = 0

    if Config.VehicleTypes[type] ~= nil and not isPlateExist(data.plate) then
        local xPlayer = ESX.GetPlayerFromId(target)
        local owner = "ERROR"

        if xPlayer ~= nil then
            owner = xPlayer.getIdentifier()
        elseif isIdentifierExist(target) == true then
            owner = target
        else
            return false
        end

        result = MySQL.Sync.execute("INSERT INTO `dream_owned_vehicle`(`plate`, `owner`, `data`, `garage_id`, `custom_name`, `type`) VALUES (@plate, @owner, @data, @garage_id, NULL, @type)" , {
            ['@plate'] = data.plate,
            ['@owner'] = owner,
            ['@data'] = json.encode(data),
            ['@garage_id'] = Config.VehicleTypes[type].default_garage,
            ['@type'] = type,
        })
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

function setVehiclePlate(oldplate, newplate)
    local result = 0

    vehicledata = json.decode(getVehicleByPlate(oldplate).data)

    vehicledata.plate = newplate

    result = MySQL.Sync.execute("UPDATE `dream_owned_vehicle` SET `data` = @data, `plate` = @newplate WHERE `plate` = @oldplate" , {
        ['@data'] = json.encode(vehicledata),
        ['@newplate'] = newplate,
        ['@oldplate'] = oldplate,
    })
    
    if result >= 1 then
        return true
    end

    return false

end
