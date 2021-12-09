function getRandomPlateByGrade(plategrade)
    if Config.RandomPlateSchemes[plategrade] ~= nil then
        return getRandomPlate(Config.RandomPlateSchemes[plategrade].prefix, Config.RandomPlateSchemes[plategrade].scheme)
    end
end

function getRandomPlateByVehicletype(vehicletype)
    local scheme = Config.RandomPlateSchemes[Config.VehicleTypes[vehicletype].default_scheme]
    return getRandomPlate(scheme.prefix, scheme.scheme)

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
                plate = plate .. Config.AllowedPlateChars[math.random(1,#Config.AllowedPlateChars)]
            elseif v == ' ' then
                plate = plate .. ' '
            else
                local random = math.random(1,#Config.AllowedPlateChars+10)
                if random > 10 then
                    plate = plate .. Config.AllowedPlateChars[random-10]
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

function isLetter(letter)
    letter = string.upper(letter)
    for i,v in ipairs(Config.AllowedPlateChars) do
        if letter == v then
            return true
        end
    end
    return false
end

function isPlateExist(plate, vehicletype)
    local result = 0
    plate = string.upper(plate)
    if vehicletype == nil then
        result = MySQL.Sync.fetchAll("SELECT * FROM `dream_owned_vehicles` WHERE `plate` = @plate" , {
            ['@plate'] = plate,
        })
    else
        result = MySQL.Sync.fetchAll("SELECT * FROM `dream_owned_vehicles` WHERE `plate` = @plate, `type` = @type" , {
            ['@plate'] = plate,
            ['@type'] = vehicletype,
        })

    end

    if #result >= 1 then
        return true
    end
    return false

end