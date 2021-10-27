function getAllVehicles()
    local vehicles = MySQL.Sync.fetchAll('SELECT * FROM `dream_owned_vehicle`', {})

    for i,v in ipairs(vehicles) do
        
        vehicles[i].data = json.decode(v.data)
        vehicles[i].data.plate = v.plate

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

function getVehicleByPlate(plate)
    local vehicles = MySQL.Sync.fetchAll('SELECT * FROM `dream_owned_vehicle` WHERE `plate` = @plate', {['@plate'] = plate})

    if #vehicles >= 1 then
        vehicles[1].data = json.decode(vehicles[1].data)
        vehicles[1].data.plate = vehicles[1].plate
        return vehicles[1]
    end
end
