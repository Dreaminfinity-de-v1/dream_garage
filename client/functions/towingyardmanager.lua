function getTowingyardVehiclesInParkingarea(cb, vehicle_types, plate)
    local vehicle_plates = {}

    for i,v in ipairs(getVehicleinParkingarea()) do
        table.insert(vehicle_plates, {plate = GetVehicleNumberPlateText(v), id = v})
    end

    ESX.TriggerServerCallback('dream_garage:getTowingyardVehicles', function(vehicles)
        local result = {}
        for i, v in ipairs(vehicles) do
            print(v.data.data.model)
            print(v.id)
            print(GetEntityModel(v.id))
            print(v.data.data.model == GetEntityModel(v.id))
            if v.data.data.model == GetEntityModel(v.id) then
                if plate == nil then
                    table.insert( result, v )
                else
                    if v.data.plate == plate then
                        cb(v)
                        return
                    end
                end
            end
        end
        
        if plate == nil then
            cb(result)
        else
            cb(nil)
        end

    end, vehicle_plates)
end