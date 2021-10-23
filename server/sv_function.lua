local letters = { "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z" }

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

        
        if Config.Debugmode.enable == true then
            for i,v in ipairs(vehicles) do 
                print(i)
                for k2, v2 in pairs(v) do
                    print(k2)
                    print(v2)
                    print('------')
                end
            end
        end
        return vehicles[1]
    end
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

function setVehicleOutparking(license, plate)
    local vehicle = getVehicleByPlate(plate)
    
    if vehicle == nil then
        return 'not_allowed'
    end
    
    if vehicle.owner ~= license then
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

function setVehicleInparking(license, plate, garage_id)
    local vehicle = getVehicleByPlate(plate)
    
    if vehicle == nil then
        return 'not_allowed'
    end

    if garage_id == nil then
        return 'garage_null'
    end
    
    if vehicle.owner ~= license then
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

function isLetter(letter)
    for i,v in ipairs(letters) do
        if letter == v then
            return true
        end
    end
    return false
end

function getRandomPlateByGrade(plategrade)
    if plategrade == 0 then
        return getRandomPlate(Config.RandomPlateSchemes.grade_0)
    elseif plategrade == 1 then
        return getRandomPlate(Config.RandomPlateSchemes.grade_1)
    end
end

function getRandomPlate(arg1, arg2)
    local plate = ''
    local example = ''

    local count = 0
    while true do
        count = count + 1
        if count > 10 then return nil end


        plate = ''
        example = ''
        if arg1 == nil then
            arg1 = "11AAA111"
        end

        if arg2 == nil then
            example = arg1
        else
            plate = arg1
            example = arg2
        end

        for i=1,#example do
            if i > 8 or #plate > 8 then
                break
            end
            local v = string.sub(example, i, i)
            if tonumber(v) ~= nil then
                plate = plate .. math.random(0, 9)
            elseif isLetter(v) then
                plate = plate .. letters[math.random(1,#letters)]
            elseif v == ' ' then
                plate = plate .. ' '
            else
                local random = math.random(1,#letters+10)
                if random > 10 then
                    plate = plate .. letters[random-10]
                else
                    plate = plate .. random-1
                end
            end
        end

        if not isPlateExist(plate) then
            return string.upper(plate)
        end
    end

    return nil
end

function isPlateExist(plate, vehicletype)
    local result = 0
    plate = string.upper(plate)
    if vehicletype == nil then
        result = MySQL.Sync.fetchAll("SELECT * FROM `dream_owned_vehicle` WHERE `plate` = @plate" , {
            ['@plate'] = plate,
        })
    else
        result = MySQL.Sync.fetchAll("SELECT * FROM `dream_owned_vehicle` WHERE `plate` = @plate, `type` = @type" , {
            ['@plate'] = plate,
            ['@type'] = vehicletype,
        })

    end

    if #result >= 1 then
        return true
    end
    return false

end


function isIdentifierExist(identifier)
    result = MySQL.Sync.fetchAll("SELECT * FROM `users` WHERE `identifier` = @identifier" , {
        ['@identifier'] = identifier,
    })
    if #result >= 1 then
        return true
    end
    return false
end

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
            ['@garage_id'] = Config.VehicleTypes[type],
            ['@type'] = type,
        })
    end

    if result >= 1 then
        return true
    end

    return false

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