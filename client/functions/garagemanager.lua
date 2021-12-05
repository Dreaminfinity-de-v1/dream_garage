function getVehicleinParkingarea()

    local vehicles = {}
    local garage = getGarageFromId(interactionArea)

    for i, v in ipairs(garage.parking) do
        for i2, v2 in ipairs(ESX.Game.GetVehiclesInArea(v.pos, v.radius)) do
            local found = false
            for i3, v3 in ipairs(vehicles) do
                if v2 == v3 then
                    found = true
                    break
                end
            end
            if not found then
                table.insert( vehicles, v2 )
            end
        end
    end

    if Config.Debugmode.enable == true and Config.Debugmode.notification then
        for i, v in ipairs(vehicles) do
            if GetVehicleNumberPlateText(v) == 'DEBUG 10' or GetVehicleNumberPlateText(v) == 'DEBUG 20' then
                TriggerEvent("swt_notifications:captionIcon",_U('notifications_titel'),_U('notification_message_parkingout_debug_getVehicleinParkingarea', GetVehicleNumberPlateText(v)),
                    Config.Notification.pos,Config.Notification.timeout,Config.Notification.color.debug,'black',true,Config.Notification.icons.debug)
            end
        end
    end

    return vehicles
end

function getOwnedVehiclesInParkingarea(cb, vehicle_types, plate)
    
    ESX.TriggerServerCallback('dream_garage:getOwnedVehicles', function(vehicles)
        local result = {}
        local nearestVehicles = getVehicleinParkingarea()

        for i, v in ipairs(nearestVehicles) do
            for i2, v2 in ipairs(vehicles) do
                if GetVehicleNumberPlateText(v) == v2.plate then
                    for i3, v3 in ipairs(vehicle_types) do
                        if v2.type == v3 then
                            if v2.data.model == GetEntityModel(v) then
                                if plate ~= nil and v2.plate == plate then
                                    cb({ id = v, data = v2 })
                                    return
                                else
                                    table.insert( result, { id = v, data = v2 } )
                                end
                                break
                            end
                        end
                    end
                end
            end
        end

        ESX.TriggerServerCallback('dream_garage:getAllowedVehicles', function(vehicles)

            for i, v in ipairs(nearestVehicles) do
                for i2, v2 in ipairs(vehicles) do
                    if GetVehicleNumberPlateText(v) == v2.plate then
                        for i3, v3 in ipairs(vehicle_types) do
                            if v2.type == v3 then
                                if v2.data.model == GetEntityModel(v) then
                                    if plate ~= nil and v2.plate == plate then
                                        cb({ id = v, data = v2 })
                                        return
                                    else
                                        table.insert( result, { id = v, data = v2 } )
                                    end
                                    break
                                end
                            end
                        end
                    end
                end
            end

            if plate == nil then
                cb(result)
            else
                cb(nil)
            end
        end)       
    end)

end

function getOwnedVehiclesInGarage(cb, garage_id, garage_types)

    if garage_id ~= nil then
    
        ESX.TriggerServerCallback('dream_garage:getOwnedVehicles', function(vehicles)

            local result = {}

            if garage_types ~= nil then
                for _, v in ipairs(vehicles) do
                    for _, v2 in ipairs(garage_types) do
                        if garage_id == v.garage_id and v2 == v.type then
                            table.insert( result, v )
                            break
                        end
                    end
                end
            else
                for i, v in ipairs(vehicles) do
                    if garage_id == v.garage_id then
                        table.insert( result, v )
                    end
                end
            end



            cb(result)
        end)
    else
        cb({})
    end
end

function getAllowedVehiclesInGarage(cb, garage_id, garage_types)

    if garage_id ~= nil then
    
        ESX.TriggerServerCallback('dream_garage:getAllowedVehicles', function(vehicles)

            local result = {}

            if garage_types ~= nil then
                for _, v in ipairs(vehicles) do
                    for _, v2 in ipairs(garage_types) do
                        if garage_id == v.garage_id and v2 == v.type then
                            table.insert( result, v )
                            break
                        end
                    end
                end
            else
                for i, v in ipairs(vehicles) do
                    if garage_id == v.garage_id then
                        table.insert( result, v )
                    end
                end
            end



            cb(result)
        end)
    else
        cb({})
    end
end
