function setVehicleOutparking(license, plate, allowed)
    local vehicle = getVehicleByPlate(plate)
    
    if vehicle == nil then
        return 'not_allowed'
    end
    
    if vehicle.owner ~= license and not allowed then
        return 'not_allowed'
    end

    if vehicle.garage_id == nil then
        return 'already_out'
    end
 
    if setVehicleGarage(plate, nil) ~= true then
        return 'database'
    end

    return 'ok'
end

function setVehicleInparking(license, plate, garage_id, allowed)
    local vehicle = getVehicleByPlate(plate)
    
    if vehicle == nil then
        return 'not_allowed'
    end

    if garage_id == nil then
        return 'garage_null'
    end
    
    if vehicle.owner ~= license and not allowed then
        return 'not_allowed'
    end

    if vehicle.garage_id ~= nil then
        return 'already_in'
    end
 
    if setVehicleGarage(plate, garage_id) ~= true then
        return 'database'
    end

    return 'ok'
end

function setVehicleCustomeName(plate, custom_name)
    local result = 0

    if custom_name ~= nil then
        result = MySQL.Sync.execute("UPDATE `dream_owned_vehicle` SET `custom_name` = @custom_name WHERE `plate` = @plate" , {
            ['@custom_name'] = custom_name,
            ['@plate'] = plate,
        })
    else
        result = MySQL.Sync.execute("UPDATE `dream_owned_vehicle` SET `custom_name` = NULL WHERE `plate` = @plate" , {
            ['@plate'] = plate,
        })
    end
    
    if result >= 1 then
        return true
    end

    return false
end

function setOwnedVehicleCustomeName(license, plate, custom_name)
    local vehicle = getVehicleByPlate(plate)

    if vehicle.owner ~= license then
        return 'not_allowed'
    end
 
    if setVehicleCustomeName(plate, custom_name) ~= true then
        return 'database'
    end

    return 'ok'
end