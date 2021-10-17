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

function getVehicleinParkingareaOwnedVehicles(cb)
    
    ESX.TriggerServerCallback('dream_garage:getOwnedVehicles', function(vehicles)
        local nearestVehicles = getVehicleinParkingarea()
        local result = {}
        for i, v in ipairs(nearestVehicles) do
            for i2, v2 in ipairs(vehicles) do
                if GetVehicleNumberPlateText(v) == v2.plate then
                    table.insert( result, { id = v, data = v2 } )
                end
            end
        end

        cb(result)
    end)

end

function getOwnedVehiclesInGarage(cb, garage_name)

    if garage_name ~= nil then
    
        ESX.TriggerServerCallback('dream_garage:getOwnedVehicles', function(vehicles)

            local result = {}
            for i, v in ipairs(vehicles) do
                if garage_name == v.garage_name then
                    table.insert( result, v )
                end
            end

            cb(result)
        end)
    else
        cb({})
    end

end

