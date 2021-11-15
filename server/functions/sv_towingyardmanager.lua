function getTowingyardVehicles(vehicle_plates)
    local result = {}

    for i,v in ipairs(getAllVehicles()) do
        for i2,v2 in ipairs(vehicle_plates) do
            if v.plate == v2.plate then
                table.insert( result, {data = v, id = v2.id})
            end
        end
    end

    return result
end



function getAllTowingyardVehicles()
    local result = {}

    for i,v in ipairs(getAllVehicles()) do
        for i2,v2 in ipairs(Config.Towingyards) do
            if v.garage_id == v2.id then
                table.insert( result, v)
            end
        end

    end

    return result
end
