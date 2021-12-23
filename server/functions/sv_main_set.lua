function setVehicle(type, target, data)
    local result = 0

    if Config.VehicleTypes[type] ~= nil and not isPlateExist(data.plate) then
        local xPlayer = ESX.GetPlayerFromId(target)
        local owner = nil
        local vin = getRandomVehicleIdentificationNumber()

        if xPlayer ~= nil then
            owner = xPlayer.getIdentifier()
        elseif isIdentifierExist(target) == true then
            owner = target
        else
            return false
        end

        if owner ~= nil then
            result = MySQL.Sync.execute("INSERT INTO `dream_owned_vehicles`(`vin`, `plate`, `owner`, `data`, `garage_id`, `custom_name`, `type`) VALUES (@vin, @plate, @owner, @data, @garage_id, NULL, @type)" , {
                ['@vin'] = vin,
                ['@plate'] = data.plate,
                ['@owner'] = owner,
                ['@data'] = json.encode(data),
                ['@garage_id'] = Config.VehicleTypes[type].default_garage,
                ['@type'] = type,
            })
            
            local sql2 = "INSERT INTO `dream_vehicle_plate_log`( `vin`, `owner`, `plate`) VALUES (@vin, @owner, @plate)"
            result2 = MySQL.Sync.execute(sql2 , {
                ['@vin'] = vin,
                ['@owner'] = owner,
                ['@plate'] = data.plate,
            })

            if result2 <= 0 then
                sql2 = string.gsub( sql2,'@vin',vin )
                sql2 = string.gsub( sql2,'@owner',owner )
                sql2 = string.gsub( sql2,'@plate',data.plate )
                print('[^1ERROR^7] ' .. sql2)
            end
        end
        
    end
    
    if result >= 1 then
        TriggerEvent('dream_garage:VehicleAddEvent', vin, data.plate, owner, data, Config.VehicleTypes[type].default_garage, type)
        return true
    end

    return false

end

function setVehicleGarage(vin, garage)
    local result = 0

    if garage ~= nil then
        result = MySQL.Sync.execute("UPDATE `dream_owned_vehicles` SET `garage_id` = @garage_id WHERE `vin` = @vin" , {
            ['@garage_id'] = garage,
            ['@vin'] = vin,
        })
    else
        result = MySQL.Sync.execute("UPDATE `dream_owned_vehicles` SET `garage_id` = NULL WHERE `vin` = @vin" , {
            ['@vin'] = vin,
        })
    end
    
    if result >= 1 then
        TriggerEvent('dream_garage:VehicleGarageChangeEvent', plate, garage)
        return true
    end

    return false
end

function setVehicleData(vin, data)
    local result = 0

    result = MySQL.Sync.execute("UPDATE `dream_owned_vehicles` SET `data` = @data WHERE `vin` = @vin" , {
        ['@data'] = json.encode(data),
        ['@vin'] = vin,
    })
    
    if result >= 1 then
        TriggerEvent('dream_garage:VehicleDataChangeEvent', vin, data)
        return true
    end

    return false
end

function setVehicleOwner(vin, newowner)
    local result = 0
    local vehicle = getVehicleByVIN(vin)

    result = MySQL.Sync.execute("UPDATE `dream_owned_vehicles` SET `owner` = @owner WHERE `vin` = @vin" , {
        ['@owner'] = newowner,
        ['@vin'] = vin,
    })
            
    local sql2 = "INSERT INTO `dream_vehicle_plate_log`( `vin`, `owner`, `plate`) VALUES (@vin, @owner, @plate)"
    result2 = MySQL.Sync.execute(sql2 , {
        ['@vin'] = vin,
        ['@owner'] = newowner,
        ['@plate'] = vehicle.plate,
    })

    if result2 <= 0 then
        sql2 = string.gsub( sql2,'@vin',vin )
        sql2 = string.gsub( sql2,'@owner',newowner )
        sql2 = string.gsub( sql2,'@plate',vehicle.plate )
        print('[^1ERROR^7] ' .. sql2)
    end
    
    if result >= 1 then
        TriggerEvent('dream_garage:VehicleOwnerChangeEvent', vin, newowner, vehicle)
        return true
    end

    return false
end
