function getAllVehicles()
    local vehicles = MySQL.Sync.fetchAll('SELECT * FROM `dream_owned_vehicle` ORDER BY `dream_owned_vehicle`.`garage_name` ASC', {})

    for i,v in ipairs(vehicles) do

        vehicles[i].vehicle = json.decode(v.vehicle)
        vehicles[i].vehicle.plate = v.plate

    end
    return vehicles   
end

function getOwnedVehicles(license)
    local result = {}

    for i,v in ipairs(getAllVehicles()) do

        if v.owner == license then
            table.insert( result, v)
        end
    end

    return result
end

function getVehicleByPlate(license, plate)
    local vehicles = MySQL.Sync.fetchAll('SELECT * FROM `dream_owned_vehicle` WHERE `plate` = @plate', {['@plate'] = plate})

    if #vehicles >= 1 then
        vehicles[1].vehicle = json.decode(vehicles[1].vehicle)
        vehicles[1].vehicle.plate = vehicles[1].plate
        return vehicles[1]
    end
end

function setVehicleGarage(plate, garage)
    return MySQL.Sync.execute("UPDATE `dream_owned_vehicle` SET `garage_name` = @garage_name WHERE `plate` = @plate" , {
        ['@garage_name'] = garage,
        ['@plate'] = plate,
    })
end

function setVehicleOutparking(license, plate)
    local vehicle = getVehicleByPlate(license, plate)

    if vehicle == nil then
        return 'not_found'
    end
    
    if vehicle.owner ~= license then
        return 'not_allowed'
    end

    if vehicle.garage_name == nil then
        return 'already_out'
    end
    
    if setVehicleGarage(plate, nil) <= 0 then
        return 'database'
    end
    return 'ok'
end

